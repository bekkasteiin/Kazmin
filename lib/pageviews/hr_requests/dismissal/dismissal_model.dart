import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
//import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/entities/base_assignment_ext.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/other/person_profile.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/assignment_schedule.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/dismissal/dismissal_rest_service.dart';
import 'package:kzm/core/service/dismissal/responses.dart';

// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/hr_requests/dismissal/dismissal_model.dart';

class DismissalModel extends AbstractBpmModel<DismissalRequest> {
  // void Function() refreshData;

  DismissalModel() {
    request = DismissalRequest();
    showSaveRequestButton = false;
    showGetReportButton = false;
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = DismissalRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request)
    as DismissalRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    final Box a = await HiveUtils.getSettingsBox();
    final String id = a.get('pgId') as String;

    final List<BasePersonExt> personExt = await RestServices().getPersonExt();

    log('AAA:${personExt.first.fullNameNumberCyrillic}');

    request.employee = PersonGroup(
        id: personExt?.first?.group?.id,
        instanceName: personExt?.first?.instanceName,
        fullName: personExt?.first?.fullNameNumberCyrillic);
    company = await RestServices.getCompanyByPersonGroupId();
    request.personGroup = PersonGroup(id: id);
    child = MyTeamNew(personGroupId: id);

    //log('XXX:${request.personGroup.id}');
    //log('YYY:$id');
    //log('ZZZ:${request.personGroup.fullName}');
    //log('AAA:${request.personGroup.instanceName}');
    //log('BBB:${request.personGroup.personFioWithEmployeeNumber}');
    //log('CCC:${request.personGroup.personLatinFioWithEmployeeNumber}');

    var s = await RestServices.getPersonProfileByPersonGroupId(pgId: id);

    //log('DDD:${s.fullName}');
    //request.employee.instanceName='XXX';
    //request.employee.instanceName='Молоканов Евгений Анатольевич';

    //request.personGroup.instanceName='Ins';

    //PersonProfile profile = (await RestServices.getPersonProfileByPersonGroupId(pgId: id)) as PersonProfile;
    //request.personProfile =profile;
    request.personProfile = PersonProfile(
        fullName: s.fullName,
        hireDate: s.hireDate,
        positionName: s.positionName,
        organizationName: s.organizationName);

    //print('111.${s.fullName}');
    //print('222.${s.positionName}');
    //print('333.${s.organizationName}');

    /*child = MyTeamNew(fullName: s.fullName,
                      personGroupId: id,
                      positionNameLang1: s.positionName,
                      organizationNameLang1: s.organizationName
                      );*/

    //child.fullName='Ибрагимов Баглан Бактыбаевич (337)';

