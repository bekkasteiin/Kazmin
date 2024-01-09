import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/assignment_schedule.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_team/time_management/schedule_request/schedule_offsets_form_edit.dart';
import 'package:kzm/pageviews/my_team/time_management/schedule_request/schedule_offsets_form_view.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class ScheduleRequestModel extends AbstractBpmModel<ScheduleOffsetsRequest> {
  List<AssignmentSchedule> assignmentScheduleList;
  PersonGroup employee;
  String assignmentGroupId;

  Future<List<AssignmentSchedule>> getAssignmentSchedules() async {
    assignmentScheduleList = await RestServices.getAssignmentSchedule(personGroupId: assignmentGroupId);
    return assignmentScheduleList;
  }

  // set assignmentGroupId(String val) {
  //   _assignmentGroupId = val;
  //   setBusy(false);
  // }

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;
    if (request.dateOfNewSchedule == null || request.dateOfStartNewSchedule == null || request.earningPolicy == null || request.newSchedule == null) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }
    return true;
  }

  // 1bf0dc36-bb7a-5eba-e656-e13be3399cbe
  @override
  Future<void> getRequestDefaultValue() async {
    request = await RestServices.getNewScheduleOffsetsRequest();
    //  scheduleRvdRequest.id = null;
    request.personGroup = employee;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(value: this, child: ScheduleOffsetsFormEdit()),
      ),
    );
  }

  @override
  Future<List<ScheduleOffsetsRequest>> getRequests() async {
    requestList = await RestServices.getAbsencesSchedulePersonGroupId(id: child.personGroupId);
    return requestList;
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    await getPersonGroupId();
    request = ScheduleOffsetsRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as ScheduleOffsetsRequest;
    if (userInfo == null) {
      await getUserInfo();
    }
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(value: this, child: ScheduleOffsetsFormView()),
      ),
    );
  }

  @override
  Future saveRequest() async {
    setBusy(true);
    final S translation = S.current;
    if (request.id == '') {
      request.id = await RestServices.createAndReturnId(entityName: EntityNames.scheduleOffsetsRequest, entity: request);
      if (request.id != null) {
        setBusy(false);
      } else {
        setBusy(false);
        GlobalNavigator().errorBar(
          title: translation.fillRequiredFields,
        );
      }
    } else {
      setBusy(false);
    }
  }

  @override
  Future<void> saveFilesToEntity({File picker, List<File> multiPicker}) {
    // TODO: implement saveFilesToEntity
    throw UnimplementedError();
  }

  @override
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  @override
  Future<void> onRefreshList() {
    // TODO: implement onRefreshList
    throw UnimplementedError();
  }
}
