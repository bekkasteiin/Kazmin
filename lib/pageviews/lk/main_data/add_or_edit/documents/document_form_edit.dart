// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_request_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/documents/document_form_edit.dart';

class PersonDocumentRequestFormEdit extends StatefulWidget {
  @override
  _PersonDocumentRequestFormEditState createState() => _PersonDocumentRequestFormEditState();
}

class _PersonDocumentRequestFormEditState extends State<PersonDocumentRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonDocumentRequestModel>(
      builder: (BuildContext context, PersonDocumentRequestModel model, _) {
        return Scaffold(
          // appBar: defaultAppBar(context),
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.personDocument,
                ),
                fields(model: model),
                BpmTaskList<PersonDocumentRequestModel>(model),
                StartBpmProcess<PersonDocumentRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required PersonDocumentRequestModel model}) {
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
            // textValue: model.personExt?.first?.instanceName,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.documentType,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.documentType?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.documentType = await selector(
                entity: model.request.documentType,
                entityName: 'tsadv\$DicDocumentType',
                fromMap: (Map<String, dynamic> json) => DicAbsenceType.fromMap(json),
                filter: CubaEntityFilter(
                  returnCount: true,
                  view: '_local',
                  filter: Filter(
                    conditions: <FilterCondition>[
                      FilterCondition(
                        property: 'isIdOrPassport',
                        conditionOperator: Operators.equals,
                        value: 'TRUE',
                      ),
                      FilterCondition(
                        property: 'company.id',
                        conditionOperator: Operators.inList,
                        value: model.companies,
                      )
                    ],
                  ),
                ),
                isPopUp: true,
              ) as DicAbsenceType;
              model.isIssuingAuthorityRequired = !(model.request?.documentType?.foreigner ?? false);
              setState(() {});
              model.setBusy(false);
            },
            isRequired: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: model.isIssuingAuthorityRequired,
            placeholder: S.current.issuingAuthority,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.issuingAuthority?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.issuingAuthority = await selector(
                entity: model.request.issuingAuthority,
                entityName: 'tsadv_DicIssuingAuthority',
                fromMap: (Map<String, dynamic> json) => DicAbsenceType.fromMap(json),
                isPopUp: true,
              ) as DicAbsenceType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.issuingAuthorityExpats,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.issuedBy,
            onChanged: (String data) => model.request.issuedBy = data,
            // textValue: model.personExt.first.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.validFromDate,
            textValue: model.request?.issueDate == null ? '__ ___, _____' : formatShortly(model.request?.issueDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.issueDate = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.issueDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.issueDate != null
                ? () {
                    model.request?.issueDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.validToDate,
            textValue: model.request?.expiredDate == null ? '__ ___, _____' : formatShortly(model.request?.expiredDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.expiredDate = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.expiredDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.expiredDate != null
                ? () {
                    model.request?.expiredDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.documentNumber,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.documentNumber,
            onChanged: (String data) => model.request.documentNumber = data,
            // textValue: model.personExt.first.instanceName,
          ),
          FilesWidget<PersonDocumentRequestModel>(
            isRequired: true,
            model: model,
            // editable: !model.historyExists,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}