    setBusy();
    //Get.to(
    //  () => ChangeNotifierProvider.value(
    //    value: this,
    //    child: DismissalFormEdit(),
    //  ),
    //);
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    request = DismissalRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as DismissalRequest;
    if (userInfo == null) await getUserInfo();
    request.employee = PersonGroup(
        id: request?.employee?.id,
        instanceName: request?.employee?.instanceName);
    request.files ??= <FileDescriptor>[];
    child = await getChildByID(personGroupID: request?.employee?.id);
    await getProcessInstanceData(entityId: id);
    // request.remote ??= false;
    setBusy(false);
    //Get.to(
    //  () => ChangeNotifierProvider<DismissalModel>.value(
    //    value: this,
    //    child: DismissalFormEdit(),
    //  ),
    //);
  }

  Future<PersonGroup> get personGroupForAssignment async =>
      await RestServices.getPersonGroupForAssignment() as PersonGroup;

  Future<MyTeamNew> getChildByID({@required String personGroupID}) async {
    final List<MyTeamNew> _children = await RestServices.getChildren(
      parentPositionGroupId: (await personGroupForAssignment)
          ?.currentAssignment
          ?.positionGroup
          ?.id,
    );
    return _children.firstWhere(
      (MyTeamNew e) => e.personGroupId == personGroupID,
      orElse: () {
        return null;
      },
    );
  }

  Future<bool> checkSelectedUserExists({@required String pgId}) async {
    User _user;
    try {
      _user = await RestServices.getUserByPersonGroupId(
        pgId: pgId,
        view: 'portal-bproc-users',
        additionalConditions: <FilterCondition>[
          FilterCondition(
            property: 'active',
            conditionOperator: Operators.equals,
            value: 'TRUE',
          ),
        ],
      );
    } catch (e, s) {
      log('-->> $fName, checkSelectedUser -->> error!',
          error: e, stackTrace: s);
      return false;
    }
    return _user?.id != null;
  }

  Future<bool> checkVahtaScheduleNotAllow() async {
    try {
      final BaseAssignmentExt _baseAssignmentExt =
      await RestServices.getBaseAssignmentExt();
      final AssignmentSchedule _assignmentSchedule =
      await RestServices.getTsadvAssignmentSchedule(
          assignmentGroupID: _baseAssignmentExt?.group?.id);
      if (_assignmentSchedule?.endPolicyCode != '361') return false;
    } catch (e, s) {
      log('-->> $fName, checkVahtaScheduleNotAllow -->> error!',
          error: e, stackTrace: s);
      return false;
    }
    return true;
  }

  @override
  Future<bool> checkValidateRequest() async {
    //if (child == null) {
    //  setBusy(false);
    //  await KzmSnackbar(message: '${S.current.field} "${S.current.employee}" ${S.current.notSelected}').show();
    //  return false;
    //}
    if (request.dateOfDismissal == null) {
      setBusy(false);
      await KzmSnackbar(
          message:
          '${S.current.field} "${S.current.dismissalDate}" ${S.current.notSelected}')
          .show();
      return false;
    }
    if (request.attachment == null) {
      setBusy(false);
      await KzmSnackbar(
          message:
          '${S.current.field} "${S.current.attachments}" ${S.current.notSelected}')
          .show();
      return false;
    }
    if (request.dateOfDismissal.isBefore(DateTime.now())) {
      setBusy(false);
      await KzmSnackbar(
          message:
          '${S.current.cannotBeEarlierThanToday}')
          .show();
      return false;
    }
    return true;
  }

  /*@override
  Future<List<DismissalRequest>> getRequests() async {
    final UserViewModel user = Get.context.read<UserViewModel>();
    final List<DismissalRequest> list = await DismissalRestServices().getDismissals(
      request: request,
      login: user.userInfo.login,
      // entityName: request.getEntityName,
      // view: request.getViewOld,
    );
    final List<String> teamIDs = <String>[await RestServices.pgID];
    if (await user.isChief) {
      for (final MyTeamNew e in user.myTeam) {
        if (e.personGroupId != null) teamIDs.add(e.personGroupId);
      }
    }

    log('XXX:getRequests');
    return list.where((DismissalRequest e) => teamIDs.contains(e.employee.id)).toList();
  }*/

  Future<DismissalRequest> getRequest() async {
    String PGID = await RestServices.pgID;

    //log('XXXX:getRequest--->$PGID');
    //log('Company:${company?.name}');
    setBusy(true);
    final UserViewModel user = Get.context.read<UserViewModel>();
    final Responses list = await DismissalRestServices().getDismissal(
      //request: request,
      //login: user.userInfo.login,
      // entityName: request.getEntityName,
      // view: request.getViewOld,
    );

    //log('OUT_CHECKER:${list.code}  ---  ${list.text}');

    if (list.code == 200 && list.text != null) {
      request = DismissalRequest();
      //request.enableFloatingButton=false;

      var s = await RestServices.getPersonProfileByPersonGroupId(pgId: PGID);
      log('RequestID:${list.text}');
      request.id = list.text;
      //request.reason='Reason1';

      request =
      await RestServices.getEntity(entity: request) as DismissalRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(
          id: request?.employee?.id,
          instanceName: request?.employee?.instanceName);

      request.personProfile = PersonProfile(
          fullName: s.fullName,
          hireDate: s.hireDate,
          positionName: s.positionName,
          organizationName: s.organizationName);

      company = await RestServices.getCompanyByPersonGroupId();
      log('CompCode200:${company?.code}');


      child = await getChildByID(personGroupID: request?.employee?.id);
      await getProcessInstanceData(entityId: list.text);
      setBusy(false);
      return request;
    } else {
      request = DismissalRequest();
      //request.enableFloatingButton=true;
      //var cmp = await RestServices.getCompanyByPersonGroupId();
      //log('CompanyCode:${cmp.name}');
      //log('CompanyCode2:${request.personProfile.companyCode}');

      request = await RestServices.getNewBpmRequestDefault(entity: request)
      as DismissalRequest;
      request.id = null;
      request.files ??= <FileDescriptor>[];
      //request.reason='Reason2';

      final List<BasePersonExt> personExt = await RestServices().getPersonExt();
      request.employee = PersonGroup(
          id: personExt?.first?.group?.id,
          instanceName: personExt?.first?.instanceName,
          fullName: personExt?.first?.fullNameNumberCyrillic);

      request.personGroup = PersonGroup(id: PGID);
      child = MyTeamNew(personGroupId: PGID);

      var s = await RestServices.getPersonProfileByPersonGroupId(pgId: PGID);
      request.personProfile = PersonProfile(
          fullName: s.fullName,
          hireDate: s.hireDate,
          positionName: s.positionName,
          organizationName: s.organizationName);

      company = await RestServices.getCompanyByPersonGroupId();
      log('CompCode500:${company.code}');

      setBusy(false);
      return request;
    }
  }

  @override
  Future<void> saveRequest() async {
    // log('-->> $fName, saveRequest ->> request: ${request.toJson()}');
    //log('PersonGroupID on Save:${child.personGroupId}');
    if (!(await checkValidateRequest())) return;
    try {
      request.employee = PersonGroup(id: await RestServices.pgID);
      setBusy(true);
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
        entity: request,
      );
      //refreshData();

      setBusy(false);
      if (request?.id == null) {
        log('-->> $fName, BGNsaveRequest -->> saveRequest error: ${request.toJson()}');
        await KzmSnackbar(message: S.current.saveRequestError).show();
      }
    } catch (e, s) {
      setBusy(false);
      log('-->> $fName, BGNsaveRequest -->> saveRequest error!',
          error: e, stackTrace: s);
      await KzmSnackbar(message: S.current.saveRequestError).show();
    }
  }

  @override
  Future<void> getReport() async {
    //if ((request?.id == null) || (request.id.isEmpty)) {
    //  await KzmSnackbar(message: S.current.reportNeedRequestID, autoHide: true).show();
    //  return;
    //}
    log('Company:${company?.code}');

    String _fileName;
    String _reportCode;

    _fileName = 'test.docx';

    if (company.code == 'KMM') {
      _reportCode = 'Resignation_letter_sample_KMM';
    } else if (company.code == 'KAL') {
      _reportCode = 'Resignation_letter_sample_KAL';
    } else if (company.code == 'KBL') {
      _reportCode = 'Resignation_letter_sample_KBL';
    } else if (company.code == 'VCM') {
      _reportCode = 'Resignation_letter_sample_VCM';
    }
    /*if (request.absenceType.temporaryTransfer) {
      _reportCode = 'TEMPORARY_REQUEST';
    } else if (request.absenceType.workOnWeekend) {
      _reportCode = 'RVD_REQUEST';
    } else if (request.absenceType.overtimeWork) {
      _reportCode = 'OVERTIME_REQUEST';
    }
    */
    //log('Report:${request.id}');

    try {
      setBusy(true);
      _fileName = await DismissalRestServices().getReportData(
        codeValue: _reportCode,
        parameters: <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'req',
            'value': request.id,
          },
        ],
      );
      setBusy(false);
      log('FileName:${_fileName}');
      OpenFile.open(_fileName);
    } catch (e, s) {
      log('-->> $fName, getReport -->> error!', error: e, stackTrace: s);
    }
  }

  @override
  Future<void> saveFilesToEntity({File picker, List<File> multiPicker}) async {
    setBusy(true);
    if (picker != null) {
      final FileDescriptor result = await saveAttach(picker);
      request.files.add(result);
    } else if (multiPicker != null) {
      for (int i = 0; i < multiPicker.length; i++) {
        final FileDescriptor result = await saveAttach(multiPicker[i]);
        request.files.add(result);
      }
    }
    setBusy(false);
  }

  @override
  Future<void> onRefreshList() {
    // TODO: implement onRefreshList
    throw UnimplementedError();
  }

  Future saveFileToEntity({File picker}) async {
    setBusy(true);
    if (picker != null) {
      request.attachment = await saveAttach(picker);
    }
    setBusy(false);
  }

  @override
  Future<List<DismissalRequest>> getRequests() {
    // TODO: implement getRequests
    //throw UnimplementedError();
    return null;
  }
}