import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:provider/provider.dart';

class AbsenceRequestFormView extends StatefulWidget {
  @override
  _AbsenceRequestFormViewState createState() => _AbsenceRequestFormViewState();
}

class _AbsenceRequestFormViewState extends State<AbsenceRequestFormView> {
  @override
  Widget build(BuildContext context) {
    final AbsenceRequestModel model = Provider.of<AbsenceRequestModel>(context);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                pageTitle(title: S.current.absenceRequest),
                KzmContentShadow(
                  child: fields(model: model),
                ),
                BpmTaskList(model),
                StartBpmProcess(model)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fields({AbsenceRequestModel model}) {
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: S.current.requestNum,
          textValue: model?.request?.requestNumber.toString() ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.status,
          textValue: model?.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.requestDate,
          textValue: formatShortly(model?.request?.requestDate) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.changeAbsenceVacationType,
          textValue: model?.request?.type?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.dateFrom,
          textValue: '${formatShortly(model.request.dateFrom) ?? ''} ${model.request?.startTime ?? '00:00'}',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.dateTo,
          textValue: '${formatShortly(model.request.dateTo) ?? ''} ${model.request?.endTime ?? '00:00'}'
        ),
        FieldBones(
            placeholder: S.current.days1,
            textValue: model?.request?.absenceDays.toString() ?? ''),
        // FieldBones(
        //   placeholder: 'Обоснование',
        //   textValue: model?.request?.purposeText ?? '',
        // ),
        FilesWidget(
          model: model,
          editable: false,
        )
      ],
    );
  }
}
