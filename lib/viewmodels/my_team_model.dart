import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/all_absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/ext_task_data.dart';
import 'package:kzm/core/models/bpm/form_data.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/bpm/process_instance_data.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/person/person_profile.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/my_team/my_team_single_page_view.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

import '../core/service/kinfolk/global_variables.dart';
import '../generated/l10n.dart';

const String fName = 'lib/viewmodels/my_team_model.dart';

class MyTeamModel extends BaseModel {
  List<MyTeamNew> children;
  MyTeamNew child;
  UserInfo userInfo;
  List<File> pickerFiles;
  List<Map<String, dynamic>> treeData;
  PersonProfile personProfile;
  List<Absence> absenceList;
  List<AllAbsenceRequest> allAbsence;
  List<ExtTaskData> tasks;
  int activeTabIndex = 0;
  BpmFormData formData;
  List<NotPersisitBprocActors> notPersisitBprocActors;
  BpmRolesDefiner bpmRolesDefiner;
  bool successSaved = false;
  List<FileDescriptor> files = [];
  PersonGroup employee;
  AbstractDictionary company;
  ProcessInstanceData processInstanceData;
  List<DicAbsenceType> absenceTypesForManager;
  DicAbsenceType selectedAbsenceType;
  String personGroupId;

  Future<void> downloadEmployeeProfile({
    @required BuildContext context,
  }) async {
    String _fileName;
    try {
      // await kzmLog(fName: fName, func: 'RestServices().getReportData', text: 'start');
      setBusy(true);
      const String templateCode = 'docx';
      final String _prefix = (GlobalVariables.lang ?? 'en').toUpperCase();
      _fileName = await RestServices().getReportData(
        codeValue: 'PROFILE_TD_$_prefix',
        templateCode: templateCode,
        parameters: <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'person',
            'value': personProfile?.id,
          },
        ],
      );
      setBusy(false);
      // await kzmLog(fName: fName, func: 'RestServices().getReportData', text: 'end');
      final OpenResult result = await OpenFile.open(_fileName);
      switch (result.type) {
        case ResultType.noAppToOpen:
          GlobalNavigator().errorBar(title: '${S.current.noAppToOpen} $templateCode');
          break;
        case ResultType.fileNotFound:
          GlobalNavigator().errorBar(title: '${S.current.fileNotFound} $_fileName');
          break;
        case ResultType.permissionDenied:
          GlobalNavigator().errorBar(title: '${S.current.permissionDenied} $_fileName');
          break;
        case ResultType.error:
          GlobalNavigator().errorBar(title: S.current.unknownError);
          break;
        case ResultType.done:
          break;
      }
    } catch (e, s) {
      log('-->> $fName, downloadEmployeeProfile -->> error!', error: e, stackTrace: s);
    }
  }

  Future<List<MyTeamNew>> get getChildren async {
    final PersonGroup personGroup = await RestServices.getPersonGroupForAssignment() as PersonGroup;

    final String parentPositionGroupId = personGroup.currentAssignment?.positionGroup?.id;

    children ??= await RestServices.getChildrenForTeamService(parentPositionGroupId: parentPositionGroupId);
    return children;
  }

  // Future getUserInfo() async {
  //   userInfo ??= await RestServices.getUserInfo();
  //   return userInfo;
  // }

  Future<String> get getPgID async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    personGroupId = id;
    return personGroupId;
  }

  Future get getCompany async {
    // var a = await HiveUtils.getSettingsBox();
    // var id = a.get('pgId');
    company = await RestServices.getCompanyByPersonGroupId(/*personGroupId: id*/);
    return company;
  }

  Future<List<DicAbsenceType>> get getAbsenceTypesForManager async {
    absenceTypesForManager = await RestServices.getAbsenceTypesForManager();
    return absenceTypesForManager;
  }

  Future<List<AllAbsenceRequest>> getAllAbsence({bool update = false}) async {
    if (allAbsence == null || update) {
      // print(allAbsence?.length);
      allAbsence = await RestServices.getAllAbsenceByPersonGroupId();
      setBusy();
      // print(allAbsence.length);
    }
    return allAbsence;
  }

  // Future<List<ScheduleRequest>> get getScheduleRequest async {
  //   scheduleRequest = await RestServices.getAbsencesSchedulePersonGroupId(
  //       id: child.personGroupId);
  //   return scheduleRequest;
  // }
  //
  // Future<List<AssignmentSchedule>> get getAssignmentSchedule async {
  //   assignmentSchedule = await RestServices.getAssignmentSchedule(
  //       personGroupId: child.personGroupId);
  //   return assignmentSchedule;
  // }

  Future<List<Absence>> get getAbsences async {
    absenceList = await RestServices.getAbsencesByPersonGroupId(id: child.personGroupId);
    return absenceList;
  }

  Future<PersonProfile> getProfileByPersonGroupId() async {
    setBusy(true);
    personProfile = await RestServices.getPersonProfileByPersonGroupId(pgId: child.personGroupId);
    // await getAllAbsence;
    // await getAbsences;
    // await getPersonGroupById();
    setBusy(false);
    return personProfile;
  }

  Future<PersonGroup> getPersonGroupById() async {
    employee = await RestServices.getPersonGroupById(pgId: child.personGroupId);
    // harmfulCondition = await RestServices.getPositionHarmfulConditionByPG(
    //     pgId: employee.currentAssignment.positionGroup.id);
    // checkHarmfulCondition();
    return employee;
  }

  // Future completeWithOutcomeForRecall(
  //     {String comment,
  //     @required String outcomeId,
  //     @required ExtTaskData currentTask}) async {
  //   var translation = S.of(Get.overlayContext);
  //   if (outcomeId != "REVISION" &&
  //       outcomeId != "REJECT" &&
  //       absenceForRecall?.employee?.id == personGroupId) {
  //     await RestServices.updateEntity(
  //         entityName: "tsadv_AbsenceForRecall",
  //         entityId: absenceForRecall.id,
  //         entity: absenceForRecall);
  //   }
  //   setBusy(true);
  //   var response = await RestServices.completeWithOutcome(
  //       outcomeId: outcomeId, currentTask: currentTask, comment: comment);
  //   setBusy(false);
  //   Get.back();
  //   Get.snackbar(translation.attention, translation.success);
  // }

  // Future completeWithOutcomeForRvdAbsence(
  //     {String comment,
  //       @required String outcomeId,
  //       @required ExtTaskData currentTask}) async {
  //   var translation = S.of(Get.overlayContext);
  //   if (outcomeId != "REVISION" &&
  //       outcomeId != "REJECT" &&
  //       absenceRvdRequest.employee.id == personGroupId) {
  //     bool res = await RestServices.updateEntity(
  //         entityName: "tsadv_AbsenceRvdRequest",
  //         entityId: absenceRvdRequest.id,
  //         entity: absenceRvdRequest);
  //   }
  //   setBusy(true);
  //   var response = await RestServices.completeWithOutcome(
  //       outcomeId: outcomeId, currentTask: currentTask, comment: comment);
  //   setBusy(false);
  //   Get.back();
  //   Get.snackbar(translation.attention, translation.success);
  // }

  // Future completeWithOutcomeForScheduleRequest(
  //     {String comment,
  //       @required String outcomeId,
  //       @required ExtTaskData currentTask}) async {
  //   var translation = S.of(Get.overlayContext);
  //   if (outcomeId != "REVISION" &&
  //       outcomeId != "REJECT" &&
  //       scheduleRvdRequest.personGroup.id == personGroupId) {
  //     bool res = await RestServices.updateEntity(
  //         entityName: "tsadv_ScheduleOffsetsRequest",
  //         entityId: scheduleRvdRequest.id,
  //         entity: scheduleRvdRequest);
  //   }
  //   setBusy(true);
  //   var response = await RestServices.completeWithOutcome(
  //       outcomeId: outcomeId, currentTask: currentTask, comment: comment);
  //   setBusy(false);
  //   Get.back();
  //   Get.snackbar(translation.attention, translation.success);
  // }

  // Future completeWithOutcomeChangeDays(
  //     {String comment,
  //     @required String outcomeId,
  //     @required ExtTaskData currentTask}) async {
  //   var translation = S.of(Get.overlayContext);
  //   if (outcomeId != "REVISION" &&
  //       outcomeId != "REJECT" &&
  //       changeAbsenceDaysRequest.employee.id == personGroupId) {
  //     bool res = await RestServices.updateEntity(
  //         entityName: "tsadv_ChangeAbsenceDaysRequest",
  //         entityId: changeAbsenceDaysRequest.id,
  //         entity: changeAbsenceDaysRequest);
  //   }
  //   setBusy(true);
  //   var response = await RestServices.completeWithOutcome(
  //       outcomeId: outcomeId, currentTask: currentTask, comment: comment);
  //   setBusy(false);
  //   Get.back();
  //   Get.snackbar(translation.attention, translation.success);
  // }

  // Future get getNewAbsenceForRecall async {
  //   absenceForRecall = await RestServices.getNewAbsenceForRecall(
  //       // entityName: 'tsadv_AbsenceForRecall', entity: absenceForRecall
  //       );
  //   absenceForRecall.id = null;
  //   absenceForRecall.requestDate = DateTime.now();
  //   absenceForRecall.employee = employee;
  //   absenceForRecall.vacation = selectedAbsence;
  //   absenceForRecall.absenceType = selectedAbsence.type;
  //   absenceForRecall.compensationPayment = true;
  //   absenceForRecall.leaveOtherTime = false;
  //   return absenceForRecall;
  // }

  // Future get getNewAbsenceSchedule async {
  //   scheduleRvdRequest = await RestServices.getNewAbsenceScheduleRequest();
  //   //  scheduleRvdRequest.id = null;
  //   scheduleRvdRequest.personGroup = employee;
  //   return scheduleRvdRequest;
  // }

  // Future get getNewAbsenceRvd async {
  //   absenceRvdRequest = await RestServices.getNewAbsenceRvdRequest();
  //   company = await RestServices.getCompanyByPersonGroupId();
  //   absenceRvdRequest.employee = employee;
  //   return absenceRvdRequest;
  // }

  // Future get getChangeAbsenceDaysRequest async {
  //   changeAbsenceDaysRequest = await RestServices.getChangeAbsenceDaysRequest(
  //       // entityName: "tsadv_ChangeAbsenceDaysRequest",
  //       // entity: changeAbsenceDaysRequest
  //       );
  //   changeAbsenceDaysRequest.id = null;
  //   changeAbsenceDaysRequest.requestDate = DateTime.now();
  //   changeAbsenceDaysRequest.employee = employee;
  //   changeAbsenceDaysRequest.vacation = selectedAbsence;
  //   changeAbsenceDaysRequest.scheduleStartDate = selectedAbsence.dateFrom;
  //   changeAbsenceDaysRequest.scheduleEndDate = selectedAbsence.dateTo;
  //   return changeAbsenceDaysRequest;
  // }

  // Future getRolesDefinerAndNotRersisitActorsForChangeDays() async {
  //   var checkRequired = await checkRequiredFieldsChangeDays();
  //   notPersisitBprocActors = null;
  //   if (!checkRequired) {
  //     return;
  //   } else {
  //     bpmRolesDefiner = await RestServices.getBpmRolesDefiner(
  //         processDefinitionKey: "changeAbsenceDaysRequest", employeePersonGroupId: child.personGroupId, isAssistant: false);
  //     notPersisitBprocActors = await RestServices.getNotPersisitBprocActors(
  //         employeePersonGroupId: child.personGroupId, bpmRolesDefiner: bpmRolesDefiner, isAssistant: false);
  //   }
  // }

  // Future getRolesDefinerAndNotRersisitActorsForRecall() async {
  //   if (!checkRequiredFieldsForRecall()) return;
  //   notPersisitBprocActors = null;
  //   bpmRolesDefiner = await RestServices.getBpmRolesDefiner(
  //       isAssistant: false,
  //       employeePersonGroupId: child.personGroupId,
  //       processDefinitionKey: "absenceForRecallRequest");
  //   notPersisitBprocActors = await RestServices.getNotPersisitBprocActors(
  //       employeePersonGroupId: child.personGroupId, bpmRolesDefiner: bpmRolesDefiner, isAssistant: false,);
  // }

  // Future getRolesDefinerAndNotRersisitSchedule() async {
  //   if (!checkRequiredFieldsSchedule()) return;
  //   bpmRolesDefiner = await RestServices.getBpmRolesDefiner(
  //       processDefinitionKey: "scheduleOffsetsRequest",
  //       isAssistant: false,
  //       employeePersonGroupId: child.personGroupId);
  //   notPersisitBprocActors = await RestServices.getNotPersisitBprocActors(
  //       employeePersonGroupId: child.personGroupId, bpmRolesDefiner: bpmRolesDefiner, isAssistant: false);
  // }

  // Future getRolesDefinerAndNotRersisitAbsenceRvd() async {
  //   if (!checkRequiredFieldsRvd()) return;
  //   bpmRolesDefiner = await RestServices.getBpmRolesDefiner(
  //       processDefinitionKey: "absenceRvdRequest",
  //       employeePersonGroupId: child.personGroupId,
  //       isAssistant: false);
  //   notPersisitBprocActors = await RestServices.getNotPersisitBprocActors(
  //       employeePersonGroupId: child.personGroupId, bpmRolesDefiner: bpmRolesDefiner, isAssistant: false);
  // }

  Future<MyTeamNew> getChild({String parentPositionGroupId}) async {
    // child ??= await RestServices.getChildrenForTeamService(parentPositionGroupId: parentPositionGroupId);
    return child;
  }

  // Future getProcessInstanceData(
  //     {@required String entityId, String definitionKey}) async {
  //   processInstanceData = null;
  //   setBusy(true);
  //   await getPgID;
  //   processInstanceData = await RestServices.getProcessInstanceData(
  //       processInstanceBusinessKey: entityId,
  //       processDefinitionKey: definitionKey);
  //   if (processInstanceData != null) {
  //     tasks = await RestServices.getProcessTasks(
  //         processInstanceData: processInstanceData);
  //     formData = await RestServices.getTaskFormData(taskId: tasks.last.id);
  //   } else {
  //     tasks = null;
  //     formData = null;
  //   }
  //   setBusy(false);
  //   return processInstanceData;
  // }

  // Future saveAbsenceForRecall() async {
  //   setBusy(true);
  //   var translation = S.of(Get.overlayContext);
  //
  //   if (absenceForRecall.id == null &&
  //       pickerFiles != null &&
  //       pickerFiles.isNotEmpty) {
  //     for (int i = 0; i < pickerFiles.length; i++) {
  //       await saveAttach(pickerFiles[i]);
  //     }
  //     absenceForRecall.files = files;
  //     print('absenceForRecall.files');
  //     print(absenceForRecall.files);
  //   }
  //
  //   successSaved = false;
  //   if (absenceForRecall.id == null) {
  //     absenceForRecall.id = await RestServices.createAndReturnId(
  //         entityName: 'tsadv_AbsenceForRecall', entity: absenceForRecall);
  //     if (absenceForRecall.id != null) {
  //       successSaved = true;
  //     } else {
  //       setBusy(false);
  //       successSaved = false;
  //       Get.snackbar(translation.attention, "При сохранение заявка ошибка");
  //     }
  //   } else {
  //     successSaved = true;
  //     setBusy(false);
  //   }
  // }
  //
  // Future saveChangeAbsenceDaysRequest() async {
  //   setBusy(true);
  //   var translation = S.of(Get.overlayContext);
  //
  //   if (changeAbsenceDaysRequest.id == null &&
  //       pickerFiles != null &&
  //       pickerFiles.isNotEmpty) {
  //     for (int i = 0; i < pickerFiles.length; i++) {
  //       await saveAttach(pickerFiles[i]);
  //     }
  //     changeAbsenceDaysRequest.file = files;
  //   }
  //
  //   successSaved = false;
  //   if (changeAbsenceDaysRequest.id == null) {
  //     changeAbsenceDaysRequest.id = await RestServices.createAndReturnId(
  //         entityName: 'tsadv_ChangeAbsenceDaysRequest',
  //         entity: changeAbsenceDaysRequest);
  //     if (changeAbsenceDaysRequest.id != null) {
  //       setBusy(false);
  //       successSaved = true;
  //       return changeAbsenceDaysRequest.id;
  //     } else {
  //       setBusy(false);
  //       successSaved = false;
  //       Get.snackbar(translation.attention, "При сохранение заявка ошибка");
  //     }
  //   } else {
  //     successSaved = true;
  //     setBusy(false);
  //   }
  // }

  // Future saveAbsenceSchedule() async {
  //   setBusy(true);
  //   var translation = S.of(Get.overlayContext);
  //   if (scheduleRvdRequest.id == "") {
  //     scheduleRvdRequest.id = await RestServices.createAndReturnId(
  //         entityName: "tsadv_ScheduleOffsetsRequest",
  //         entity: scheduleRvdRequest);
  //     if (scheduleRvdRequest.id != null) {
  //       setBusy(false);
  //       successSaved = true;
  //     } else {
  //       setBusy(false);
  //       successSaved = false;
  //       Get.snackbar(translation.attention, "При сохранение заявка ошибка");
  //     }
  //   } else {
  //     successSaved = true;
  //     setBusy(false);
  //   }
  // }

  // Future saveAbsenceRvd() async {
  //   setBusy(true);
  //   var translation = S.of(Get.overlayContext);
  //   if (absenceRvdRequest.id == "" &&
  //       pickerFiles != null &&
  //       pickerFiles.isNotEmpty) {
  //     for (int i = 0; i < pickerFiles.length; i++) {
  //       await saveAttach(pickerFiles[i]);
  //     }
  //      absenceRvdRequest.files = files;
  //   }
  //   successSaved = false;
  //   if (absenceRvdRequest.id == "") {
  //     absenceRvdRequest.id = await RestServices.createAndReturnId(
  //         entityName: 'tsadv_AbsenceRvdRequest', entity: absenceRvdRequest);
  //     if (absenceRvdRequest.id != null) {
  //       setBusy(false);
  //       successSaved = true;
  //     } else {
  //       setBusy(false);
  //       successSaved = false;
  //       Get.snackbar(translation.attention, "При сохранение заявка ошибка");
  //     }
  //   } else {
  //     successSaved = true;
  //     setBusy(false);
  //   }
  // }

  Future saveAttach(File file) async {
    final FileDescriptor response = await RestServices.saveFile(file: file);
    files.add(response);
    return response;
  }

  // Future saveBprocActorsForChangeDays() async {
  //   var id = await saveChangeAbsenceDaysRequest();
  //   setBusy(true);
  //   if (id != null) {
  //     SaveBprocActors bprocActors = SaveBprocActors();
  //     bprocActors.notPersisitBprocActors = notPersisitBprocActors;
  //     bprocActors.entityId = changeAbsenceDaysRequest.id;
  //     await RestServices.saveBprocActors(bprocActors: bprocActors);
  //
  //     VariablesForChangeDaysAbsence variables = VariablesForChangeDaysAbsence();
  //     variables.rolesLinks = bpmRolesDefiner.links;
  //     variables.entity = changeAbsenceDaysRequest;
  //     BprocRuntimeServiceForChangeDays runtimeService =
  //         BprocRuntimeServiceForChangeDays();
  //     runtimeService.variables = variables;
  //     runtimeService.processDefinitionKey = "changeAbsenceDaysRequest";
  //     runtimeService.businessKey = changeAbsenceDaysRequest.id;
  //     var bprocRuntimeService =
  //         await RestServices.startProcessInstanceByKeyForChangeDays(
  //             bprocRuntimeService: runtimeService);
  //     if (bprocRuntimeService != null) {
  //       setBusy(false);
  //       Get.back();
  //       var translation = S.of(Get.overlayContext);
  //       Get.snackbar(translation.attention, translation.success);
  //     }
  //     return bprocRuntimeService;
  //   }
  // }
  //
  // Future saveBprocActorsForRecall() async {
  //   await saveAbsenceForRecall();
  //   if (absenceForRecall.id != null) {
  //     SaveBprocActors bprocActors = SaveBprocActors();
  //     bprocActors.notPersisitBprocActors = notPersisitBprocActors;
  //     bprocActors.entityId = absenceForRecall.id;
  //     await RestServices.saveBprocActors(bprocActors: bprocActors);
  //     VariablesForAbsenceForRecall variables = VariablesForAbsenceForRecall();
  //     variables.rolesLinks = bpmRolesDefiner.links;
  //     variables.entity = absenceForRecall;
  //     BprocRuntimeServiceForRecall runtimeService =
  //         BprocRuntimeServiceForRecall();
  //     runtimeService.variables = variables;
  //     runtimeService.processDefinitionKey = "absenceForRecallRequest";
  //     runtimeService.businessKey = absenceForRecall.id;
  //     var bprocRuntimeService =
  //         await RestServices.startProcessInstanceByKeyForRecallAbsence(
  //             bprocRuntimeService: runtimeService);
  //     if (bprocRuntimeService != null) {
  //       setBusy(false);
  //       Get.back();
  //       var translation = S.of(Get.overlayContext);
  //       Get.snackbar(translation.attention, translation.success);
  //     }
  //     return bprocRuntimeService;
  //   }
  //   setBusy(false);
  // }
  //
  // Future saveBprocActorsSchedule() async {
  //   await saveAbsenceSchedule();
  //   if (scheduleRvdRequest.id != null) {
  //     SaveBprocActors bprocActors = SaveBprocActors();
  //     bprocActors.notPersisitBprocActors = notPersisitBprocActors;
  //     bprocActors.entityId = scheduleRvdRequest.id;
  //     await RestServices.saveBprocActors(bprocActors: bprocActors);
  //     VariablesForAbsenceSchedule variables = VariablesForAbsenceSchedule();
  //     variables.rolesLinks = bpmRolesDefiner.links;
  //     variables.entity = scheduleRvdRequest;
  //     BprocRuntimeServiceSchedule runtimeService =
  //         BprocRuntimeServiceSchedule();
  //     runtimeService.variables = variables;
  //     runtimeService.processDefinitionKey = "scheduleOffsetsRequest";
  //     runtimeService.businessKey = scheduleRvdRequest.id;
  //     var bprocRuntimeService =
  //         await RestServices.startProcessInstanceByKeySchedule(
  //             bprocRuntimeService: runtimeService);
  //     if (bprocRuntimeService != null) {
  //       Get.back();
  //       var translation = S.of(Get.overlayContext);
  //       Get.snackbar(translation.attention, translation.success);
  //     }
  //     return bprocRuntimeService;
  //   }
  // }

  // Future openAbsenceForRecallById (String id) async {
  //   // setBusy(true);
  //   // absenceForRecall = await RestServices.getEntityById(entityId: id);
  //   // setBusy(false);
  //   // if(absenceForRecall.id != null && absenceForRecall.id != ''){
  //   //   await getUserInfo();
  //   //   await getProcessInstanceData(entityId: id, definitionKey: "absenceForRecallRequest");
  //   //   print(processInstanceData);
  //   //   Get.to(() => ChangeNotifierProvider.value(
  //   //     value: this,
  //   //     child: AbsenceForRecallForm(),)
  //   //   );
  //   // }
  // }

  // Future openChangeAbsenceDaysById (String id) async {
  //   setBusy(true);
  //   changeAbsenceDaysRequest = await RestServices.getChangeAbsenceDaysById(entityId: id);
  //   setBusy(false);
  //   if(changeAbsenceDaysRequest.id != null){
  //     await getUserInfo();
  //     await getProcessInstanceData(entityId: id, definitionKey: "changeAbsenceDaysRequest");
  //     Get.to(() => ChangeNotifierProvider.value(
  //       value: this,
  //       child: ChangeAbsenceDaysRequestForm(),)
  //     );
  //   }
  // }

  // bool checkChangeAbsenceDaysRequest(Absence request) {
  //   if (request.type.availableForRecallAbsence &&
  //       request.type.useInSelfService &&
  //       request.type.availableForChangeDate) {
  //     if (DateTime.now().isBefore(request.dateFrom)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // bool checkRequiredFieldsSchedule() {
  // var translation = S.of(Get.overlayContext);
  // if (scheduleRvdRequest.dateOfNewSchedule == null ||
  //     scheduleRvdRequest.dateOfStartNewSchedule == null ||
  //     scheduleRvdRequest.earningPolicy == null ||
  //     scheduleRvdRequest.newSchedule == null) {
  //   successSaved = false;
  //   setBusy(false);
  //   Get.snackbar(translation.attention, translation.fillRequiredFields);
  //   return false;
  // }
  // return true;
  // }

  // bool checkRequiredFieldsRvd() {
  //   var translation = S.of(Get.overlayContext);
  //   if (absenceRvdRequest.timeOfStarting == null ||
  //       absenceRvdRequest.timeOfFinishing == null ||
  //       absenceRvdRequest.type == null ||
  //       absenceRvdRequest.absencePurpose == null) {
  //     successSaved = false;
  //     setBusy(false);
  //     Get.snackbar(translation.attention, translation.fillRequiredFields);
  //     return false;
  //   }
  //   return true;
  // }

