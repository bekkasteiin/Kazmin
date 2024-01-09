
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/experience/experience_request_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/experience/experience_form_edit.dart';

class ExperienceRequestFormEdit extends StatefulWidget {
  @override
  _ExperienceRequestFormEditState createState() => _ExperienceRequestFormEditState();
}

class _ExperienceRequestFormEditState extends State<ExperienceRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExperienceRequestModel>(
      builder: (BuildContext context, ExperienceRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.experience,
                ),
                fields(model: model),
                BpmTaskList<ExperienceRequestModel>(model),
                StartBpmProcess<ExperienceRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required ExperienceRequestModel model}) {
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
            placeholder: S.current.experienceCompany,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.company,
            onChanged: (String data) => model.request.company = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.experienceJob,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.job,
            onChanged: (String data) => model.request.job = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.experienceStartDate,
            textValue: model.request?.startMonth == null ? '__ ___, _____' : formatShortly(model.request?.startMonth),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.startMonth = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.startMonth != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.startMonth != null
                ? () {
                    model.request?.startMonth = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.experienceEndDate,
            textValue: model.request?.endMonth == null ? '__ ___, _____' : formatShortly(model.request?.endMonth),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.endMonth = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.endMonth != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.endMonth != null
                ? () {
                    model.request?.endMonth = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.experienceLocation,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.location,
            onChanged: (String data) => model.request.location = data,
          ),
          FilesWidget<ExperienceRequestModel>(
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
