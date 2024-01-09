import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:provider/provider.dart';

class ScheduleOffsetsFormEdit extends StatefulWidget {
  @override
  _ScheduleOffsetsFormEditState createState() => _ScheduleOffsetsFormEditState();
}

class _ScheduleOffsetsFormEditState extends State<ScheduleOffsetsFormEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ScheduleRequestModel model = Provider.of<ScheduleRequestModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: 'Заявка на смену графика'),
            contentShadow(
              child: fields(model: model),
            ),
            StartBpmProcess(model)
          ],
        ),
      ),
    );
  }

  Widget fields({ScheduleRequestModel model}) {
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: '№ заявки',
          textValue: model.request.requestNumber.toString() ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Статус',
          textValue: model.request.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявки',
          textValue: formatShortly(model.request.requestDate),
        ),
        FieldBones(
          isRequired: false,
          placeholder: 'Сотрудник',
          textValue: model?.request.personGroup?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Новый график',
          textValue: model.request.newSchedule?.instanceName ?? '',
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
          selector: () async {
            model.request.newSchedule = await selector(
              entityName: 'tsadv\$StandardSchedule',
              fromMap: (Map<String, dynamic> json) => CurrentSchedule.fromMap(json),
              isPopUp: true,
            ) as CurrentSchedule;
            if (model.request.newSchedule == null) {}
            setState(() {});
            model.setBusy(false);
          },
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Обоснование',
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
          selector: () async {
            model.request.purpose = await selector(
              entityName: 'tsadv_DicSchedulePurpose',
              fromMap: (Map<String, dynamic> json) => Purpose.fromMap(json),
              isPopUp: true,
            ) as Purpose;
            if (model.request.purpose == null || !(model.request.purpose?.instanceName == 'Другое' || !(model.request.purpose?.code == 'OTHER'))) {
              model?.request.purposeText = null;
            }
            setState(() {});
            model.setBusy(false);
          },
          textValue: model.request.purpose?.instanceName ?? '',
        ),
        if (model.request.purpose?.instanceName == 'Другое' || model.request.purpose?.code == 'OTHER') FieldBones(
                isTextField: true,
                isRequired: true,
                placeholder: 'Обоснование',
                onChanged: (String val) {
                  model?.request.purposeText = val;
                },
                textValue: model.request.purposeText ?? '',
              ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата нового графика',
          textValue: model.request.dateOfNewSchedule != null ? formatShortly(model.request.dateOfNewSchedule) : '__ ___, _____',
          selector: () => DateTimeSelector(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDT) {
              model.request.dateOfNewSchedule = newDT;
              setState(() {});
            },
          ),
          icon: model.request.dateOfNewSchedule != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
          iconColor: model.request.dateOfNewSchedule != null ? Colors.red : null,
          iconTap: model.request.dateOfNewSchedule != null
              ? () {
                  model.request.dateOfNewSchedule = null;
                  setState(() {});
                }
              : null,
          iconAlignEnd: true,
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата начала работы',
          textValue: model.request.dateOfStartNewSchedule != null ? formatShortly(model.request.dateOfStartNewSchedule) : '__ ___, _____',
          selector: () => DateTimeSelector(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDT) {
              model.request.dateOfStartNewSchedule = newDT;
              setState(() {});
            },
          ),
          icon: model.request.dateOfStartNewSchedule != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
          iconColor: model.request.dateOfStartNewSchedule != null ? Colors.red : null,
          iconTap: model.request.dateOfStartNewSchedule != null
              ? () {
                  model.request.dateOfStartNewSchedule = null;
                  setState(() {});
                }
              : null,
          iconAlignEnd: true,
        ),
        const SizedBox(
          height: 5,
        ),
        FieldBones(
          isTextField: true,
          isRequired: true,
          placeholder: 'Детали фактической работы работника',
          onChanged: (val) {
            model?.request.detailsOfActualWork = val;
          },
          textValue: model.request.detailsOfActualWork ?? '',
        ),
        FieldBones(
          isTextField: true,
          isRequired: true,
          placeholder: 'Комментарий',
          onChanged: (val) {
            model?.request.comment = val;
          },
          textValue: model.request.comment ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Политика заработка',
          textValue: model.request.earningPolicy?.instanceName ?? '',
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
          selector: () async {
            model.request.earningPolicy = await selector(entityName: 'tsadv_DicEarningPolicy', fromMap: (json) => Policy.fromMap(json), isPopUp: true);
            if (model.request.earningPolicy == null) {}
            setState(() {});
            model.setBusy(false);
          },
        ),
      ],
    );
  }
}
