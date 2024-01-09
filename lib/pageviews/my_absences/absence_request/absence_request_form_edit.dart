import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/date_time_input.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:provider/provider.dart';

const String fName =
    'lib/pageviews/my_absences/absence_request/absence_request_form_edit.dart';

class AbsenceRequestFormEdit extends StatefulWidget {
  @override
  _AbsenceRequestFormEditState createState() => _AbsenceRequestFormEditState();
}

class _AbsenceRequestFormEditState extends State<AbsenceRequestFormEdit> {
  bool checkReason = false;
  bool isAnnualType = false;

  bool _isHideOriginalSheet = false;
  bool _isHideDates = false;

  bool getAbsenceBalance = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AbsenceRequestModel>(
      builder: (BuildContext context, AbsenceRequestModel model, _) {
        return Scaffold(
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                pageTitle(
                  title: S.current.absenceRequest,
                ),
                fields(model: model),
                BpmTaskList<AbsenceRequestModel>(model),
                StartBpmProcess<AbsenceRequestModel>(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required AbsenceRequestModel model}) {
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestNum,
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? ' ',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestDate,
            leading: calendarWidgetForFormFiled,
            textValue: formatShortly(model?.request?.requestDate),
          ),
          FieldBones(
            placeholder: S.current.changeAbsenceVacationType,
            hintText: S.current.select,
            textValue: model.request?.type?.instanceName,
            icon: Icons.keyboard_arrow_down,
            maxLinesSubTitle: 2,
            selector: () async {
              await model.getAbsenceTypes();
              selectContract(model);
              await model.calculateDay();
              if (model.request?.type != null) {
                if (model.request.type.isOriginalSheet) {
                  await model.getIsAbsenceIntersecte();
                  if (model.absenceIntersecte != null) {
                    _isHideDates = true;
                  } else {
                    _isHideDates = false;
                    model.request?.scheduleStartDate = null;
                    model.request?.scheduleEndDate = null;
                    model.request?.newStartDate = null;
                    model.request?.newEndDate = null;
                    model.request?.periodDateFrom = null;
                    model.request?.periodDateTo = null;
                  }
                  _isHideOriginalSheet = true;
                } else {
                  _isHideOriginalSheet = false;
                  model.request.originalSheet = null;
                }

                if (model.request.type.availableForRecallAbsence &&
                    model.request.type.useInSelfService &&
                    model.request.type.availableForChangeDate) {
                  isAnnualType = true;
                  model.request.vacationScheduleRequest =
                      model.vacationScheduleRequest;
                  model.request?.dateFrom =
                      model.request?.vacationScheduleRequest?.startDate;
                  model.request?.dateTo =
                      model.request?.vacationScheduleRequest?.endDate;
                } else {
                  isAnnualType = false;
                  model.request.vacationScheduleRequest = null;
                }
                if (model.isLaborLeaveAbsenceType(model.request.type) ||
                    model.request.type.isEcologicalAbsence) {
                  getAbsenceBalance = await model.getAbsenceBalance();
                } else {
                  getAbsenceBalance = false;
                }
                setState(() {});
              } else {
                model.absenceBalance = 0;
              }
            },
            isRequired: true,
          ),
          if (getAbsenceBalance)
            FieldBones(
              isRequired: true,
              placeholder: 'Остаток',
              textValue: model.absenceBalance?.toString() ?? '0',
            ),
          if (isAnnualType)
            Column(
              children: <Widget>[
                FieldBones(
                  leading: calendarWidgetForFormFiled,
                  selector: () async {
                    await model.getVacationSchedule(model.request.personGroup.id);
                    selectShedule(model);
                    model.request?.dateFrom =
                        model.request?.vacationScheduleRequest?.startDate;
                    model.request?.dateTo =
                        model.request?.vacationScheduleRequest?.endDate;
                    await model.calculateDay();
                    setState(() {});
                  },
                  placeholder: S.current.vacationSchedule,
                  icon: Icons.keyboard_arrow_down,
                  textValue: model.request?.vacationScheduleRequest != null
                      ? '${formatShortly(model.request?.vacationScheduleRequest?.startDate)} - ${formatShortly(model.request?.vacationScheduleRequest?.endDate)}'
                      : null,
                ),
              ],
            )
          else
            Container(),

          KzmDateTimeInput(
            caption: S.current.dateFrom,
            formatDateTime: dateFormatFullNumeric,
            initialDateTime: model.request?.dateFrom != null
                ? "${formatFullNotMilSec(model.request?.dateFrom) ?? ''} ${model.request?.startTime ?? ''}"
                : formatFullNumeric(model.request?.dateFrom),
            isLoading: false,
            isRequired: true,
            isActive: model.isEditable,
            onChanged: (DateTime newDT) async {
              model.request?.dateFrom = newDT;
              model.request?.startTime = formatTimeRest(newDT);
              if (model.request.vacationScheduleRequest != null &&
                  model.request.vacationScheduleRequest.startDate != newDT) {
                model.request.vacationScheduleRequest = null;
              }
              //проверка Пользовать сейчас в отпуске
              if (model.request.type != null &&
                  model.request.type.isOriginalSheet) {
                await model.getIsAbsenceIntersecte();
                if (model.absenceIntersecte != null) {
                  _isHideDates = true;
                } else {
                  _isHideDates = false;
                  model.request?.scheduleStartDate = null;
                  model.request?.scheduleEndDate = null;
                  model.request?.newStartDate = null;
                  model.request?.newEndDate = null;
                  model.request?.periodDateFrom = null;
                  model.request?.periodDateTo = null;
                }
                _isHideOriginalSheet = true;
              } else {
                _isHideOriginalSheet = false;
                model.request.originalSheet = null;
              }
              await model.calculateDay();
              getAbsenceBalance = await model.getAbsenceBalance();
              model.setBusy(false);
            },
          ),
          SizedBox(height: Styles.appDoubleMargin),
          KzmDateTimeInput(
            caption: S.current.dateTo,
            formatDateTime: dateFormatFullNumeric,
            initialDateTime: model.request?.dateTo != null
                ? "${formatFullNotMilSec(model.request?.dateTo) ?? ''} ${model.request?.endTime ?? ''}"
                : formatFullNumeric(model.request?.dateTo),
            isLoading: false,
            isRequired: true,
            isActive: model.isEditable,
            onChanged: (DateTime newDT) async {
              model.request?.dateTo = newDT;
              model.request?.endTime = formatTimeRest(newDT);
              await model.calculateDay();
              // model.request.absenceDays = 1;
              if (model.request.vacationScheduleRequest != null &&
                  model.request.vacationScheduleRequest.endDate != newDT) {
                model.request.vacationScheduleRequest = null;
              }
              //проверка Пользовать сейчас в отпуске
              if (model.request.type != null &&
                  model.request.type.isOriginalSheet) {
                await model.getIsAbsenceIntersecte();
                if (model.absenceIntersecte != null) {
                  _isHideDates = true;
                } else {
                  _isHideDates = false;
                  model.request?.scheduleStartDate = null;
                  model.request?.scheduleEndDate = null;
                  model.request?.newStartDate = null;
                  model.request?.newEndDate = null;
                  model.request?.periodDateFrom = null;
                  model.request?.periodDateTo = null;
                }
                _isHideOriginalSheet = true;
              } else {
                _isHideOriginalSheet = false;
                model.request.originalSheet = null;
              }
              await model.calculateDay();
              model.setBusy(false);
            },
          ),
          // FieldBones(
          //   isRequired: true,
          //   placeholder: S.current.dateTo,
          //   leading: calendarWidgetForFormFiled,
          //   textValue: model.request?.dateTo == null ? '__ ___, _____' : formatShortly(model.request?.dateTo),
          //   selector: () => DateTimeSelector(
          //     mode: CupertinoDatePickerMode.date,
          //     minimumDate: model.request.requestDate,
          //     onDateTimeChanged: (DateTime newDT) async {
          //       model.request?.dateTo = newDT;
          //       // model.request.absenceDays = 1;
          //       if (model.request.vacationScheduleRequest != null && model.request.vacationScheduleRequest.endDate != newDT) {
          //         model.request.vacationScheduleRequest = null;
          //       }
          //       //проверка Пользовать сейчас в отпуске
          //       if (model.request.type != null && model.request.type.isOriginalSheet) {
          //         await model.getIsAbsenceIntersecte();
          //         if (model.absenceIntersecte != null) {
          //           _isHideDates = true;
          //         } else {
          //           _isHideDates = false;
          //           model.request?.scheduleStartDate = null;
          //           model.request?.scheduleEndDate = null;
          //           model.request?.newStartDate = null;
          //           model.request?.newEndDate = null;
          //           model.request?.periodDateFrom = null;
          //           model.request?.periodDateTo = null;
          //         }
          //         _isHideOriginalSheet = true;
          //       } else {
          //         _isHideOriginalSheet = false;
          //         model.request.originalSheet = null;
          //       }
          //       await model.calculateDay();
          //       model.setBusy(false);
          //     },
          //   ),
          // ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.days1,
            textValue: model.request?.absenceDays?.toString() ?? '',
          ),
          // FieldBones(
          //   isTextField: true,
          //   isRequired: model.request?.type?.isJustRequired ?? false,
          //   placeholder: S.current.absPurpose,
          //   onChanged: (String val) {
          //     model?.request?.purposeText = val;
          //   },
          //   textValue: model.request?.purposeText ?? '',
          // ),
          FieldBones(
            isTextField: true,
            isRequired: model.request?.type?.isJustRequired ?? false,
            placeholder: S.current.absPurpose,
            onChanged: (String val) {
              model?.request?.reason = val;
            },
            textValue: model.request?.reason ?? '',
          ),
          // ignore: always_specify_types
          FilesWidget(model: model),
          Container(
            child: _isHideOriginalSheet
                ? Column(
                    children: <Widget>[
                      KzmCheckboxListTile(
                        value: model.request?.originalSheet ?? false,
                        onChanged: (bool newVal) {
                          setState(() {
                            model.request?.originalSheet = newVal;
                          });
                        },
                        title: Text(S.current.origListText),
                      ),
                    ],
                  )
                : null,
          ),
          Container(
            child: _isHideDates
                ? Column(
                    children: [
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.periodDateFrom,
                        textValue: model.request?.scheduleStartDate == null
                            ? '__ ___, _____'
                            : formatShortly(model.request?.scheduleStartDate),
                      ),
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.periodDateTo,
                        textValue: model.request?.scheduleEndDate == null
                            ? '__ ___, _____'
                            : formatShortly(model.request?.scheduleEndDate),
                      ),
                      KzmCheckboxListTile(
                        value: model.request?.addNextYear ?? false,
                        onChanged: (bool newVal) {
                          setState(() {
                            model.request?.addNextYear = newVal;
                          });
                        },
                        title: Text(S.current.joinToNextYearAbsence),
                      ),
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.usedAbsenceDateFrom,
                        textValue: model.request?.newStartDate == null
                            ? '__ ___, _____'
                            : formatShortly(model.request?.newStartDate),
                        selector: () => DateTimeSelector(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDT) {
                            model.request?.newStartDate = newDT;
                            model.setBusy(false);
                          },
                        ),
                      ),
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.usedAbsenceDateTo,
                        textValue: model.request?.newEndDate == null
                            ? '__ ___, _____'
                            : formatShortly(model.request?.newEndDate),
                        selector: () => DateTimeSelector(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDT) {
                            model.request?.newEndDate = newDT;
                            model.setBusy(false);
                          },
                        ),
                      ),
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.periodAbsenceDateFrom,
                        textValue: model.request?.periodDateFrom == null
                            ? '__ ___, _____'
                            : formatShortly(model.request?.periodDateFrom),
                        selector: () => DateTimeSelector(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDT) {
                            model.request?.periodDateFrom = newDT;
                            model.setBusy(false);
                          },
                        ),
                      ),
                      FieldBones(
                        leading: calendarWidgetForFormFiled,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.periodAbsenceDateTo,
                        textValue: model.request?.periodDateTo == null
                            ? '__ ____, _____'
                            : formatShortly(model.request?.periodDateTo),
                        selector: () => DateTimeSelector(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDT) {
                            model.request?.periodDateTo = newDT;
                            model.setBusy(false);
                          },
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }

  selectContract(AbsenceRequestModel model) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0.6,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Container(
        color: Colors.transparent,
        height: size.height * 0.8,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.w),
              child: Container(
                height: 5.h,
                width: size.width / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Styles.appBrightBlueColor.withOpacity(0.4),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Styles.appWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                S.current.changeAbsenceVacationType,
                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (_, int i) {
                    bool current = false;
                    if (model?.request?.type != null) {
                      current = model.absenceType[i].id == model.request.type.id;
                    }
                    return Container(
                      color: Styles.appWhiteColor,
                      child: InkWell(
                        child: SelectItem(
                          model.absenceType[i].instanceName ?? '',
                          current,
                        ),
                        onTap: () => setState(() {
                          if (!current) {
                            model.request.type = model.absenceType[i];
                            setState(() {});
                            GlobalNavigator.pop();
                          }
                        }),
                      ),
                    );
                  },
                  separatorBuilder: (_, int index) => const SizedBox(),
                  itemCount:model.absenceType?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  selectShedule(AbsenceRequestModel model) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0.6,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Container(
        color: Colors.transparent,
        height: size.height * 0.5,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.w),
              child: Container(
                height: 5.h,
                width: size.width / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Styles.appBrightBlueColor.withOpacity(0.4),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Styles.appWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                S.current.vacationSchedule,
                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (_, int i) {
                    bool current = false;
                    if (model?.request?.vacationScheduleRequest != null) {
                      current = model.vacationSchedule[i].id == model.request.vacationScheduleRequest.id;
                    }
                    return Container(
                      color: Styles.appWhiteColor,
                      child: InkWell(
                        child: SelectItem(
                          '${formatFullNotMilSec(model.vacationSchedule[i]?.startDate) ?? ''} - ${formatFullNotMilSec(model.vacationSchedule[i]?.endDate) ?? ''}',
                          current,
                        ),
                        onTap: () => setState(() {
                          if (!current) {
                            model.request.vacationScheduleRequest = model.vacationSchedule[i];
                            setState(() {});
                            GlobalNavigator.pop();
                          }
                        }),
                      ),
                    );
                  },
                  separatorBuilder: (_, int index) => const SizedBox(),
                  itemCount:model.vacationSchedule?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
