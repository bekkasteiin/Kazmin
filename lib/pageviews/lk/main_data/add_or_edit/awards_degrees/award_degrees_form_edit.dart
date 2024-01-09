import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kind_of_award.dart';
import 'package:kzm/core/models/entities/tsadv_dic_promotion_type.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_request_model.dart';
import 'package:provider/provider.dart';

class AwardDegreesRequestFormEdit extends StatefulWidget {
  @override
  _AwardDegreesRequestFormEditState createState() => _AwardDegreesRequestFormEditState();
}

class _AwardDegreesRequestFormEditState extends State<AwardDegreesRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AwardDegreesRequestModel>(
      builder: (BuildContext context, AwardDegreesRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.awardsDegrees,
                ),
                fields(model: model),
                BpmTaskList<AwardDegreesRequestModel>(model),
                StartBpmProcess<AwardDegreesRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required AwardDegreesRequestModel model}) {
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
            placeholder: S.current.awardsDegreesType,
            textValue: model.request?.entityData?.type?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.type = await selector(
                entityName: TsadvDicPromotionType.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicPromotionType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicPromotionType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.awardsDegreesKind,
            textValue: model.request?.entityData?.kind?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.kind = await selector(
                entityName: TsadvDicKindOfAward.entity,
                fromMap: (Map<String, dynamic> json) => TsadvDicKindOfAward.fromMap(json),
                isPopUp: true,
              ) as TsadvDicKindOfAward;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.dateFrom,
            textValue: model.request?.entityData?.startDate == null ? '__ ___, _____' : formatShortly(model.request?.entityData?.startDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.entityData?.startDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.entityData?.startDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.entityData?.startDate != null
                ? () {
                    model.request?.entityData?.startDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.dateTo,
            textValue: model.request?.entityData?.endDate == null ? '__ ___, _____' : formatShortly(model.request?.entityData?.endDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.entityData?.endDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.entityData?.endDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.entityData?.endDate != null
                ? () {
                    model.request?.entityData?.endDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.awardsDegreesDescription,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.entityData?.description,
            onChanged: (String data) => model.request.entityData.description = data,
            // textValue: model.personExt.first.instanceName,
          ),
          FilesWidget<AwardDegreesRequestModel>(
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
