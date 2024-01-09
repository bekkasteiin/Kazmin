import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:provider/provider.dart';

class ScheduleOffsetsFormView extends StatefulWidget {
  @override
  _ScheduleOffsetsFormViewState createState() => _ScheduleOffsetsFormViewState();
}

class _ScheduleOffsetsFormViewState extends State<ScheduleOffsetsFormView> {
  @override
  Widget build(BuildContext context) {
    final ScheduleRequestModel model = Provider.of<ScheduleRequestModel>(context, listen: false);

    // MyTeamModel model = Provider.of<MyTeamModel>(context);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: 'Заявка на смену графика'),
            contentShadow(
              child: schedulePanel(model: model),
            ),
            BpmTaskList(model),
            StartBpmProcess(model)
          ],
        ),
      ),
    );
  }

  Widget schedulePanel({ScheduleRequestModel model}) {
    bool enableChecks = false;
    if (model.request.id != null && model.tasks != null) {
      enableChecks = model.tasks.last.assigneeOrCandidates.last.id == model.userInfo.id &&
          model.request?.personGroup?.id == model.pgId;
    }
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: 'Номер заявки',
          textValue: '${model?.request?.requestNumber}',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Статус',
          textValue: model?.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявки',
          textValue: formatShortly(model?.request?.requestDate) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Текущий график',
          textValue: model?.request?.newSchedule?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Обоснование',
          textValue: model?.request?.purpose?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата нового графика',
          textValue: formatFull(model?.request?.dateOfNewSchedule) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата начала работы',
          textValue: formatFull(model?.request?.dateOfStartNewSchedule),
        ),
        FieldBones(
          placeholder: 'Детали фактической работы работника',
          textValue: model?.request?.detailsOfActualWork ?? '',
        ),
        KzmCheckboxListTile(
          value: model.request?.isAgree,
          onChanged: enableChecks
              ? (bool newVal) {
                  setState(() {
                    model.request?.isAgree = newVal;
                  });
                }
              : null,
          title: Text(
            'Согласен',
            style: Styles.mainTS.copyWith(
              fontSize: 16,
              color: Styles.appDarkGrayColor,
            ),
          ),
        ),
        KzmCheckboxListTile(
          value: model.request?.acquainted,
          onChanged: enableChecks
              ? (bool newVal) {
                  setState(() {
                    model.request?.acquainted = newVal;
                  });
                }
              : null,
          title: Text(
            'Ознакомлен',
            style: Styles.mainTS.copyWith(
              fontSize: 16,
              color: Styles.appDarkGrayColor,
            ),
          ),
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Политика заработка',
          textValue: model?.request?.earningPolicy?.instanceName ?? '',
        ),
        FieldBones(
          placeholder: 'Комментарий',
          textValue: model?.request?.comment ?? '',
        ),
      ],
    );
  }

}
