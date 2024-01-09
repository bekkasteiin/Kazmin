import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/tsadv_dic_attitude_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_document_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_rank.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_officer_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_suitability_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_troops_structure.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/military/military_request_model.dart';
import 'package:provider/provider.dart';

class MilitaryRequestFormEdit extends StatefulWidget {
  @override
  _MilitaryRequestFormEditState createState() => _MilitaryRequestFormEditState();
}

class _MilitaryRequestFormEditState extends State<MilitaryRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MilitaryRequestModel>(
      builder: (BuildContext context, MilitaryRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.military,
                ),
                fields(model: model),
                BpmTaskList<MilitaryRequestModel>(model),
                StartBpmProcess<MilitaryRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required MilitaryRequestModel model}) {
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
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.militaryAttitudeToMilitary,
            textValue: model.request?.entityData?.attitudeToMilitary?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.attitudeToMilitary = await selector(
                entity: model.request.entityData.attitudeToMilitary,
                entityName: TsadvDicAttitudeToMilitary.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicAttitudeToMilitary.fromMap(json),
                isPopUp: true,
              ) as TsadvDicAttitudeToMilitary;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryMilitaryDocumentType,
            textValue: model.request?.entityData?.militaryDocumentType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.militaryDocumentType = await selector(
                entity: model.request.entityData.militaryDocumentType,
                entityName: TsadvDicMilitaryDocumentType.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicMilitaryDocumentType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicMilitaryDocumentType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryDocumentNumber,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.entityData?.documentNumber,
            onChanged: (String data) => model.request.entityData.documentNumber = data,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryMilitaryType,
            textValue: model.request?.entityData?.militaryType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.militaryType = await selector(
                entity: model.request.entityData.militaryType,
                entityName: TsadvDicMilitaryType.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicMilitaryType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicMilitaryType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militarySuitabilityToMilitary,
            textValue: model.request?.entityData?.suitabilityToMilitary?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.suitabilityToMilitary = await selector(
                entity: model.request.entityData.suitabilityToMilitary,
                entityName: TsadvDicSuitabilityToMilitary.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicSuitabilityToMilitary.fromMap(json),
                isPopUp: true,
              ) as TsadvDicSuitabilityToMilitary;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryTroopsStructure,
            textValue: model.request?.entityData?.troopsStructure?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.troopsStructure = await selector(
                entity: model.request.entityData.troopsStructure,
                entityName: TsadvDicTroopsStructure.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicTroopsStructure.fromMap(json),
                isPopUp: true,
              ) as TsadvDicTroopsStructure;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryMilitaryRank,
            textValue: model.request?.entityData?.militaryRank?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.militaryRank = await selector(
                entity: model.request.entityData.militaryRank,
                entityName: TsadvDicMilitaryRank.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicMilitaryRank.fromMap(json),
                isPopUp: true,
              ) as TsadvDicMilitaryRank;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: false,
            placeholder: S.current.militaryOfficerType,
            textValue: model.request?.entityData?.officerType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.officerType = await selector(
                entity: model.request.entityData.officerType,
                entityName: TsadvDicOfficerType.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicOfficerType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicOfficerType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militarySpecialization,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.entityData?.specialization,
            onChanged: (String data) => model.request.entityData.specialization = data,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryDateFrom,
            textValue: model.request?.entityData?.dateFrom == null ? '__ ___, _____' : formatShortly(model.request?.entityData?.dateFrom),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.entityData?.dateFrom = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.entityData?.dateFrom != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.entityData?.dateFrom != null
                ? () {
                    model.request?.entityData?.dateFrom = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.militaryDateTo,
            textValue: model.request?.entityData?.dateTo == null ? '__ ___, _____' : formatShortly(model.request?.entityData?.dateTo),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.entityData?.dateTo = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.entityData?.dateTo != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.entityData?.dateTo != null
                ? () {
                    model.request?.entityData?.dateTo = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FilesWidget<MilitaryRequestModel>(
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
