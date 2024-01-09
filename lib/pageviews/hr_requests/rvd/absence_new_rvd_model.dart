import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/entities/base_assignment_ext.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/assignment_schedule.dart';

// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_request.dart';
import 'package:kzm/pageviews/hr_requests/rvd/view/absence_new_rvd_form_edit.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';

class AbsenceNewRvdModel extends AbstractBpmModel<AbsenceNewRvdRequest> {
  // void Function() refreshData;

  AbsenceNewRvdModel() {
    request = AbsenceNewRvdRequest();
    showSaveRequestButton = true;
    showGetReportButton = true;
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = await RestServices.getNewBpmRequestDefault(entity: request) as AbsenceNewRvdRequest;
    request.id = null;
    request.remote ??= false;
    request.files ??= <FileDescriptor>[];
    final List<BasePersonExt> personExt = await RestServices().getPersonExt();
    request.employee = PersonGroup(id: personExt?.first?.group?.id, instanceName: personExt?.first?.instanceName);
    company = await RestServices.getCompanyByPersonGroupId();
    setBusy();
    Get.to(
      () => ChangeNotifierProvider<AbsenceNewRvdModel>.value(
        value: this,
        child: AbsenceNewRvdFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    request = AbsenceNewRvdRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as AbsenceNewRvdRequest;
    if (userInfo == null) await getUserInfo();
    request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
    request.files ??= <FileDescriptor>[];
    child = await getChildByID(personGroupID: request?.employee?.id);
    await getProcessInstanceData(entityId: id);
    // request.remote ??= false;
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<AbsenceNewRvdModel>.value(
        value: this,
        child: AbsenceNewRvdFormEdit(),
      ),
    );
  }

  Future<PersonGroup> get personGroupForAssignment async => await RestServices.getPersonGroupForAssignment() as PersonGroup;

  Future<MyTeamNew> getChildByID({@required String personGroupID}) async {
    final List<MyTeamNew> _children = await RestServices.getChildren(
      parentPositionGroupId: (await personGroupForAssignment)?.currentAssignment?.positionGroup?.id,
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
      log('-->> $fName, checkSelectedUser -->> error!', error: e, stackTrace: s);
      return false;
    }
    return _user?.id != null;
  }

  Future<bool> checkVahtaScheduleNotAllow() async {
    try {
      final BaseAssignmentExt _baseAssignmentExt = await RestServices.getBaseAssignmentExt();
      final AssignmentSchedule _assignmentSchedule = await RestServices.getTsadvAssignmentSchedule(assignmentGroupID: _baseAssignmentExt?.group?.id);
      if (_assignmentSchedule?.endPolicyCode != '361') return false;
    } catch (e, s) {
      log('-->> $fName, checkVahtaScheduleNotAllow -->> error!', error: e, stackTrace: s);
      return false;
    }
    return true;
  }

  @override
  Future<bool> checkValidateRequest() async {
    if (child == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.employee}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.absenceType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.type}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.purpose == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.absPurpose}" ${S.current.notSelected}').show();
      return false;
    }
    if (request?.purpose?.id == absencePurposeOtherTypeID) {
      if (request.purposeText == null) {
        await KzmSnackbar(message: '${S.current.field} "${S.current.purposeText}" ${S.current.notFilled}').show();
        return false;
      }
    }
    if (request.timeOfStarting == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.timeOfStarting}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.timeOfFinishing == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.timeOfFinishing}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.timeOfStarting.isAfter(request.timeOfFinishing)) {
      await KzmSnackbar(message: '"${S.current.timeOfStarting}" ${S.current.notCannotBeEarlier} "${S.current.timeOfFinishing}"').show();
      return false;
    }
    return true;
  }

  @override
  Future<List<AbsenceNewRvdRequest>> getRequests() async {
    final UserViewModel user = Get.context.read<UserViewModel>();
    var info = await RestServices.getUserInfo();
    final List<AbsenceNewRvdRequest> list = await RestServices().getAbsenceRvds(
      request: request,
      login: info.login,
      // entityName: request.getEntityName,
      // view: request.getViewOld,
    );
    final List<String> teamIDs = <String>[await RestServices.pgID];
    if (await user.isChief) {
      for (final MyTeamNew e in user.myTeam) {
        if (e.personGroupId != null) teamIDs.add(e.personGroupId);
      }
    }
    return list.where((AbsenceNewRvdRequest e) => teamIDs.contains(e.employee.id)).toList();
  }

  // @override
  // Future<void> saveRequest() async {
  //   // log('-->> $fName, saveRequest ->> request: ${request.toJson()}');
  //   if (!(await checkValidateRequest())) return;
  //   try {
  //     request.employee = PersonGroup(id: child.personGroupId);
  //     setBusy(true);
  //     request.id = await RestServices.createAndReturnId(
  //       entityName: request.getEntityName,
  //       entity: request,
  //     );
  //     refreshData();
  //     setBusy(false);
  //     if (request?.id == null) {
  //       log('-->> $fName, saveRequest -->> saveRequest error: ${request.toJson()}');
  //       await KzmSnackbar(message: S.current.saveRequestError).show();
  //     }
  //   } catch (e, s) {
  //     setBusy(false);
  //     log('-->> $fName, saveRequest -->> saveRequest error!', error: e, stackTrace: s);
  //     await KzmSnackbar(message: S.current.saveRequestError).show();
  //   }
  // }

  @override
  Future<void> getReport() async {
    if ((request?.id == null) || (request.id.isEmpty)) {
      await KzmSnackbar(message: S.current.reportNeedRequestID, autoHide: true).show();
      return;
    }
    String _fileName;
    String _reportCode;
    if (request.absenceType.temporaryTransfer) {
      _reportCode = 'TEMPORARY_REQUEST';
    } else if (request.absenceType.workOnWeekend) {
      _reportCode = 'RVD_REQUEST';
    } else if (request.absenceType.overtimeWork) {
      _reportCode = 'OVERTIME_REQUEST';
    }
    try {
      setBusy(true);
      _fileName = await RestServices().getReportData(
        codeValue: _reportCode,
        parameters: <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'req',
            'value': request.id,
          },
        ],
      );
      setBusy(false);
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
}