//   bool checkRequiredFieldsForRecall() {
//     var translation = S.of(Get.overlayContext);
//
//     if (absenceForRecall.requestNumber == null ||
//         absenceForRecall.status == null ||
//         absenceForRecall.requestDate == null ||
//         absenceForRecall.absenceType == null ||
//         absenceForRecall.employee == null ||
//         absenceForRecall.vacation == null ||
//         absenceForRecall.recallDateFrom == null ||
//         absenceForRecall.recallDateTo == null
//         // ||
//         // absenceForRecall.purpose == null
//     ) {
//       setBusy(false);
//       Get.snackbar(translation.attention, translation.fillRequiredFields);
//       return false;
//     }
//
//     if (absenceForRecall.leaveOtherTime &&
//         (absenceForRecall.dateTo == null || absenceForRecall.dateTo == null)) {
//       setBusy(false);
//       Get.snackbar(translation.attention, translation.fillRequiredFields);
//       return false;
//     }
//
//     // if (absenceForRecall.purpose.code == "OTHER" &&
//     //     (absenceForRecall.purposeText == null ||
//     //         absenceForRecall.purposeText == "")) {
//     //   setBusy(false);
//     //   Get.snackbar(translation.attention, translation.fillRequiredFields);
//     //   return false;
//     // }
//
//     if (absenceForRecall.recallDateFrom
//         .isAfter(absenceForRecall.recallDateTo)) {
//       setBusy(false);
//       Get.snackbar(translation.attention, "Дата отзыва не корректна");
//       return false;
//     }
//
//     if (absenceForRecall.leaveOtherTime &&
//         absenceForRecall.dateFrom.isAfter(absenceForRecall.dateTo)) {
//       setBusy(false);
//       Get.snackbar(
//           translation.attention, "Даты неиспользованной части не корректна");
//       return false;
//     }
//
//     if (absenceForRecall.leaveOtherTime &&
//         absenceForRecall.recallDateFrom.isAfter(absenceForRecall.dateFrom)) {
//       setBusy(false);
//       Get.snackbar(translation.attention,
//           '"Дата неиспользованной части с"  не может быть меньше "Дата отзыва по"');
//       return false;
//     }
//
//     if (absenceForRecall.leaveOtherTime) {
//       int recallDays = absenceForRecall.recallDateTo
//           .difference(absenceForRecall.recallDateFrom)
//           .inDays;
//       int day2 =
//           absenceForRecall.dateTo.difference(absenceForRecall.dateFrom).inDays;
//       if (recallDays < day2) {
//         setBusy(false);
//         Get.snackbar(translation.attention,
//             'Количество дней превышает недогуленный отпуск');
//         return false;
//       }
//     }
//
//     if (absenceForRecall.leaveOtherTime) {
// // "Дата неиспользованной части по" не может быть меньше "Дата неиспользованной части с"
//
//     }
//     // setBusy(false);
//     // Get.snackbar(translation.attention, 'Успешно');
//     // return false;
//     return true;
//   }

  // //Проверка есть ли вредний должность
  // bool checkHarmfulCondition() {
  //   final birthday = personProfile?.birthDate;
  //   final date2 = DateTime.now();
  //   final difference = date2.difference(birthday).inDays / 365;
  //
  //   if (difference > 18) {
  //     var harmful;
  //     if (harmfulCondition.isNotEmpty) {
  //       var list = harmfulCondition.where((element) {
  //         var dateTime = DateTime.now();
  //         return dateTime.isBefore(element.endDate) &&
  //             dateTime.isAfter(element.startDate);
  //       });
  //       if (list.isNotEmpty) {
  //         harmful = list.first;
  //       }
  //     }
  //     if (harmful != null) {
  //       isHarmfulCondition = false;
  //       return false;
  //     } else {
  //       isHarmfulCondition = true;
  //       return true;
  //     }
  //   } else {
  //     isHarmfulCondition = false;
  //     return false;
  //   }
  // }

  // Future<void> createAbsence(DicAbsenceType type) async {
  //   if (type.code == "RECALL"){
  //     print("s");
  //     await getNewAbsenceForRecall;
  //     print(absenceForRecall.instanceName);
  //     Get.to(ChangeNotifierProvider.value(
  //       value: this,
  //       child: AbsenceForRecallForm(),
  //     ));
  //   } else if (type.code == "") {
  //
  //   } else {
  //     Get.to(ChangeNotifierProvider.value(
  //       value: this,
  //       child: DefaultAbsenceForm(),
  //     ));
  //   }
  //
  // }

  // bool validateOutcomeById({String id, bool isAgree, bool isFamiliarization}) {
  //   //REJECT
  //   //REVISION
  //   if (isAgree && isFamiliarization) {
  //     return true;
  //   }
  //   var translation = S.of(Get.overlayContext);
  //   if (id != "REVISION" && id != "REJECT") {
  //     if (!isAgree) {
  //       Get.snackbar(translation.attention,
  //           "Для утверждения необходимо поставить галочку «Согласен»");
  //       return false;
  //     }
  //     if (!isFamiliarization) {
  //       Get.snackbar(translation.attention,
  //           "Для утверждения необходимо поставить галочку «Ознакомлен»");
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  Future onSelected({MyTeamNew root, BuildContext context}) async {
    child = root;
    await getProfileByPersonGroupId();

    //setTeamPersonData
    // Provider.of<AbsenceForRecallModel>(context, listen: false).employee = employee;
    // Provider.of<AbsenceForRecallModel>(context, listen: false).child = child;
    // Provider.of<AbsenceForRecallModel>(context, listen: false).personProfile = personProfile;

    // Provider.of<ScheduleRequestModel>(context, listen: false).employee = employee;
    // Provider.of<ScheduleRequestModel>(context, listen: false).child = child;
    // // Provider.of<ScheduleRequestModel>(context, listen: false).personProfile = personProfile;
    //
    // Provider.of<ChangeAbsenceModel>(context, listen: false).employee = employee;
    // Provider.of<ChangeAbsenceModel>(context, listen: false).child = child;
    // // Provider.of<ChangeAbsenceModel>(context, listen: false).personProfile = personProfile;
    // Provider.of<AbsenceRvdModel>(context, listen: false).employee = employee;
    // Provider.of<AbsenceRvdModel>(context, listen: false).child = child;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) =>ChangeNotifierProvider.value(
          value: this,
          child: MyTeamSinglePageView(),
        ),
      ),
    );
  }
}
