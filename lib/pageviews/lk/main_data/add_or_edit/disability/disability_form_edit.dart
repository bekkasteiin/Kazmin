import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/checkbox.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/tsadv_dic_disability_type.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/disability/disability_request_model.dart';
import 'package:provider/provider.dart';

class DisabilityRequestFormEdit extends StatefulWidget {
  @override
  _DisabilityRequestFormEditState createState() => _DisabilityRequestFormEditState();
}

class _DisabilityRequestFormEditState extends State<DisabilityRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DisabilityRequestModel>(
      builder: (BuildContext context, DisabilityRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.disability,
                ),
                fields(model: model),
                BpmTaskList<DisabilityRequestModel>(model),
                StartBpmProcess<DisabilityRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required DisabilityRequestModel model}) {
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
          KzmCheckBox(
            isRequired: true,
            // editable: !model.historyExists,
            editable: model.isEditable,
            text: S.current.disabilityHasDisability,
            initValue: model.request?.entityData?.hasDisability,
            onChanged: (bool val) => model.request.entityData.hasDisability = val,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.disabilityDisabilityType,
            textValue: model.request?.entityData?.disabilityType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.disabilityType = await selector(
                entity: model.request.entityData.disabilityType,
                entityName: TsadvDicDisabilityType.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicDisabilityType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicDisabilityType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.dateFrom,
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
            isRequired: true,
            placeholder: S.current.dateTo,
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
          FilesWidget<DisabilityRequestModel>(
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

//44586
