import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/checkbox.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/date_time_input.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/entities/tsadv_abs_purpose_setting.dart';
import 'package:kzm/core/models/my_team/my_team.dart';

// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:provider/provider.dart';

import '../ovd_model.dart';

const String fName = 'lib/pageviews/hr_requests/ovd/view/ovd_form_edit.dart';

class OvdFormEdit extends StatefulWidget {
  @override
  _OvdFormEditState createState() => _OvdFormEditState();
}

class _OvdFormEditState extends State<OvdFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OvdModel>(
      builder: (BuildContext context, OvdModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.rvd,
                ),
                fields(model: model),
                BpmTaskList<OvdModel>(model),
                StartBpmProcess<OvdModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required OvdModel model}) {
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            editable: false,
            placeholder: S.current.requestNumber,
            textValue: model.request.requestNumber?.toString(),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.requestDate,
            textValue: formatFullNotMilSec(model.request?.requestDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName,
          ),
          if (model.isEditable)
            FieldBones(
              editable: model.isEditable,
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
                            'parentPositionGroupId': (await model.personGroupForAssignment)?.currentAssignment?.positionGroup?.id,
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
                      // model.request.absenceType = null;
                      // model.request.purpose = null;
                      setState(() {});
                    }
                  : null,
            ),
          FieldBones(
            isTextField: true,
            isRequired: true,
            placeholder: S.current.justify,
            onChanged: (String val) {
              model?.request?.justification = val;
            },
            textValue: model.request?.justification ?? '',
          ),
          SizedBox(height: Styles.appDoubleMargin),
          KzmDateTimeInput(
            caption: S.current.startDate,
            formatDateTime: dateFormatFullNumeric,
            initialDateTime: formatFullNumeric(model.request?.startDate
                ?.add(Duration(hours: model.request?.startTime?.hour, minutes: model.request?.startTime?.minute, seconds: model.request?.startTime?.second))),
            isLoading: false,
            isRequired: true,
            isActive: model.isEditable,
            onChanged: (DateTime val) {
              model.request.startDate = DateTime.parse(formatFullRestNotMilSec(val));
              model.request.startTime = DateTime.parse('0000-00-00 ${formatTimeRest(val)}');
              if ((model?.request?.endDate != null) && (model?.request?.startDate != null)) {
                model.request.days = model.request.endDate.difference(model.request.startDate).inDays;
              }
              setState(() {});
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          KzmDateTimeInput(
            caption: S.current.endDate,
            formatDateTime: dateFormatFullNumeric,
            initialDateTime: formatFullNumeric(model.request?.endDate
                ?.add(Duration(hours: model.request?.endTime?.hour, minutes: model.request?.endTime?.minute, seconds: model.request?.endTime?.second))),
            isLoading: false,
            isRequired: true,
            isActive: model.isEditable,
            onChanged: (DateTime val) {
              model.request.endDate = DateTime.parse(formatFullRestNotMilSec(val));
              model.request.endTime = DateTime.parse('0000-00-00 ${formatTimeRest(val)}');
              if ((model?.request?.endDate != null) && (model?.request?.startDate != null)) {
                model.request.days = model.request.endDate.difference(model.request.startDate).inDays;
                print('model.request.days - ${model.request.days}');
              }
              setState(() {});
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          FieldBones(
            editable: false,
            isTextField: true,
            placeholder: S.current.daysAmount,
            textValue: model.request?.days?.toString() ?? '',
          ),
          SizedBox(height: Styles.appQuadMargin),
          FieldBones(
            isTextField: true,
            placeholder: S.current.hours,
            onChanged: (String val) {
              model?.request?.hours = double.parse(val);
            },
            textValue: model.request?.hours?.toString() ?? '',
          ),
          SizedBox(height: Styles.appDoubleMargin),
          FilesWidget<OvdModel>(
            model: model,
            editable: model.isEditable,
            isRequired: true,
          ),
          // FieldBones(
          //   editable: model.isEditable && (model.child != null),
          //   isRequired: true,
          //   placeholder: S.current.type,
          //   hintText: S.current.select,
          //   icon: Icons.keyboard_arrow_down,
          //   textValue: model.request?.absenceType?.instanceName,
          //   maxLinesSubTitle: 2,
          //   selector: model.isEditable && (model.child != null)
          //       ? () async {
          //           model.setBusy(true);
          //           final List<String> _companiesForLoadDictionary = await RestServices().getCompaniesByPersonGroupId();
          //           model.request.absenceType = await selector(
          //             entityName: 'tsadv\$DicAbsenceType',
          //             filter: CubaEntityFilter(
          //               view: '_local',
          //               returnCount: true,
          //               filter: Filter(
          //                 conditions: <FilterCondition>[
          //                   FilterCondition(property: 'availableToManager', conditionOperator: Operators.equals, value: 'true'),
          //                   FilterCondition(property: 'company.id', conditionOperator: Operators.inList, value: <String>[..._companiesForLoadDictionary]),
          //                 ],
          //               ),
          //             ),
          //             fromMap: (Map<String, dynamic> j) {
          //               return DicAbsenceType.fromMap(j);
          //             },
          //             isPopUp: true,
          //           ) as DicAbsenceType;
          //           if (model.request?.absenceType?.overtimeWork ?? false) {
          //             if (await model.checkVahtaScheduleNotAllow()) {
          //               await KzmSnackbar(message: S.current.vahtaCheckAlert, autoHide: true).show();
          //               model.request.absenceType = null;
          //             }
          //           }
          //           model.setBusy(false);
          //           model.request.purpose = null;
          //           setState(() {});
          //         }
          //       : null,
          // ),
          // FieldBones(
          //   editable: model.isEditable && (model.request?.absenceType != null),
          //   isRequired: true,
          //   placeholder: S.current.absPurpose,
          //   hintText: S.current.select,
          //   icon: Icons.keyboard_arrow_down,
          //   textValue: model.request?.purpose?.instanceName,
          //   maxLinesSubTitle: 2,
          //   selector: model.isEditable && (model.request?.absenceType != null)
          //       ? () async {
          //           model.setBusy(true);
          //           model.request.purpose = (await selector(
          //             entityName: 'tsadv_AbsPurposeSetting',
          //             filter: CubaEntityFilter(
          //               view: 'absPurposeSetting-absence',
          //               filter: Filter(
          //                 conditions: <FilterCondition>[
          //                   FilterCondition(property: 'absenceType.id', conditionOperator: Operators.equals, value: model.request?.absenceType?.id),
          //                 ],
          //               ),
          //             ),
          //             fromMap: (Map<String, dynamic> json) => TsadvAbsPurposeSetting.fromMap(json),
          //             isPopUp: true,
          //           ) as TsadvAbsPurposeSetting)
          //               .absencePurpose;
          //           if (model.request?.purpose?.id != absencePurposeOtherTypeID) model.request.purposeText = null;
          //           model.setBusy(false);
          //           setState(() {});
          //         }
          //       : null,
          // ),
          // if (model.request?.purpose?.id == absencePurposeOtherTypeID)
          //   FieldBones(
          //     isRequired: true,
          //     editable: model.isEditable,
          //     placeholder: S.current.purposeText,
          //     isTextField: true,
          //     keyboardType: TextInputType.text,
          //     textValue: model.request?.purposeText,
          //     onChanged: (String data) => model.request.purposeText = data,
          //   ),
          // SizedBox(height: Styles.appDoubleMargin),
          // KzmDateTimeInput(
          //   caption: S.current.timeOfStarting,
          //   formatDateTime: dateFormatFullNumeric,
          //   initialDateTime: formatFullNumeric(model.request?.timeOfStarting),
          //   isLoading: false,
          //   isRequired: true,
          //   isActive: model.isEditable,
          //   onChanged: (DateTime val) {
          //     model.request.timeOfStarting = val.subtract(Duration(minutes: val.minute));
          //     setState(() {});
          //   },
          // ),
          // SizedBox(height: Styles.appQuadMargin),
          // KzmDateTimeInput(
          //   caption: S.current.timeOfFinishing,
          //   formatDateTime: dateFormatFullNumeric,
          //   initialDateTime: formatFullNumeric(model.request?.timeOfFinishing),
          //   isLoading: false,
          //   isRequired: true,
          //   isActive: model.isEditable,
          //   onChanged: (DateTime val) {
          //     model.request.timeOfFinishing = val.subtract(Duration(minutes: val.minute));
          //     setState(() {});
          //   },
          // ),
          // if (model.request?.absenceType?.workOnWeekend ?? false)
          //   Padding(
          //     padding: EdgeInsets.only(top: Styles.appStandartMargin),
          //     child: Column(
          //       children: <KzmCheckBox>[
          //         KzmCheckBox(
          //           isRequired: false,
          //           editable: model.isEditable,
          //           text: S.current.compensationPayment,
          //           initValue: model.request?.compensation,
          //           currValue: model.request?.compensation,
          //           onChanged: (bool val) {
          //             model.request.compensation = val;
          //             model.request.vacationDay = !val;
          //             setState(() {});
          //           },
          //         ),
          //         KzmCheckBox(
          //           isRequired: false,
          //           editable: model.isEditable,
          //           text: S.current.vacationDay,
          //           initValue: model.request?.vacationDay,
          //           currValue: model.request?.vacationDay,
          //           onChanged: (bool val) {
          //             model.request.vacationDay = val;
          //             model.request.compensation = !val;
          //             setState(() {});
          //           },
          //         ),
          //         KzmCheckBox(
          //           isRequired: false,
          //           editable: model.isEditable,
          //           text: S.current.remote,
          //           initValue: model.request?.remote,
          //           currValue: model.request?.remote,
          //           onChanged: (bool val) {
          //             model.request.remote = val;
          //             setState(() {});
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // if (model.request?.absenceType?.temporaryTransfer ?? false)
          //   Padding(
          //     padding: EdgeInsets.only(top: Styles.appMiddleMargin),
          //     child: FieldBones(
          //       editable: model.isEditable,
          //       isRequired: false,
          //       placeholder: S.current.shiftCode,
          //       hintText: S.current.select,
          //       icon: Icons.keyboard_arrow_down,
          //       textValue: model.request?.shiftCode?.text,
          //       maxLinesSubTitle: 2,
          //       selector: model.isEditable
          //           ? () async {
          //               model.setBusy(true);
          //               model.request.shiftCode = await selector(
          //                 values: kzmShiftCodes,
          //                 isPopUp: true,
          //               ) as KzmCommonItem;
          //               model.setBusy(false);
          //             }
          //           : null,
          //     ),
          //   ),
          // if ((model.request?.absenceType?.workOnWeekend ?? false) || (model.request?.absenceType?.temporaryTransfer ?? false))
          //   Padding(
          //     padding: EdgeInsets.only(top: Styles.appStandartMargin),
          //     child: FieldBones(
          //       editable: model.isEditable,
          //       isRequired: false,
          //       placeholder: S.current.shift,
          //       hintText: S.current.select,
          //       icon: Icons.keyboard_arrow_down,
          //       textValue: model.request?.shift?.instanceName,
          //       maxLinesSubTitle: 2,
          //       selector: model.isEditable
          //           ? () async {
          //               model.setBusy(true);
          //               final List<String> _companiesForLoadDictionary = await RestServices().getCompaniesByPersonGroupId();
          //               model.request.shift = await selector(
          //                 entityName: 'tsadv_DicShift',
          //                 filter: CubaEntityFilter(
          //                   view: '_local',
          //                   filter: Filter(
          //                     conditions: <FilterCondition>[
          //                       FilterCondition(property: 'active', conditionOperator: Operators.equals, value: 'TRUE'),
          //                       FilterCondition(property: 'company.id', conditionOperator: Operators.inList, value: <String>[..._companiesForLoadDictionary]),
          //                     ],
          //                   ),
          //                 ),
          //                 fromMap: (Map<String, dynamic> json) => AbstractDictionary.fromMap(json),
          //                 isPopUp: true,
          //               ) as AbstractDictionary;
          //               model.setBusy(false);
          //               setState(() {});
          //             }
          //           : null,
          //     ),
          //   ),
          // if (model.request?.absenceType?.temporaryTransfer ?? false)
          //   Padding(
          //     padding: EdgeInsets.only(top: Styles.appMiddleMargin),
          //     child: FieldBones(
          //       editable: model.isEditable,
          //       isRequired: false,
          //       placeholder: S.current.discardDayHours,
          //       hintText: S.current.select,
          //       icon: Icons.keyboard_arrow_down,
          //       textValue: model.request?.overrideAllHoursByDay?.text,
          //       maxLinesSubTitle: 2,
          //       selector: model.isEditable
          //           ? () async {
          //               model.setBusy(true);
          //               model.request.overrideAllHoursByDay = await selector(
          //                 values: kzmOverrideAllHoursByDay,
          //                 isPopUp: true,
          //               ) as KzmCommonItem;
          //               model.setBusy(false);
          //             }
          //           : null,
          //     ),
          //   ),
          // SizedBox(height: Styles.appDoubleMargin),
          // FilesWidget<OvdModel>(
          //   model: model,
          //   editable: model.isEditable,
          // ),
        ],
      ),
    );
  }
}
