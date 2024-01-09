import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/all_absence.dart';
import 'package:kzm/core/models/absence/validate_model.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart' as person;
import 'package:kzm/core/models/vacation_schedule/vacation_schedule_request.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_absences/absence_request/absence_request_form_edit.dart';
import 'package:kzm/pageviews/my_absences/absence_request/absence_request_form_view.dart';
import 'package:kzm/pageviews/notifications/default_form.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/viewmodels/bpm_requests/absence_request_model.dart';

class AbsenceRequestModel extends AbstractBpmModel<AbsenceRequest> {
  VacationScheduleRequest vacationScheduleRequest;
  List<AllAbsenceRequest> allRequestList;
  List<DicAbsenceType> absenceType;
  List<VacationScheduleRequest> vacationSchedule;
  int absenceBalance;
  double balanceDays;
  AbsenceRequest absenceIntersecte;

  Future<List<DicAbsenceType>> getAbsenceTypes() async {
    absenceType = await RestServices.getAbsenceTypes(company.id);
    return absenceType;
  }

  Future<List<VacationScheduleRequest>> getVacationSchedule(
      String personGroupId) async {
    vacationSchedule = await RestServices.getScheduleTypes(personGroupId);
    return vacationSchedule;
  }

  @override
  Future openRequestById(String id, {bool isRequestID = false}) async {
    await getUserInfo();
    request = AbsenceRequest();
    setBusy(true);
    request.id = id;
    request = await RestServices.getEntity(entity: request) as AbsenceRequest;
    await getPersonGroupId();
    await getUserInfo();
    await getProcessInstanceData(entityId: id);

    final Box a = await HiveUtils.getSettingsBox();
    final String pgId = a.get('pgId') as String;
    request.employee = person.PersonGroup(id: pgId);
    company = await RestServices.getCompanyByPersonGroupId();
    // log('-->> $fName, openRequestById ->> request: ${request.toJson()}');
    // log('-->> $fName, openRequestById ->> isEditable: $isEditable');

    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child:
              isEditable ? AbsenceRequestFormEdit() : AbsenceRequestFormView(),
        ),
      ),
    );
  }

  @override
  Future<List<AbsenceRequest>> getRequests() async {
    // ignore: join_return_with_assignment
    requestList ??= await RestServices.getMyAbsenceRequest();
    return requestList;
  }

  Future<List<AllAbsenceRequest>> get allRequest async {
    // ignore: join_return_with_assignment
    allRequestList ??= await RestServices.getAllAbsenceRequest();
    return allRequestList;
  }

  // Получить новый сущность AbsenceRequest с дефаултовый значением (Заявка на отпуск)
  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = AbsenceRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request)
        as AbsenceRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    final Box a = await HiveUtils.getSettingsBox();
    final String id = a.get('pgId') as String;
    company = await RestServices.getCompanyByPersonGroupId();
    request.personGroup = PersonGroup(id: id);
    // vacationSchedule = await RestServices.getVacationScheduleByPersonGroupId();
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: AbsenceRequestFormEdit(),
        ),
      ),
    );
  }

  //Сохранение запись AbsenceRequest
  @override
  Future<void> saveRequest() async {
    try {
      setBusy(true);
      // if (request.id == null) {
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
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
  }

  Future<bool> checkValidate() async {
    final Box a = await HiveUtils.getSettingsBox();
    final String id = a.get('pgId') as String;
    final List<ValidateModel> validate = await RestServices.absenceValidation(
        absenceTypeId: request.type.id,
        startDate: request.dateFrom,
        endDate: request.dateTo,
        personGroupId: id,
        duration: request.absenceDays);
    var value = jsonDecode(validate[0].value);
    var valueSecond = jsonEncode(value[0]);
    var messageValidate = MessageValidate.fromJson(jsonDecode(valueSecond));
    setBusy(false);
    if (messageValidate.success == false) {
      setBusy(false);
      GlobalNavigator().errorBar(title: messageValidate.errorMessageRu);
      return false;
    }
    return true;
  }

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;
    if (request.status == null ||
        request.type == null ||
        request.absenceDays == null ||
        request.requestNumber == null ||
        request.dateFrom == null ||
        request.dateTo == null ||
        request.requestDate == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: S.current.fillRequiredFields);
      return false;
    }
    if (await checkValidate() == false) {
      return false;
    }

    // if (request.type.isJustRequired) {
    //   if (request.purposeText == null) {
    //     setBusy(false);
    //     Get.snackbar(translation.attention, S.current.fillRequiredFields);
    //     return false;
    //   }
    // }

    //Если это не трудовой отпуск vacationSchedule должен нулл
    // if (!isLaborLeaveAbsenceType(request.type)) {
    //   if (request?.type?.maxDay != null && request.type.maxDay < request.absenceDays) {
    //     setBusy(false);
    //     Get.snackbar(translation.attention, 'Длительность по данному типу отсутствия не может превышать: ${request.type.maxDay} дней');
    //     return false;
    //   }
    //   if (request?.type?.minDay != null && request.type.minDay > request.absenceDays) {
    //     setBusy(false);
    //     Get.snackbar(translation.attention, 'Длительность по данному типу отсутствия не может быть менее: ${request.type.minDay} дней');
    //     return false;
    //   }
    //   request.vacationScheduleRequest = null;
    // }

    //Дата по" обязательна и не может быть меньше чем "Дата с"
    if (request.dateFrom.isAfter(request.dateTo)) {
      setBusy(false);
      GlobalNavigator().errorBar(
          title: '"Дата по" обязательна и не может быть меньше чем "Дата с"');
      return false;
    }

    if (request.type.isOriginalSheet &&
        (request.originalSheet == null || !request.originalSheet)) {
      setBusy(false);
      GlobalNavigator().errorBar(
          title:
              "Поля 'Обязуюсь предоставить оригинал листа временной нетрудоспособности после закрытия' обязательно");
      return false;
    }

    if (request.type.isFileRequired) {
      if (request.files.isEmpty) {
        setBusy(false);
        GlobalNavigator().errorBar(title: translation.fillRequiredFields);
        return false;
      }
    }

    // MATERNITY LEAVE =
    if (absenceIntersecte != null && request.type.isOriginalSheet) {
      //SICKNESS временно
      if (request.scheduleEndDate == null ||
          request.scheduleStartDate == null ||
          request.newStartDate == null ||
          request.newEndDate == null) {
        setBusy(false);
        GlobalNavigator().errorBar(title: translation.fillRequiredFields);
        return false;
      }
    }

    //При подаче  заявки на отсутствие должна быть проверка на количество дней по сервису.
    // if (isLaborLeaveAbsenceType(request.type) || request.type.isEcologicalAbsence) {
    //   final int daysAdvance = request.type?.daysAdvance ?? 0;
    //   final int balanceDay = absenceBalance + daysAdvance;
    //   if (request.absenceDays >= balanceDay) {
    //     setBusy(false);
    //     Get.snackbar(translation.attention, 'Количество дней в заявке превышает остаток по балансу отпуска.');
    //     return false;
    //   }
    // }
    // final bool hasMaxDaysAbsence = await RestServices.getAbsenceHasMaxDaysByTypId(absenceType: request.type);
    //
    // final int minDay = request.type?.minDay ?? 14;
    // if(!hasMaxDaysAbsence){
    //   if(request.absenceDays < minDay  && isLaborLeaveAbsenceType(request.type) && request.type.minDay != null){
    //     setBusy(false);
    //     Get.snackbar(
    //         translation.attention, 'Одна из частей отпуска должна быть не менее $minDay дней. Измените даты отпуска в заявке.');
    //     return false;
    //   }
    // }

    //Добавить валидацию для заявки "day_off" и "sick_day"
    if ((request.type.useInSelfService ?? false) &&
        request.type.numDaysCalendarYear != null) {
      //отпускных дней, полученных за год по типу absenceTypeId
      final int numDaysCalendarYear = await getReceivedVacationDaysOfYear();

      //"Количество дней отпуска в календарном году"  - выдавать запрещающее сообщение
      if (numDaysCalendarYear >= request.type.numDaysCalendarYear) {
        setBusy(false);
        GlobalNavigator().errorBar(
          title:
              'Лимит по данному типу отсутствия в текущем календарном году исчерпан.'
              ' Вы не можете подать заявку на данный тип отсутствия',
        );
        return false;
      }

      final int countAllDaysCalendarYear =
          numDaysCalendarYear + request.absenceDays;
      if (countAllDaysCalendarYear > request.type.numDaysCalendarYear) {
        setBusy(false);
        GlobalNavigator().errorBar(
            title:
                'Длительность заявки превышает допустимый остаток. Выберите другой период');
        return false;
      }
    }

    if (request.type.isCheckWork) {
      //Валидация
      //Если доступные дни <= 0 то отобразить запрещаю
      //vacationDays = РВД - Проверять РВД
      final int vacationDays = await getRemainingDaysWeekendWork();
      if (vacationDays <= 0) {
        setBusy(false);
        GlobalNavigator().errorBar(title: translation.youDoNotVacationDays);
        return false;
      }

      //Если длительность заявки >доступные дни отгула выводить запрещаю
      if (vacationDays < request.absenceDays) {
        setBusy(false);
        GlobalNavigator().errorBar(title: translation.notEnoughVacationDays);
        return false;
      }
    }

    //Провкрка За сколько дней
    if (checkDayAdvance()) {
      setBusy(false);
      GlobalNavigator().errorBar(
          title:
              'Заявка должна быть подана не менее чем за ${request.type.daysBeforeAbsence} дней. Укажите другую дату начала отсутствия');
      return false;
    }

    setBusy(false);
    return true;
  }

  bool checkDayAdvance() {
    if (request.dateFrom != null &&
        request.requestDate != null &&
        request.type.daysBeforeAbsence != null) {
      final int minusDate =
          request.dateFrom.difference(request.requestDate).inDays;
      if (minusDate < request.type.daysBeforeAbsence) {
        return true;
      }
      return false;
    }
    return false;
  }

  //рассчитать день
  Future calculateDay() async {
    if (request.dateTo != null &&
        request.dateFrom != null &&
        request.personGroup != null &&
        request.type != null) {
      final calcDay = await RestServices.getCountDay(
        dateFrom: request.dateFrom,
        dateTo: request.dateTo,
        absenceTypeId: request.type.id,
        personGroupId: request.personGroup.id,
      );
      calcDay.replaceAll(RegExp('W+'), '');

      request.absenceDays = int.parse(calcDay);
    }
  }

  @override
  Future saveFilesToEntity({File picker, List<File> multiPicker}) async {
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

  //Сохранение файла для сущности tsadv$LeavingVacationRequest
  Future saveFile(File file) async {
    final FileDescriptor fileDescriptor =
        await RestServices.saveFile(file: file);
    return fileDescriptor;
  }

  //  //Валидация поля для "RequiredLeaving"
  // bool checkRequiredLeavingFields() {
  //   var translation = S.of(Get.overlayContext);
  //   if (leavingRequest.plannedStartDate == null) {
  //     setBusy(false);
  //     Get.snackbar(translation.attention, translation.fillRequiredFields);
  //     return false;
  //   }
  //   return true;
  // }

  // @return TRUE если Пользовать сейчас в отпуске
  Future getIsAbsenceIntersecte() async {
    if (request.dateTo != null && request.dateFrom != null) {
      absenceIntersecte = await RestServices.isAbsenceIntersecte(
          dateFrom: formatFullRestNotMilSec(request.dateFrom),
          dateTo: formatFullRestNotMilSec(request.dateTo));
      if (absenceIntersecte != null) {
        request.scheduleStartDate = absenceIntersecte.dateFrom;
        request.scheduleEndDate = absenceIntersecte.dateTo;
      }
    }
    return absenceIntersecte;
  }

  Future<bool> getAbsenceBalance() async {
    if (request.type != null &&
        request.dateFrom != null &&
        isLaborLeaveAbsenceType(request.type)) {
      final String balanceDays = await RestServices.getAbsenceBalanceDays(
          absenceDate: request.dateFrom, dicAbsenceTypeId: request.type.id);
      absenceBalance = double.parse(balanceDays).toInt();
      return true;
    } else if (request.type != null &&
        request.dateFrom != null &&
        request.type.isEcologicalAbsence) {
      final String rest = await RestServices.getEnvironmentalDays(
          absenceDate: request.dateFrom);
      absenceBalance = double.parse(rest).toInt();
      return true;
    }
    absenceBalance = 0;
    return false;
  }

  //Проверка тип отсутствие "Трудовой отпуск" или нет
  bool isLaborLeaveAbsenceType(DicAbsenceType type) {
    if ((type.availableForRecallAbsence ?? false) &&
        type.useInSelfService &&
        type.availableForChangeDate) {
      return true;
    }
    return false;
  }

  Future getReceivedVacationDaysOfYear() async {
    final String rest = await RestServices.getReceivedVacationDaysOfYear(
        absenceTypeId: request?.type?.id);
    print(rest);
    return double.parse(rest).toInt();
  }

  Future getRemainingDaysWeekendWork() async {
    final String rest = await RestServices.getRemainingDaysWeekendWork();
    return double.parse(rest).toInt();
  }

  //Есть ли Каленьдарный год есть трудовой отпуск больше 14 дней
  Future getAbsenceHasMaxDaysByTypId() async {
    final bool hasMaxDaysAbsence =
        await RestServices.getAbsenceHasMaxDaysByTypId(
            absenceType: request.type);
    final bool hasMaxDaysAbsenceRequest =
        await RestServices.getAbsenceRequestHasMaxDaysByTypId(
            absenceType: request.type);
    return hasMaxDaysAbsence ? hasMaxDaysAbsence : hasMaxDaysAbsenceRequest;
  }

  openAllAbsenceByName({BuildContext context, AllAbsenceRequest allAbsence}) {
    final String entityName = allAbsence?.allAbsenceRequestEntityName;
    if (entityName == EntityNames.absenceRequest) {
      openRequestById(allAbsence.id);
    } else if (entityName == EntityNames.absenceForRecall) {
      final AbsenceForRecallModel absenceForRecall =
          Provider.of<AbsenceForRecallModel>(context, listen: false);
      absenceForRecall.openRequestById(allAbsence.id);
    } else if (entityName == EntityNames.scheduleOffsetsRequest) {
      // case "tsadv_ScheduleOffsetsRequest":
      // MyTeamModel scheduleModel = MyTeamModel();
      // scheduleModel.scheduleRvdRequest = await RestServices.getScheduleRequestById(entityId: e.id);
      // if(scheduleModel.scheduleRvdRequest.id != null){
      //   await scheduleModel.getUserInfo();
      //   await scheduleModel.getProcessInstanceData(entityId: e.id, definitionKey: "scheduleOffsetsRequest");
      //   Get.to(ChangeNotifierProvider.value(
      //     value: scheduleModel,
      //     child: ScheduleRequestInfo(),)
      //   );
      // }
    } else if (entityName == EntityNames.absenceRvdRequest) {
      // MyTeamModel absenceRvdModel = MyTeamModel();
      // absenceRvdModel.absenceRvdRequest = await RestServices.getAbsenceRvdRequestById(entityId: e.id);
      // if(absenceRvdModel.absenceRvdRequest.id != null){
      //   await absenceRvdModel.getUserInfo();
      //   await absenceRvdModel.getProcessInstanceData(entityId: e.id, definitionKey: "absenceRvdRequest");
      //   Get.to(ChangeNotifierProvider.value(
      //     value: absenceRvdModel,
      //     child: AbsenceRvdRequestInfo(),)
      //   );
      // }
    } else if (entityName == EntityNames.certificateRequest) {
      //Форма для сертификатов еще не готово////

      // CertificateModel certificateModel = CertificateModel();
      // certificateModel.request = await
      // RestServices.getCertificateById(entityId: e.id);
      // if (certificateModel.request.id != null) {
      //   await certificateModel.getUserInfo();
      //   await certificateModel.getRolesDefinerAndNotRersisitActors();
      //   Get.to(ChangeNotifierProvider.value(
      //     value: certificateModel,
      //     child: CertificateInfoPage(),)
      //   );
      // }
    } else if (entityName == EntityNames.changeAbsenceDaysRequest) {
      final ChangeAbsenceModel changeAbsenceModel =
          Provider.of<ChangeAbsenceModel>(context, listen: false);
      changeAbsenceModel.openRequestById(allAbsence.id);
    } else if (entityName == EntityNames.leavingVacationRequest) {
      final LeavingVacationModel leavingRequestModel =
          Provider.of<LeavingVacationModel>(context, listen: false);
      leavingRequestModel.openRequestById(allAbsence.id);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DefaultFormForTask(
            isTask: true,
          ),
        ),
      );
    }
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
