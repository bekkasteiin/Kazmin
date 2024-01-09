// ignore_for_file: always_specify_types

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/hr_requests/all_absence_request/change_days/change_absence_form_edit.dart';

class ChangeAbsenceFormEdit extends StatefulWidget {
  @override
  _ChangeAbsenceFormEditState createState() => _ChangeAbsenceFormEditState();
}

class _ChangeAbsenceFormEditState extends State<ChangeAbsenceFormEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File file;
  List<File> multiFile = [];

  @override
  Widget build(BuildContext context) {
    final ChangeAbsenceModel model = Provider.of<ChangeAbsenceModel>(
        context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: S.current.changeAbsenceTitle),
            fields(model: model),
            BpmTaskList(model),
            StartBpmProcess(model, hideCancel: model.isEditable),
          ],
        ),
      ),
    );
  }

  Widget fields({ChangeAbsenceModel model}) {
    model.isEditable ? SizedBox() :  model.getAbsenceNames(model.request.vacation.personGroup.id).then((value) => setState((){}));
    return KzmContentShadow(
      child: model.isEditable
          ? Column(
        children: [
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestNumber,
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestDate,
            textValue: formatShortly(model.request?.requestDate),
          ),
          // FieldBones(
          //   isRequired: true,
          //   placeholder: "Сотрудник",
          //   textValue: model.request?.employee?.instanceName ?? '',
          // ),

          if (model.request?.status?.id != toBeRevisedID)
            FieldBones(
              editable: model.isEditable,
              // editable: model.request?.status?.id != toBeRevisedID,
              isRequired: true,
              placeholder: S.current.employee,
              hintText: S.current.select,
              icon: Icons.keyboard_arrow_down,
              textValue: model.child?.fullName,
              maxLinesSubTitle: 2,
              selector: model.isEditable
                  ? () async {
                model.setBusy(true);
                model.child = await selector(
                  type: Types.services,
                  entityName: 'tsadv_MyTeamService',
                  methodName: 'getChildren',
                  body: json.encode(
                    <String, dynamic>{
                      'parentPositionGroupId': (await model
                          .personGroupForAssignment)?.currentAssignment
                          ?.positionGroup?.id,
                    },
                  ),
                  fromMap: (Map<String, dynamic> j) {
                    return MyTeamNew.fromMap(j);
                  },
                  isPopUp: true,
                ) as MyTeamNew;
                // if (!(await model.checkSelectedUserExists(pgId: model.child?.personGroupId))) model.child = null;
                if (model.child?.personGroupId == null) model.child = null;
                model.setBusy(false);
                model.request.vacation = null;
                model.request.purpose = null;
                setState(() {});
              }
                  : null,
            )
          else
            FieldBones(
              isRequired: true,
              placeholder: S.current.employee,
              textValue: model.request?.employee?.instanceName ?? '',
            ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceVacation,
            textValue: model.request?.vacation?.instanceName ?? '',
            selector: model.isEditable && model.child != null
                ? () async {
              model.setBusy(true);
              final List<Absence> ab = await model.getAbsence(
                  model.child.personGroupId);
              final List<KzmCommonItem> kzmList = [];
              for (final element in ab) {
                final String planDate = '${formatFullNotMilSec(
                    element.projectStartDate)} - ${formatFullNotMilSec(
                    element.projectEndDate)}';
                final String date = element.dateFrom == null
                    ? planDate
                    : element.instanceName;
                kzmList.add(KzmCommonItem(id: element.id, text: date));
              }

              final KzmCommonItem kz = await selector(
                values: kzmList,
                isPopUp: true,
              ) as KzmCommonItem;
              if (kz != null) {
                model.request.vacation =
                    ab.firstWhere((element) => element.id == kz.id);
                if (model.request.vacation.dateTo == null ||
                    model.request.vacation.dateFrom == null) {
                  model.request.vacation.instanceName = '${formatFullNotMilSec(
                      model.request.vacation
                          .projectStartDate)} - ${formatFullNotMilSec(
                      model.request.vacation.projectEndDate)}';

                  model.request.scheduleStartDate =
                      model.request.vacation.projectStartDate;
                  model.request.scheduleEndDate =
                      model.request.vacation.projectEndDate;
                } else {
                  model.request.scheduleStartDate =
                      model.request.vacation.dateFrom;
                  model.request.scheduleEndDate = model.request.vacation.dateTo;
                }
              }

              // if (!(await model.checkSelectedUserExists(pgId: model.child?.personGroupId))) model.child = null;
              if (model.child?.personGroupId == null) model.child = null;
              model.setBusy(false);
              // model.request.vacation = null;
              model.request.purpose = null;
              setState(() {});
            }
                : null,
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceScheduleStartDate,
            textValue: formatShortly(model.request?.scheduleStartDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceScheduleEndDate,
            textValue: formatShortly(model.request.scheduleEndDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceNewStartDate,
            textValue: model.request?.newStartDate != null ? formatShortly(
                model.request?.newStartDate) : '__ ___, _____',
            selector: () =>
                DateTimeSelector(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: model.request.requestDate,
                  // maximumDate: model.absenceForRecall?.vacation?.dateTo,
                  onDateTimeChanged: (DateTime newDT) {
                    model.request?.newStartDate = newDT;
                    setState(() {});
                  },
                ),
            icon: model.request?.newStartDate != null
                ? Icons.cancel_outlined
                : Icons.keyboard_arrow_down,
            iconColor: model.request?.newStartDate != null ? Colors.red : null,
            iconTap: model.request?.newStartDate != null
                ? () {
              model.request?.newStartDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceNewEndDate,
            textValue: model.request?.newEndDate != null ? formatShortly(
                model.request?.newEndDate) : '__ ___, _____',
            selector: () =>
                DateTimeSelector(
                  minimumDate: model.request?.requestDate,
                  // maximumDate: model.absenceForRecall?.vacation?.dateTo,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDT) {
                    model.request?.newEndDate = newDT;
                    setState(() {});
                  },
                ),
            icon: model.request?.newEndDate != null
                ? Icons.cancel_outlined
                : Icons.keyboard_arrow_down,
            iconColor: model.request?.newEndDate != null ? Colors.red : null,
            iconTap: model.request?.newEndDate != null
                ? () {
              model.request?.newEndDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FutureBuilder(
            future: model.intNewRequestDays,
            builder: (BuildContext ctx, AsyncSnapshot s) {
              return FieldBones(
                isRequired: false,
                placeholder: S.current.absenceDays,
                textValue: (s.data ?? '').toString(),
              );
            },
          ),
          FutureBuilder(
            future: model.doubleBalanceDays,
            builder: (BuildContext ctx, AsyncSnapshot s) {
              return FieldBones(
                isRequired: false,
                placeholder: S.current.absenceBalance,
                textValue: (s.data ?? '').toString(),
              );
            },
          ),
          FieldBones(
            placeholder: S.current.changeAbsencePeriodStartDate,
            textValue: model.request?.periodStartDate != null ? formatShortly(
                model.request?.periodStartDate) : '__ ___, _____',
            selector: () =>
                DateTimeSelector(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: model.request?.requestDate,
                  // maximumDate: model.absenceForRecall?.vacation?.dateTo,
                  onDateTimeChanged: (DateTime newDT) {
                    model.request?.periodStartDate = newDT;
                    setState(() {});
                  },
                ),
            icon: model.request?.periodStartDate != null
                ? Icons.cancel_outlined
                : Icons.keyboard_arrow_down,
            iconColor: model.request?.periodStartDate != null
                ? Colors.red
                : null,
            iconTap: model.request?.periodStartDate != null
                ? () {
              model.request?.periodStartDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            placeholder: S.current.changeAbsencePeriodEndDate,
            textValue: model.request?.periodEndDate != null ? formatShortly(
                model.request?.periodEndDate) : '__ ___, _____',
            selector: () =>
                DateTimeSelector(
                  minimumDate: model.request?.requestDate,
                  // maximumDate: model.absenceForRecall?.vacation?.dateTo,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDT) {
                    model.request?.periodEndDate = newDT;
                    setState(() {});
                  },
                ),
            icon: model.request?.periodEndDate != null
                ? Icons.cancel_outlined
                : Icons.keyboard_arrow_down,
            iconColor: model.request?.periodEndDate != null ? Colors.red : null,
            iconTap: model.request?.periodEndDate != null
                ? () {
              model.request?.periodEndDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.purpose,
            textValue: model.request?.purpose?.instanceName ?? '',
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
            selector: () async {
              model.setBusy(true);
              model.request?.purpose = await selector(
                entityName: 'tsadv_DicPurposeAbsence',
                fromMap: (Map<String, dynamic> json) =>
                    AbstractDictionary.fromMap(json),
                isPopUp: true,
              ) as AbstractDictionary;
              if (model.request?.purpose == null ||
                  model.request?.purpose?.code == null ||
                  !(model.request?.purpose?.code == 'OTHER')) {
                model?.request?.purposeText = null;
              }
              setState(() {});
              model.setBusy(false);
            },
          ),
          if (model.request?.purpose?.code == 'OTHER')
            FieldBones(
              isTextField: true,
              isRequired: true,
              placeholder: S.current.purpose,
              onChanged: (String val) {
                model?.request?.purposeText = val;
              },
              textValue: model.request?.purposeText ?? '',
            )
          else
            Column(),
          // filesContainer(model: model),
          FilesWidget<ChangeAbsenceModel>(
            isRequired: true,
            model: model,
            editable: model.isEditable,
          ),
        ],
      )
          : Column(
        children: [
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestNumber,
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.requestDate,
            textValue: formatShortly(model.request?.requestDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceVacationType,
            textValue: model.request?.vacation?.type?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceVacation,
            textValue: model.request.vacation.instanceName == ' - '?
           model.nameAbsence : model.request.vacation?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceScheduleStartDate,
            textValue: formatShortly(model.request?.scheduleStartDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceScheduleEndDate,
            textValue: formatShortly(model.request.scheduleEndDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceNewStartDate,
            textValue: model.request?.newStartDate != null ? formatShortly(
                model.request?.newStartDate) : '__ ___, _____',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsenceNewEndDate,
            textValue: model.request?.newEndDate != null ? formatShortly(
                model.request?.newEndDate) : '__ ___, _____',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsencePeriodStartDate,
            textValue: model.request?.periodStartDate != null ? formatShortly(
                model.request?.periodStartDate) : '__ ___, _____',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.changeAbsencePeriodEndDate,
            textValue: model.request?.periodEndDate != null ? formatShortly(
                model.request?.periodEndDate) : '__ ___, _____',
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.purpose,
            textValue: model.request?.purpose?.instanceName ?? '',
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
          ),
          if (model.request?.purpose?.code == 'OTHER')
            FieldBones(
              isTextField: true,
              isRequired: true,
              placeholder: S.current.purpose,
              onChanged: (String val) {
                model?.request?.purposeText = val;
              },
              textValue: model.request?.purposeText ?? '',
            ),
          // filesContainer(model: model),
          FilesWidget<ChangeAbsenceModel>(
            isRequired: true,
            model: model,
            editable: model.isEditable,
          ),
          // if (model.pgId == model.request.employee.id)
          //   Column(
          //     children: [
          //       KzmCheckboxListTile(
          //         value: model.request?.agree,
          //         onChanged: (bool newVal) {
          //           setState(() {
          //             model.request?.agree = newVal;
          //           });
          //         },
          //         title: Text(
          //           S.current.agree,
          //           style: Styles.mainTS.copyWith(
          //             fontSize: 16,
          //             color: Styles.appDarkGrayColor,
          //           ),
          //         ),
          //       ),
          //       KzmCheckboxListTile(
          //         value: model.request?.familiarization,
          //         onChanged: (bool newVal) {
          //           setState(() {
          //             model.request?.familiarization = newVal;
          //           });
          //         },
          //         title: Text(
          //           S.current.familiarization,
          //           style: Styles.mainTS.copyWith(
          //             fontSize: 16,
          //             color: Styles.appDarkGrayColor,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }

}