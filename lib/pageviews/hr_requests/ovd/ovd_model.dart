import 'dart:io';
import 'package:get/get.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/hr_requests/ovd/view/ovd_form_edit.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:kzm/viewmodels/user_model.dart';

import 'package:provider/provider.dart';

import 'ovd_request.dart';

const String fName = 'lib/pageviews/hr_requests/ovd/ovd_model.dart';

class OvdModel extends AbstractBpmModel<OvdRequest> {
  // void Function() refreshData;

  OvdModel() {
    request = OvdRequest();
    showSaveRequestButton = true;
    showGetReportButton = true;
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = await RestServices.getNewBpmRequestDefault(entity: request) as OvdRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    // final List<BasePersonExt> personExt = await RestServices().getPersonExt();
    // request.employee = PersonGroup(id: personExt?.first?.group?.id, instanceName: personExt?.first?.instanceName);
    // company = await RestServices.getCompanyByPersonGroupId();
    setBusy();
    Get.to(
      () => ChangeNotifierProvider<OvdModel>.value(
        value: this,
        child: OvdFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    request = OvdRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as OvdRequest;
    if (userInfo == null) await getUserInfo();
    request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
    request.files ??= <FileDescriptor>[];
    // child = await getChildByID(personGroupID: request?.employee?.id);
    await getProcessInstanceData(entityId: id);
    // request.remote ??= false;
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<OvdModel>.value(
        value: this,
        child: OvdFormEdit(),
      ),
    );
  }

  Future<PersonGroup> get personGroupForAssignment async => await RestServices.getPersonGroupForAssignment() as PersonGroup;

  // Future<MyTeamNew> getChildByID({@required String personGroupID}) async {
  //   final List<MyTeamNew> _children = await RestServices.getChildren(
  //     parentPositionGroupId: (await personGroupForAssignment)?.currentAssignment?.positionGroup?.id,
  //   );
  //   return _children.firstWhere(
  //     (MyTeamNew e) => e.personGroupId == personGroupID,
  //     orElse: () {
  //       return null;
  //     },
  //   );
  // }

  // Future<bool> checkSelectedUserExists({@required String pgId}) async {
  //   User _user;
  //   try {
  //     _user = await RestServices.getUserByPersonGroupId(
  //       pgId: pgId,
  //       view: 'portal-bproc-users',
  //       additionalConditions: <FilterCondition>[
  //         FilterCondition(
  //           property: 'active',
  //           conditionOperator: Operators.equals,
  //           value: 'TRUE',
  //         ),
  //       ],
  //     );
  //   } catch (e, s) {
  //     log('-->> $fName, checkSelectedUser -->> error!', error: e, stackTrace: s);
  //     return false;
  //   }
  //   return _user?.id != null;
  // }

  // Future<bool> checkVahtaScheduleNotAllow() async {
  //   try {
  //     final BaseAssignmentExt _baseAssignmentExt = await RestServices.getBaseAssignmentExt();
  //     final AssignmentSchedule _assignmentSchedule = await RestServices.getTsadvAssignmentSchedule(assignmentGroupID: _baseAssignmentExt?.group?.id);
  //     if (_assignmentSchedule?.endPolicyCode != '361') return false;
  //   } catch (e, s) {
  //     log('-->> $fName, checkVahtaScheduleNotAllow -->> error!', error: e, stackTrace: s);
  //     return false;
  //   }
  //   return true;
  // }

  @override
  Future<bool> checkValidateRequest() async {
    // if (child == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.employee}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.absenceType == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.type}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.purpose == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.absPurpose}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request?.purpose?.id == absencePurposeOtherTypeID) {
    //   if (request.purposeText == null) {
    //     await KzmSnackbar(message: '${S.current.field} "${S.current.purposeText}" ${S.current.notFilled}').show();
    //     return false;
    //   }
    // }
    // if (request.timeOfStarting == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.timeOfStarting}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.timeOfFinishing == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.timeOfFinishing}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.timeOfStarting.isAfter(request.timeOfFinishing)) {
    //   await KzmSnackbar(message: '"${S.current.timeOfStarting}" ${S.current.notCannotBeEarlier} "${S.current.timeOfFinishing}"').show();
    //   return false;
    // }
    return true;
  }

  @override
  Future<List<OvdRequest>> getRequests() async {
    final UserViewModel user = Get.context.read<UserViewModel>();
    final UserInfo infoUser = await RestServices.getUserInfo();
    final List<OvdRequest> list = await RestServices().getOvds(
      request: request,
      login: infoUser.login,
    );
    final List<String> teamIDs = <String>[await RestServices.pgID];
    if (await user.isChief) {
      for (final MyTeamNew e in user.myTeam) {
        if (e.personGroupId != null) teamIDs.add(e.personGroupId);
      }
    }
    return list.where((OvdRequest e) => teamIDs.contains(e.personGroup.id)).toList();
  }

  // @override
  // Future<void> getReport() async {
  //   if ((request?.id == null) || (request.id.isEmpty)) {
  //     await KzmSnackbar(message: S.current.reportNeedRequestID, autoHide: true).show();
  //     return;
  //   }
  //   String _fileName;
  //   String _reportCode;
  //   if (request.absenceType.temporaryTransfer) {
  //     _reportCode = 'TEMPORARY_REQUEST';
  //   } else if (request.absenceType.workOnWeekend) {
  //     _reportCode = 'RVD_REQUEST';
  //   } else if (request.absenceType.overtimeWork) {
  //     _reportCode = 'OVERTIME_REQUEST';
  //   }
  //   try {
  //     setBusy(true);
  //     _fileName = await RestServices().getReportData(
  //       codeValue: _reportCode,
  //       parameters: <Map<String, dynamic>>[
  //         <String, dynamic>{
  //           'name': 'req',
  //           'value': request.id,
  //         },
  //       ],
  //     );
  //     setBusy(false);
  //     OpenFile.open(_fileName);
  //   } catch (e, s) {
  //     log('-->> $fName, getReport -->> error!', error: e, stackTrace: s);
  //   }
  // }

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

  @override
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }
}
