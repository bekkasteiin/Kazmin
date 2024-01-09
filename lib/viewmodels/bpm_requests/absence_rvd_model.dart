import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/absence_rvd_request.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_team/time_management/rvd_request/absence_rvd_form_edit.dart';
import 'package:kzm/pageviews/my_team/time_management/rvd_request/absence_rvd_form_view.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class AbsenceRvdModel extends AbstractBpmModel<AbsenceRvdRequest> {
  PersonGroup employee;
  List<AbsenceRvdRequest> allRequestList;

  @override
  Future<bool> checkValidateRequest() async {
    if (request.timeOfStarting == null || request.timeOfFinishing == null || request.type == null || request.absencePurpose == null) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: S.current.fillRequiredFields,
      );
      return false;
    }
    return true;
  }

  Future<void> saveFileToEntity({File picker, List<File> multiPicker}) async {
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

  //Сохранение файл
  @override
  Future<FileDescriptor> saveAttach(File file) async {
    return await RestServices.saveFile(file: file);
  }

  @override
  Future<void> getRequestDefaultValue() async {
    request = await RestServices.getNewAbsenceRvdRequest() as AbsenceRvdRequest;
    request.id = null;
    request.employee = employee;
    request.files = [];
    await getPersonGroupId();
    Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(value: this, child: AbsenceRvdFormEdit()),),
    );
  }

  @override
  Future<List<AbsenceRvdRequest>> getRequests() async {
    allRequestList = await RestServices.getAbsencesRvdByPersonGroupId(id: child.personGroupId);
    return allRequestList;
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    request = AbsenceRvdRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as AbsenceRvdRequest;
    request.files = <FileDescriptor>[];
    setBusy(false);
    // if (request.id != null && request.id != "") {
    await getUserInfo();
    if (pgId == null) {
      await getPersonGroupId();
    }
    await getProcessInstanceData(entityId: id);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(value: this, child: AbsenceRvdFormView()),),
    );
  }

  @override
  Future saveRequest() async {
    setBusy(true);
    if (request.id == null) {
      request.id = await RestServices.createAndReturnId(entityName: EntityNames.absenceRvdRequest, entity: request);
      if (request.id != null) {
        setBusy(false);
      } else {
        setBusy(false);
        GlobalNavigator().errorBar(
          title: 'При сохранение заявка ошибка',
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
