// ignore_for_file: join_return_with_assignment

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/ext_task_data.dart';
import 'package:kzm/core/models/bpm/form_data.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/bpm/process_instance_data.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:kzm/viewmodels/hr_requests.dart';

import '../../core/components/widgets/snackbar.dart';

const String fName = 'lib/viewmodels/bpm_requests/abstract_bpm_model.dart';

abstract class AbstractBpmModel<T extends AbstractBpmRequest> extends BaseModel {
  T request;
  List<T> requestList;
  MyTeamNew child;
  bool showSaveRequestButton = false;
  bool showGetReportButton = false;

  UserInfo userInfo;
  AbstractDictionary company;
  String pgId;

  List<NotPersisitBprocActors> notPersisitBprocActors;
  BpmRolesDefiner bpmRolesDefiner;
  List<ExtTaskData> tasks;
  BpmFormData formData;
  ProcessInstanceData processInstanceData;
  void Function() refreshData;

  // Function refr;

  // bool get isEditable => !(request?.id != null && tasks != null && request.status?.code != statusCodeToBeRevised);
  bool get isEditable => !(request?.id != null && tasks != null && request.status?.id != toBeRevisedID);

  Future<List<T>> getRequests();

  // Future<void> saveRequest();
  Future<void> saveRequest() async {
    // log('-->> $fName, saveRequest ->> request: ${request.toJson()}');
    if (!(await checkValidateRequest())) return;
    try {

      request.employee = PersonGroup(id: child.personGroupId);
      setBusy(true);
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
        entity: request,
      );
      refreshData();
      setBusy(false);
      if (request?.id == null) {
        log('-->> $fName, saveRequest -->> saveRequest error: ${request.toString()}');
        await KzmSnackbar(message: S.current.saveRequestError).show();
      }
    } catch (e, s) {
      setBusy(false);
      log('-->> $fName, saveRequest -->> saveRequest error!', error: e, stackTrace: s);
      await KzmSnackbar(message: S.current.saveRequestError).show();
    }
  }

  Future<void> getReport();

  Future<void> onRefreshList();

  Future<void> getRequestDefaultValue();

  //Сохранение файл
  Future<FileDescriptor> saveAttach(File file) async {
    return await RestServices.saveFile(file: file);
  }

  Future saveFilesToEntity({File picker, List<File> multiPicker});

  ///Валидация для обязательные поля
  Future<bool> checkValidateRequest();

  Future getUserInfo() async {
    userInfo = await RestServices.getUserInfo();
    return userInfo;
  }

  Future<String> getPersonGroupId() async {
    final Box settings = await HiveUtils.getSettingsBox();
    pgId = settings.get('pgId') as String;
    return pgId;
  }

  Future<void> openRequestById(String id, {bool isRequestID = false});

  Future completeWithOutcome({
    @required String outcomeId,
    @required ExtTaskData currentTask,
    String comment,
    HrRequestModel hrRequestModel,
  }) async {
    setBusy(true);
    final S translation = S.current;
    await getPersonGroupId();
    request.status.id = outcomeId;
    await RestServices.completeWithOutcome(outcomeId: outcomeId, currentTask: currentTask, comment: comment);
    if (outcomeId != 'REVISION' && outcomeId != 'REJECT' && request?.employee?.id == pgId) {
      if (outcomeId == 'CANCEL') {
        request.status.id = '8d90dcc6-8564-1fab-79f7-7ee9c5acefc8';
      }

      await RestServices.updateEntity(entityName: request.getEntityName, entityId: request.id, entity: request);
    }
    if (hrRequestModel != null && outcomeId == 'CANCEL') {
      // await Future.delayed(const Duration(seconds: 5));
      await hrRequestModel.getHistories(update: true);
    }
    setBusy(false);
    GlobalNavigator.pop();
    GlobalNavigator.successSnackbar();
  }

  // String employeePersonGroupId();

  Future<void> getRolesDefinerAndNotRersisitActors() async {
    notPersisitBprocActors = null;
    setBusy(true);
    final bool validate = await checkValidateRequest();
    if (!validate) {
      setBusy(false);
      return;
    } else {
      final UserInfo userInfoId = await RestServices.getUserInfo();
      pgId = await RestServices.getPersonGroupId(userInfoId);
      bpmRolesDefiner = await RestServices.getBpmRolesDefiner(
        processDefinitionKey: request.getProcessDefinitionKey,
        employeePersonGroupId: child?.personGroupId ?? pgId,
        isAssistant: false,
        request: request,
      ) as BpmRolesDefiner;
      notPersisitBprocActors = (await RestServices.getNotPersisitBprocActors(
        bpmRolesDefiner: bpmRolesDefiner,
        isAssistant: false,
        employeePersonGroupId: child?.personGroupId ?? pgId,
        request: request,
      ))
          .where((NotPersisitBprocActors e) => (e.users != null) && (e.users.isNotEmpty))
          .toList();
      setBusy(false);
    }
  }

  Future<void> saveBprocActors() async {
    if (request.id == null || request.id.isEmpty) {
      await saveRequest();
    }
    if (request.id != null || request.id != '') {
      setBusy(true);
      final UserInfo userInfoId = await RestServices.getUserInfo();
      pgId = await RestServices.getPersonGroupId(userInfoId);
      final SaveBprocActors bprocActors = SaveBprocActors();
      bprocActors.notPersisitBprocActors = notPersisitBprocActors;
      bprocActors.entityId = request.id;
      await RestServices.saveBprocActors(bprocActors: bprocActors);
      final Variables variables = Variables();
      variables.rolesLinks = bpmRolesDefiner.links;
      variables.entity = request;
      variables.employeePersonGroupId = pgId;
      variables.isAssistant = false;
      final BprocRuntimeService runtimeService = BprocRuntimeService();
      runtimeService.variables = variables;
      runtimeService.processDefinitionKey = request.getProcessDefinitionKey;
      runtimeService.businessKey = request.id;

      final BprocRuntimeService bprocRuntimeService = await RestServices.startProcessInstanceByKey(bprocRuntimeService: runtimeService);
      setBusy(false);
      if (bprocRuntimeService != null) {
        GlobalNavigator.pop();
        GlobalNavigator.successSnackbar();
      }
      return bprocRuntimeService;
    }
  }

  Future getProcessInstanceData({@required String entityId}) async {
    processInstanceData = null;
    tasks = null;
    formData = null;
    // setBusy(true);
    processInstanceData = await RestServices.getProcessInstanceData(
      processInstanceBusinessKey: entityId,
      processDefinitionKey: request.getProcessDefinitionKey,
    ) as ProcessInstanceData;
    if (processInstanceData != null) {
      tasks = await RestServices.getProcessTasks(processInstanceData: processInstanceData);
      formData = await RestServices.getTaskFormData(taskId: tasks.last.id) as BpmFormData;
    }
    // setBusy(false);
    return processInstanceData;
  }

  bool validateOutcomeById({
    String id,
    /*, bool isAgree, bool isFamiliarization*/
  }) {
    //REJECT
    //REVISION
    if (pgId != request.employee?.id) {
      return true;
    }
    if (request.familiarization) {
      return true;
    }
    if (id != 'REVISION' && id != 'REJECT') {
      if (!request.agree) {
        GlobalNavigator().errorBar(
          title: 'Для утверждения необходимо поставить галочку «Согласен»',
        );
        return false;
      }
      if (!request.familiarization) {
        GlobalNavigator().errorBar(
          title: 'Для утверждения необходимо поставить галочку «Ознакомлен»',
        );
        return false;
      }
    }
    return true;
  }
}
