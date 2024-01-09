import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/absence_for_recall.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/person/person_profile.dart';
import 'package:kzm/core/models/position/position_harmful_condition.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/all_absence_request/for_recall/absence_recall_form_edit.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class AbsenceForRecallModel extends AbstractBpmModel<AbsenceForRecall> {
  Absence selectedAbsence;
  bool isHarmfulCondition = false;
  PersonProfile personProfile;
  List<PositionHarmfulCondition> harmfulCondition;
  PersonGroup employee;

  Future<PersonGroup> get personGroupForAssignment async =>
      await RestServices.getPersonGroupForAssignment() as PersonGroup;

  bool checkAbsenceForRecall(Absence request) {
    if (request.type.availableForRecallAbsence &&
        request.type.useInSelfService &&
        request.type.availableForChangeDate) {
      if (DateTime.now().isBefore(request.dateTo) &&
          DateTime.now().isAfter(request.dateFrom)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;

    if (request.requestNumber == null ||
            request.status == null ||
            request.requestDate == null ||
            request.absenceType == null ||
            // request.employee == null ||
            request.vacation == null ||
            request.recallDateFrom == null ||
            request.recallDateTo == null
        // ||
        // request.purpose == null
        ) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }

    if (request.leaveOtherTime &&
        (request.dateTo == null || request.dateTo == null)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }

    // if (request.purpose.code == "OTHER" &&
    //     (request.purposeText == null ||
    //         request.purposeText == "")) {
    //   setBusy(false);
    //   Get.snackbar(translation.attention, translation.fillRequiredFields);
    //   return false;
    // }

    if (request.recallDateFrom.isAfter(request.recallDateTo)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: 'Дата отзыва не корректна',
      );
      return false;
    }

    if (request.leaveOtherTime && request.dateFrom.isAfter(request.dateTo)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: 'Даты неиспользованной части не корректна',
      );
      return false;
    }

    if (request.leaveOtherTime &&
        request.recallDateFrom.isAfter(request.dateFrom)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title:
            '"Дата неиспользованной части с"  не может быть меньше "Дата отзыва по"',
      );
      return false;
    }

    if (request.leaveOtherTime) {
      final int recallDays =
          request.recallDateTo.difference(request.recallDateFrom).inDays;
      final int day2 = request.dateTo.difference(request.dateFrom).inDays;
      if (recallDays < day2) {
        setBusy(false);
        GlobalNavigator().errorBar(
          title: 'Количество дней превышает недогуленный отпуск',
        );
        return false;
      }
    }

    if (request.leaveOtherTime) {
// "Дата неиспользованной части по" не может быть меньше "Дата неиспользованной части с"

    }
    // setBusy(false);
    // Get.snackbar(translation.attention, 'Успешно');
    // return false;
    return true;
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = await RestServices.getNewAbsenceForRecall(
        // entityName: 'tsadv_AbsenceForRecall', entity: absenceForRecall
        ) as AbsenceForRecall;
    request.id = null;
    request.requestDate = DateTime.now();
    request.files = <FileDescriptor>[];
    // request.employee = employee;
    // request.vacation = selectedAbsence;
    // request.absenceType = selectedAbsence.type;
    request.compensationPayment = true;
    request.leaveOtherTime = false;
    child = null;
    // harmfulCondition = await RestServices.getPositionHarmfulConditionByPG(pgId: employee.currentAssignment.positionGroup.id);
    // checkHarmfulCondition();
    await getPersonGroupId();
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<AbsenceForRecallModel>.value(
          value: this,
          child: AbsenceForRecallFormEdit(),
        ),
      ),
    );
  }

  @override
  Future<List<AbsenceForRecall>> getRequests({bool update = false}) async {
    if (requestList == null || update) {
      requestList = await RestServices.getAbsenceForRecall();
      setBusy();
    }
    // requestList = await
    return requestList;
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    request = AbsenceForRecall();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as AbsenceForRecall;
    request.absenceType = request.vacation.type;
    request.files = [];
    if (userInfo == null) {
      await getUserInfo();
    }
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<AbsenceForRecallModel>.value(
          value: this,
          child: AbsenceForRecallFormEdit(),
        ),
      ),
    );
  }

  @override
  Future saveRequest() async {
    setBusy(true);
    final S translation = S.current;

    if (request.id == null) {
      request.employee = PersonGroup(id: child.personGroupId);
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
        entity: request,
      );
      if (request.id != null) {
        await getRequests(update: true);
        setBusy(false);
        // Get.snackbar(translation.attention, 'Заявка успешно сохранена', instantInit: false);
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

  //Проверка есть ли вредний должность
  bool checkHarmfulCondition() {
    final DateTime birthday = personProfile?.birthDate;
    final DateTime date2 = DateTime.now();
    final double difference = date2.difference(birthday).inDays / 365;

    if (difference > 18) {
      PositionHarmfulCondition harmful;
      if (harmfulCondition.isNotEmpty) {
        final Iterable<PositionHarmfulCondition> list =
            harmfulCondition.where((PositionHarmfulCondition element) {
          final DateTime dateTime = DateTime.now();
          return dateTime.isBefore(element.endDate) &&
              dateTime.isAfter(element.startDate);
        });
        if (list.isNotEmpty) {
          harmful = list.first;
        }
      }
      if (harmful != null) {
        isHarmfulCondition = false;
        return false;
      } else {
        isHarmfulCondition = true;
        return true;
      }
    } else {
      isHarmfulCondition = false;
      return false;
    }
  }

  Future saveFileToEntity({File picker, List<File> multiPicker}) async {
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
  Future saveFilesToEntity({File picker, List<File> multiPicker}) {
    // TODO: implement saveFilesToEntity
    throw UnimplementedError();
  }

  @override
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  Future<void> openRequest(AbsenceForRecall e) async {
    setBusy(true);
    request = e;
    if (userInfo == null) {
      await getUserInfo();
    }
    await getProcessInstanceData(entityId: request.id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<AbsenceForRecallModel>.value(
          value: this,
          child: AbsenceForRecallFormEdit(),
        ),
      ),
    );
  }

  @override
  Future<void> onRefreshList() {
    // TODO: implement onRefreshList
    throw UnimplementedError();
  }
}
