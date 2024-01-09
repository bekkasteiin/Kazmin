import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/vacation_schedule/vacation_schedule_request.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_absences/vacation/vacation_schedule_form_edit.dart';
import 'package:kzm/pageviews/my_absences/vacation/vacation_schedule_form_view.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class VacationScheduleRequestModel extends AbstractBpmModel<VacationScheduleRequest> {
  List<VacationScheduleRequest> vacationList;
  List<DicAbsenceType> absenceTypeList;
  DicAbsenceType absenceType;
  AssignmentScheduleModels assignmentScheduleModels;
  DicAbsenceType annualLeave;
  int absenceDays = 0;
  List<AbsenceRequest> myAnnualLeaves;
  int nextYear;
  int balanceDay;

  Future<List<VacationScheduleRequest>> get myVacations async {
    vacationList = await RestServices.getMyVacationSchedule();
    notifyListeners();
    return vacationList;
  }

  Future getBalanceDay() async {
    if (annualLeave == null) {
      await getAnnualLeave();
    }
    String response;
    if (request.startDate != null) {
      response ??= await RestServices.getVacationScheduleBalanceDays(absenceDate: request.startDate);
    }
    balanceDay = double.parse(response).round();
    request.balance = balanceDay;
    return balanceDay;
  }

  Future<DicAbsenceType> getAbsenceType() async {
    company = await RestServices.getCompanyByPersonGroupId();
    absenceTypeList ??= await RestServices.getAbsenceType(company.id, annualLeave.id);
    absenceType = absenceTypeList.isEmpty ? null : absenceTypeList.first;
    return absenceType;
  }

  // Future<bool> checkNextYearVacations() async {
  //   if (annualLeave == null) {
  //     await getAnnualLeave();
  //   }
  //   myAnnualLeaves ??=
  //       await RestServices.getAnnualLeaveVacations(annualLeave.id);
  //
  //   DateTime now = new DateTime.now();
  //   nextYear = now.year + 1;
  //
  //   if (myAnnualLeaves == null) {
  //     return false;
  //   }
  //   for (AbsenceRequest i in myAnnualLeaves) {
  //     if (i.dateFrom.year == nextYear && i.absenceDays >= 14) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  Future getAnnualLeave() async {
    annualLeave = await RestServices.getAnnualLeaveAbsenceType();
    return annualLeave;
  }

  Future getAssignmentScheduleService() async {
    assignmentScheduleModels = await RestServices.getAssignmentScheduleServices();
    return assignmentScheduleModels;
  }

  Future calculateDay() async {
    if (annualLeave == null) {
      await getAnnualLeave();
    }

    if (request.startDate != null && request.endDate != null && request.personGroup != null) {
      final calcDay = await RestServices.getCountDay(
        dateFrom: request.startDate, dateTo: request.endDate, absenceTypeId: annualLeave.id, personGroupId: request.personGroup.id,);
      calcDay.replaceAll(RegExp('W+'), '');
      request.absenceDays = int.parse(calcDay);
    }
    rebuild();
  }

  Future updateRequest() async {
    setBusy(true);
    final S translation = S.current;
    if (balanceDay == null) {
      await getBalanceDay();
    }
    final bool validate = await checkValidateRequest();
    if (!validate) {
      return;
    }
    request.approved = false;
    request.revision = false;
    final bool updated = await RestServices.updateEntity(entityName: 'tsadv_VacationScheduleRequest', entityId: request.id, entity: request);
    setBusy(false);
    if (updated) {
      notifyListeners();
      await myVacations;
      GlobalNavigator.pop();
      GlobalNavigator.successSnackbar();
    } else {
      GlobalNavigator.errorSnackbar(translation.error);
    }
  }

  Future<void> openRequest(VacationScheduleRequest selected) async {
    request = selected;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          // child: request.sentToOracle == null ? VacationScheduleForm() : VacationScheduleFormView(),
          child: !request.revision
              ? VacationScheduleFormView()
              : VacationScheduleForm(),
        ),
      ),
    );
  }

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;

    if (request.requestNumber == null || request.requestDate == null || request.startDate == null || request.endDate == null || request.absenceDays == null) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: translation.fillRequiredFields,
      );
      return false;
    }

    if (request.startDate.isAfter(request.endDate)) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: 'Начальная дата должна быть раньше конечной',
      );
      return false;
    }

    if (balanceDay < request.absenceDays) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: 'Количество дней отпуска превышает допустимое',
      );
      return false;
    }

    final bool hasMinDay = await getAbsenceHasMaxDaysByTypId();
    print(hasMinDay);
    //Проверка: Одна из частей отпуска должна быть не менее 14 дней в год
    if (!hasMinDay && request.absenceDays < annualLeave.minDay) {
      setBusy(false);
      GlobalNavigator().errorBar(
        title: 'Одна из частей отпуска должна быть не менее ${annualLeave.minDay} дней',
      );
      return false;
    }

    // bool nextY = await checkNextYearVacations();
    // if (!nextY && request.absenceDays < 14) {
    //   setBusy(false);
    //   Get.snackbar(translation.attention,
    //       "Одна из частей отпуска должна быть не менее 14 дней",);
    //   return false;
    // }

    //Проверка: Жаңа заявка мен датасы Пересекает етсе запрет қояды
    //RestService пока не работаеть
    // bool hasIntersects = await hasIntersectsRequest();
    // if (hasIntersects) {
    //   setBusy(false);
    //   Get.snackbar(translation.attention,
    //       'Запрос на отпуск с такими данными уже существует',
    //       instantInit: false);
    //   return false;
    // }

    return true;
  }

  @override
  Future getRequestDefaultValue() async {
    setBusy(true);
    request = VacationScheduleRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request);
    request.id = null;
    await getPersonGroupId();
    await getAnnualLeave();
    request.assignmentSchedule = await getAssignmentScheduleService();
    company = await RestServices.getCompanyByPersonGroupId();
    request.personGroup = PersonGroup(id: pgId);
    request.sentToOracle = null;
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: VacationScheduleForm(),
        ),
      ),
    );
  }

  @override
  // TODO: implement getRequests
  Future<List<VacationScheduleRequest>> getRequests() => throw UnimplementedError();

  @override
  Future openRequestById(String id, {bool isRequestID = false}) async {}

  @override
  Future saveRequest() async {
    final S translation = S.current;
    setBusy(true);
    final bool validate = await checkValidateRequest();
    if (!validate) {
      return;
    }
    if (request.id == null) {
      request.id = await RestServices.createAndReturnId(entityName: EntityNames.vacationScheduleRequest, entity: request);
      if (request.id != null) {
        setBusy(false);
        await myVacations;
        notifyListeners();
        GlobalNavigator.pop();
        GlobalNavigator.successSnackbar();
      } else {
        setBusy(false);
        GlobalNavigator.errorSnackbar(translation.error);
      }
    } else {
      await myVacations;
      notifyListeners();
      setBusy(false);
      GlobalNavigator.successSnackbar();
    }
  }

  Future saveFileToEntity({File picker}) async {
    setBusy(true);
    if (picker != null) {
      final FileDescriptor result = await saveAttach(picker);
      request.attachment = result;
    }
    setBusy(false);
  }

  //Есть ли Каленьдарный год заявка больше или ровно minDay
  Future<bool> getAbsenceHasMaxDaysByTypId() async {

    if (annualLeave == null) {
      await getAnnualLeave();
    }

    //Если minDay пустой тогда проверка не нужно
    if (annualLeave.minDay == null) {
      return true;
    }
    final bool hasMaxDaysRequest = await RestServices.getVacationScheduleRequestHasMaxDaysByTypId(absenceType: annualLeave);
    // bool hasMaxDaysAbsenceRequest =
    // await RestServices.getAbsenceRequestHasMaxDaysByTypId(
    //     absenceType: annualLeave);
    return hasMaxDaysRequest;
  }

  Future<bool> hasIntersectsRequest() async {
    return await RestServices.hasIntersectsVacationScheduleRequest(request: request);
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
