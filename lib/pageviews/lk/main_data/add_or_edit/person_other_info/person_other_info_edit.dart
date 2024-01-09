import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_model.dart';
import 'package:provider/provider.dart';

class PersonOtherInfoRequestFormEdit extends StatefulWidget {
  @override
  _PersonOtherInfoRequestFormEditState createState() =>
      _PersonOtherInfoRequestFormEditState();
}

class _PersonOtherInfoRequestFormEditState
    extends State<PersonOtherInfoRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonOtherInfoRequestModel>(
      builder: (BuildContext context, PersonOtherInfoRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.personExt,
                ),
                fields(model: model),
                BpmTaskList<PersonOtherInfoRequestModel>(model),
                StartBpmProcess<PersonOtherInfoRequestModel>(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required PersonOtherInfoRequestModel model}) {
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
            isRequired: false,
            placeholder: S.current.childUnderTo18,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: kzmOverrideAllHoursByDay
                .firstWhere(
                  (KzmCommonItem item) =>
                      item.id ==
                      (model.request?.entityData
                              ?.childUnder18WithoutFatherOrMother ??
                          'NO'),
                  orElse: () => null,
                )
                ?.text,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.childUnder18WithoutFatherOrMother =
                  (await selector(
                values: kzmOverrideAllHoursByDay,
                isPopUp: true,
              ) as KzmCommonItem)
                      ?.id;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.childUnderTo14,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: kzmOverrideAllHoursByDay
                .firstWhere(
                  (KzmCommonItem item) =>
                      item.id ==
                      (model.request?.entityData
                              ?.childUnder14WithoutFatherOrMother ??
                          'NO'),
                  orElse: () => null,
                )
                ?.text,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.entityData.childUnder14WithoutFatherOrMother =
                  (await selector(
                values: kzmOverrideAllHoursByDay,
                isPopUp: true,
              ) as KzmCommonItem)
                      ?.id;
              model.setBusy(false);
            },
          ),
          FilesWidget<PersonOtherInfoRequestModel>(
            isRequired: true,
            model: model,
            // editable: !model.historyExists,
            editable: model.isEditable,
          ),
          const Text(
            'После успешного согласования заявки Вам обязательно необходимо предоставить оригинал заявления в бухгалтерию!',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

//44586
