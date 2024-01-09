import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/leaving_vacation.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_absences/absence/leaving_request/leaving_vacation_form_edit.dart';
import 'package:kzm/pageviews/my_absences/absence/leaving_request/leaving_vacation_form_view.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class LeavingVacationModel extends AbstractBpmModel<LeavingVacationRequest> {
  AbsenceRequest selectedAbsence;

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;
    if (request.plannedStartDate == null) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }
    return true;
  }

  @override
  // TODO: implement getRequests
  Future<List<LeavingVacationRequest>> getRequests() => throw UnimplementedError();

  @override
  Future saveRequest() async {
    try {
      setBusy(true);
      // if (request.id == null) {
      request.id = await RestServices.createAndReturnIds(
        entityName: EntityNames.leavingVacationRequest,
        entity: request,
      );
      setBusy(false);
      if (request.id == null) {
        KzmSnackbar(message: S.current.saveRequestError).show();
      }
      // }
    } catch (e) {
      KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }

    // setBusy(true);
    // final S translation = S.of(Get.overlayContext);
    //
    // if (request.id == '') {
    //   request.id = await RestServices.createAndReturnIds(entityName: EntityNames.leavingVacationRequest, entity: request);
    //   if (request.id != null) {
    //     setBusy(false);
    //   } else {
    //     setBusy(false);
    //     Get.snackbar(translation.attention, 'При сохранение заявка ошибка');
    //   }
    // } else {
    //   setBusy(false);
    // }
  }

  @override
  Future getRequestDefaultValue() async {
    setBusy(true);
    request = LeavingVacationRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request);
    request.id = null;
    // var a = await HiveUtils.getSettingsBox();
    // var id = a.get('pgId');
    //company = await RestServices.getCompanyByPersonGroupId(personGroupId: id);
    request.vacation = selectedAbsence;
    request.absenceDays = selectedAbsence.absenceDays;
    request.startDate = selectedAbsence.dateFrom;
    request.endDate = selectedAbsence.dateTo;
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: LeavingVacationFormEdit(),
        ),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    request = LeavingVacationRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request);
    setBusy(false);
    if (request.id != null && request.id != '') {
      if (userInfo == null) {
        await getUserInfo();
      }
      if (pgId != null) {
        await getPersonGroupId();
      }
      await getProcessInstanceData(entityId: id);
      Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: this,
            child: LeavingVacationFormView(),
          ),
        ),
      );
    }
  }

  Future saveFileToEntity({File picker}) async {
    setBusy(true);
    if (picker != null) {
      request.attachment = await saveAttach(picker);
    }
    setBusy(false);
  }

  @override
  Future saveFilesToEntity({File picker, List<File> multiPicker}) {
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
