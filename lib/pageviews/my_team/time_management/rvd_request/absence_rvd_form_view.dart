import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_rvd_model.dart';
import 'package:provider/provider.dart';

class AbsenceRvdFormView extends StatefulWidget {
  @override
  _AbsenceRvdFormViewState createState() => _AbsenceRvdFormViewState();
}

class _AbsenceRvdFormViewState extends State<AbsenceRvdFormView> {
  @override
  Widget build(BuildContext context) {
    final AbsenceRvdModel model = Provider.of<AbsenceRvdModel>(context);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: 'Заявки на РВД,Сверхуроч.'),
            KzmContentShadow(
              child: fields(model: model),
            ),
            BpmTaskList(model),
            StartBpmProcess(model, disableSaveButton: true)
          ],
        ),
      ),
    );
  }

  Widget fields({AbsenceRvdModel model}) {
    bool enableChecks = false;
    if (model.request.id != null && model.tasks != null) {
      for (final User user in model.tasks.last.assigneeOrCandidates) {
        if (user.id == model.userInfo.id) {
          enableChecks = true;
          break;
        }
      }
    }
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: 'Номер заявки',
          textValue: model.request?.requestNumber?.toString() ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Статус',
          textValue: model?.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявка',
          textValue: formatShortly(model?.request?.requestDate) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Тип отсутствие',
          textValue: model?.request?.type?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Обоснование',
          textValue: model?.request?.purpose?.instanceName ?? '',
        ),
        Column(
          children: [
            KzmCheckboxListTile(
              value: model.request.compensation,
              onChanged: enableChecks
                  ? (bool newVal) {
                      setState(() {
                        model.request.compensation = newVal;
                        model.request.vacationDay = !newVal;
                      });
                    }
                  : null,
              title: Text(
                'Компенсационная выплата',
                style: Styles.mainTS.copyWith(
                  fontSize: 16,
                  color: Styles.appDarkGrayColor,
                ),
              ),
            ),
            KzmCheckboxListTile(
              value: model.request.vacationDay,
              onChanged: enableChecks
                  ? (bool newVal) {
                      setState(() {
                        model.request?.vacationDay = newVal;
                        model.request?.compensation = !newVal;
                      });
                    }
                  : null,
              title: Text(
                'Предоставление дней отдыха (отгулов)',
                style: Styles.mainTS.copyWith(
                  fontSize: 16,
                  color: Styles.appDarkGrayColor,
                ),
              ),
            ),
          ],
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Время начала работы',
          textValue: formatFull(model?.request?.timeOfStarting) ?? '',
        ),
        FieldBones(
          placeholder: 'Время окончания работы',
          textValue: formatFull(model?.request?.timeOfFinishing) ?? '',
        ),
        FieldBones(
          placeholder: 'Общее кол-во часов работы',
          textValue: model?.request?.totalHours?.toString() ?? '',
        ),
        KzmCheckboxListTile(
          value: model.request?.agree,
          onChanged: enableChecks
              ? (bool newVal) {
                  setState(() {
                    model.request?.agree = newVal;
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
        filesContainer(path: model.request.files, model: model)
      ],
    );
  }

  Widget filesContainer({List<FileDescriptor> path, AbsenceRvdModel model}) {
    return KzmFileDescriptorsWidget(
      editable: false,
      list: Column(
        mainAxisSize: MainAxisSize.min,
        children: path != null && path.isNotEmpty
            ? path.map((FileDescriptor e) {
                final String fileName = e.name;
                return KzmFileTile(
                  fileName: fileName,
                  onTap: () {
                    path.remove(e);
                    setState(() {});
                  },
                  fileDescriptor: e,
                );
              }).toList()
            : [noData],
      ),
    );
  }
}
