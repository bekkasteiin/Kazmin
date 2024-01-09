import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/change_days_request.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/all_absence_request/change_days/change_absence_form_edit.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/viewmodels/bpm_requests/change_absence_model.dart';

class ChangeAbsenceModel extends AbstractBpmModel<ChangeAbsenceDaysRequest> {
  Absence selectedAbsence;
  PersonGroup employee;
  String nameAbsence = '';
  DateTime cachedNewStartDate;
  DateTime cachedNewEndDate;
  String cachedPersonGroupId;
  int cachedIntNewRequestDays;
  double cachedBalanceDays;

  Future<PersonGroup> get personGroupForAssignment async => await RestServices.getPersonGroupForAssignment() as PersonGroup;

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;
    if (request.requestNumber == null ||
        request.status == null ||
        request.requestDate == null ||
        // request.employee == null ||
        request.vacation == null ||
        request.scheduleStartDate == null ||
        request.scheduleEndDate == null ||
        request.newStartDate == null ||
        request.newEndDate == null ||
        // request.periodStartDate == null ||
        // request.periodEndDate == null ||
        request.purpose == null) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }

    if (request.purpose.code == 'OTHER' && (request.purposeText == null || request.purposeText == '')) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }

    if (request.newStartDate.isAfter(request.newEndDate)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.absenceDateError,
      );
      return false;
    }

    if (request.periodStartDate != null && request.periodEndDate != null && request.periodStartDate.isAfter(request.periodEndDate)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.absencePeriodError,
      );
      return false;
    }

    // if (await notEnoughDays) {
    //   setBusy(false);
    //   Get.snackbar(translation.attention, S.current.absenceBalanceError);
    //   return false;
    // }

    if ((request.files == null) || (request.files.isEmpty)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.filesNotSelected,
      );
      return false;
    }

    // if (request.scheduleStartDate.isAfter(request.newStartDate)) {
    //   setBusy(false);
    //   Get.snackbar(
    //       translation.attention,
    //       '"Период ежегодного трудового отпуска согласно утвержденного графика Дата с" '
    //       'не может быть меньше чем "Новый период ежегодного трудового отпуска Дата с"');
    //   return false;
    // }

    // log('-->> $fName, checkValidateRequest ->> request.vacation: ${request.vacation.toJson()}');
    //проверки на то что длительность + Дни авансом
    if (request.id == null) {
      final annualDays = await RestServices.getCountDaysWithoutHolidays(
        startDate: request?.scheduleStartDate,
        endDate: request?.scheduleEndDate,
        personGroupId: child.personGroupId,
      );
      // log('-->> $fName, checkValidateRequest ->> annualDays: $annualDays');
      annualDays.replaceAll(RegExp('W+'), '');
      int intAnnualDays = int.parse(annualDays as String);
      // print(annualDays);

      // final newRequestDate = await RestServices.getCountDaysWithoutHolidays(
      //   startDate: request?.newStartDate,
      //   endDate: request?.newEndDate,
      //   personGroupId: child.personGroupId,
      // );
      // // log('-->> $fName, checkValidateRequest ->> newRequestDate: $newRequestDate');
      // newRequestDate.replaceAll(RegExp('W+'), '');
      // int intNewRequestDate = int.parse(newRequestDate as String);
      int intNewRequestDate = await intNewRequestDays;

      //+"Дни отпуска авансом" (если заполнено поле на типе отсутствия по компании пользователя и значение БОЛЬШЕ 0)
      // if (request.vacation?.type?.daysAdvance != null && request.vacation.type.daysAdvance > 0) {
      //   // log('-->> $fName, checkValidateRequest ->> daysAdvance: ${request.vacation?.type?.daysAdvance}');
      //   intAnnualDays += request.vacation?.type?.daysAdvance;
      //   intNewRequestDate += request.vacation?.type?.daysAdvance;
      // }

      // // if (intAnnualDays < intNewRequestDate) {
      // if (intAnnualDays != intNewRequestDate) {
      //   // log('-->> $fName, checkValidateRequest ->> intAnnualDays($intAnnualDays) <  intNewRequestDate($intNewRequestDate)');
      //   setBusy(false);
      //   // Get.snackbar(translation.attention, 'Длительность отсутствия превышает допустимое значение');
      //   Get.snackbar(translation.attention, S.current.absenceDaysIncorrect);
      //   return false;
      // }
      if (request.vacation?.type?.daysAdvance != null && request.vacation.type.daysAdvance > 0) {
        // log('-->> $fName, checkValidateRequest ->> daysAdvance: ${request.vacation?.type?.daysAdvance}');
        cachedBalanceDays += request.vacation?.type?.daysAdvance;
      }
      if (intNewRequestDate >= cachedBalanceDays) {
        log('-->> $fName, checkValidateRequest ->> intNewRequestDate > (await doubleBalanceDays)');
        setBusy(false);
        GlobalNavigator().errorBar(
          title: translation.absenceDaysBalanceError,
        );
        return false;
      }
    }

    if (request.id != null && request.agree) {
      if (request.familiarization == null || !request.familiarization) {
        setBusy(false);
        GlobalNavigator().errorBar(
          title: translation.fillRequiredFields,
        );
        return false;
      }
    }

    return true;
  }

  Future<int> get intNewRequestDays async {
    // log('-->> $fName, intNewRequestDays ->> start');
    if ((request?.newStartDate != null) && (request?.newEndDate != null) && (child?.personGroupId != null)) {
      if ((request?.newStartDate != cachedNewStartDate) && (request?.newEndDate != cachedNewEndDate) && (child?.personGroupId != cachedPersonGroupId)) {
        final dynamic rest = await RestServices.getCountDaysWithoutHolidays(
          startDate: request?.newStartDate,
          endDate: request?.newEndDate,
          personGroupId: child?.personGroupId,
        );
        return cachedIntNewRequestDays = int.parse((rest as String).replaceAll(RegExp('W+'), ''));
      }
    } else {
      cachedIntNewRequestDays = null;
    }
    return cachedIntNewRequestDays;
  }

  Future<double> get doubleBalanceDays async {
    if (request?.newStartDate != null) {
      if (request?.newStartDate != cachedNewStartDate) {
        final dynamic rest = await RestServices.getBalanceDays(
          absenceDate: request?.newStartDate,
          absenceTypeId: request?.vacation?.type?.id,
          personGroupId: child?.personGroupId,
        );
        return cachedBalanceDays = double.parse(double.parse((rest as String).replaceAll(RegExp('W+'), '')).toStringAsFixed(2));
      }
    } else {
      cachedBalanceDays = null;
    }
    return cachedBalanceDays;
  }

  Future<bool> get notEnoughDays async {
    return ((await doubleBalanceDays) ?? 0) < ((await intNewRequestDays) ?? 0);
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = ChangeAbsenceDaysRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as ChangeAbsenceDaysRequest;
    request.id = null;
    request.requestDate = DateTime.now();
    request.employee = employee;
    request.files = <FileDescriptor>[];
    child = null;
    // log('-->> $fName, getRequestDefaultValue ->> request: ${request.toJson()}');
    // final List<BasePersonExt> personExt = await RestServices().getPersonExt();
    // request.employee = PersonGroup(id: personExt?.first?.group?.id, instanceName: personExt?.first?.instanceName);
    // request.vacation = selectedAbsence;
    // request.scheduleStartDate = selectedAbsence.dateFrom;
    // request.scheduleEndDate = selectedAbsence.dateTo;
    setBusy();
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<ChangeAbsenceModel>.value(
          value: this,
          child: ChangeAbsenceFormEdit(),
        ),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    request = ChangeAbsenceDaysRequest();
    request.id = id;
    request = await RestServices.getEntity(entity: request) as ChangeAbsenceDaysRequest;
    if (userInfo == null) {
      await getUserInfo();
    }
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<ChangeAbsenceModel>.value(
          value: this,
          child: ChangeAbsenceFormEdit(),
        ),
      ),
    );
  }

  bool checkChangeAbsenceDaysRequest(Absence request) {
    if (request.type.availableForRecallAbsence && request.type.useInSelfService && request.type.availableForChangeDate) {
      if (DateTime.now().isBefore(request.dateFrom)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<List<ChangeAbsenceDaysRequest>> getRequests({bool update = false}) async {
    if (requestList == null || update) {
      requestList = await RestServices.getChangeAbsenceDaysRequests();
      setBusy();
    }
    // requestList = await
    return requestList;
  }

  @override
  Future<void> saveRequest() async {
    setBusy(true);
    if (request.id == null) {
      request.employee ??= PersonGroup(id: child.personGroupId);
      request.id = await RestServices.createAndReturnId(entityName: request.getEntityName, entity: request);
      if (request.id != null) {
        await getRequests(update: true);
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

  // @override
  // Future<void> saveFilesToEntity({File picker, List<File> multiPicker}) {
  //   // TODO: implement saveFilesToEntity
  //   throw UnimplementedError();
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
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  Future<List<Absence>> getAbsence(String personGroupId, {bool forRecall = false}) async {
    final List<Absence> list = await RestServices.getAbsencesByPgId(personGroupId);
    final List<Absence> result = <Absence>[];
    for (final Absence element in list) {
      // DateTime date =DateTime.now();
      if (element.type.useInSelfService && element.type.availableForChangeDate && element.type.availableForChangeDate) {
        result.add(element);
        // if (forRecall && element.dateFrom.isBefore(date) && element.dateTo.isAfter(date)) {
        //   result.add(element);
        // } else if (!forRecall && element.dateFrom.isAfter(date)) {
        //   result.add(element);
        // }
      }
    }
    return result;
  }

  Future<String> getAbsenceNames(String personGroupId, {bool forRecall = false}) async {
    final List<Absence> list = await RestServices.getAbsencesByPgId(personGroupId);

    for (final Absence element in list) {
      if(request.vacation.id == element.id){
        nameAbsence = '${formatFullNotMilSec(
            element
                .projectStartDate)} - ${formatFullNotMilSec(
            element.projectEndDate)}';

        request.scheduleStartDate = element.projectStartDate;
        request.scheduleEndDate = element.projectEndDate;

      }
    }
    return nameAbsence;
  }

  Future<void> openRequest(ChangeAbsenceDaysRequest e) async {
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
        builder: (_) => ChangeNotifierProvider<ChangeAbsenceModel>.value(
          value: this,
          child: ChangeAbsenceFormEdit(),
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
