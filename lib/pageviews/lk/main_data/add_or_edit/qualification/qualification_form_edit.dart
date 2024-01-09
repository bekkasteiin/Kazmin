import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/tsadv_dic_education_document_type.dart';
// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_request_model.dart';
import 'package:provider/provider.dart';

class QualificationRequestFormEdit extends StatefulWidget {
  @override
  _QualificationRequestFormEditState createState() => _QualificationRequestFormEditState();
}

class _QualificationRequestFormEditState extends State<QualificationRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QualificationRequestModel>(
      builder: (BuildContext context, QualificationRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.qualification,
                ),
                fields(model: model),
                BpmTaskList<QualificationRequestModel>(model),
                StartBpmProcess<QualificationRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required QualificationRequestModel model}) {
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
            textValue: formatFullNotMilSec(dateFormatFullRestNotMilSec.parse(model.request?.requestDate)),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.langValue,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.educationDocumentType,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.educationDocumentType?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.educationDocumentType = await selector(
                entity: model.request.educationDocumentType,
                entityName: 'tsadv_DicEducationDocumentType',
                filter: CubaEntityFilter(
                  filter: Filter(
                    conditions: <FilterCondition>[
                      FilterCondition(
                        group: 'OR',
                        conditions: <ConditionCondition>[
                          ConditionCondition(property: 'company.code', conditionOperator: Operators.equals, value: 'KBL'),
                          ConditionCondition(property: 'company.code', conditionOperator: Operators.equals, value: 'empty'),
                        ],
                      ),
                      // FilterCondition(
                      //   property: 'company.code',
                      //   conditionOperator: Operators.equals,
                      //   value: 'KBL',
                      // ),
                    ],
                  ),
                ),
                fromMap: (Map<String, dynamic> json) => TsadvDicEducationDocumentType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicEducationDocumentType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.qualificationProfession,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.profession,
            onChanged: (String data) => model.request.profession = data,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.qualificationQualification,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.qualification,
            onChanged: (String data) => model.request.qualification = data,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.personContactStartDate,
            textValue: model.request?.startDate == null ? '__ ___, _____' : formatShortly(model.request?.startDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.startDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.startDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.startDate != null
                ? () {
              model.request?.startDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.personContactEndDate,
            textValue: model.request?.endDate == null ? '__ ___, _____' : formatShortly(model.request?.endDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.endDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.endDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.endDate != null
                ? () {
              model.request?.endDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.qualificationEducationalInstitutionName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.educationalInstitutionName,
            onChanged: (String data) => model.request.educationalInstitutionName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.educationCourseName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.courseName,
            onChanged: (String data) => model.request.courseName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.qualificationIssuedDate,
            textValue: model.request?.issuedDate == null ? '__ ___, _____' : formatShortly(model.request?.issuedDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.issuedDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.issuedDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.issuedDate != null
                ? () {
              model.request?.issuedDate = null;
              setState(() {});
            }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.qualificationDiploma,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.diploma,
            onChanged: (String data) => model.request.diploma = data,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.educationExpiryDate,
            textValue: model.request?.expiryDate == null ? '__ ___, _____' : formatShortly(model.request?.expiryDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.expiryDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.expiryDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.expiryDate != null
                ? () {
                    model.request?.expiryDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FilesWidget<QualificationRequestModel>(
            // isRequired: true,
            model: model,
            // editable: !model.historyExists,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}

//44586
