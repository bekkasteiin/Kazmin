import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/expansion_tile.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_ext_task_data.dart';

class KzmProcessTaskItem extends StatelessWidget {
  // final ExtTaskData taskData;
  final TsadvExtTaskData taskData;

  const KzmProcessTaskItem({@required this.taskData});

  @override
  Widget build(BuildContext context) {
    String users = '';
    final String countUser =
        taskData.assigneeOrCandidates.length > 1 ? ' [${taskData.assigneeOrCandidates.length}]' : '';
    for (int i = 0; i < taskData.assigneeOrCandidates.length; i++) {
      if (i != taskData.assigneeOrCandidates.length - 1) {
        users = '$users${taskData.assigneeOrCandidates[i].fullName}[${taskData.assigneeOrCandidates[i].login}]\n';
      } else {
        users = '$users${taskData.assigneeOrCandidates[i].fullName}[${taskData.assigneeOrCandidates[i].login}]';
      }
    }
    return KzmExpansionTileWide(
      title: 'Пользователь$countUser',
      subtitle: users,
      children: <Widget>[
        SizedBox(height: Styles.appQuadMargin),
        KzmTextInput(
          isActive: false,
          caption: 'Роль'.tr,
          keyboardType: null,
          prefixIcon: null,
          maxLines: 1,
          initValue: taskData.hrRole?.instanceName ?? '',
        ),
        SizedBox(height: Styles.appQuadMargin),
        KzmTextInput(
          isActive: false,
          caption: 'Дата создания'.tr,
          keyboardType: null,
          prefixIcon: KzmIcons.date,
          maxLines: 1,
          initValue: taskData.createTime == null ? '' : formatFullNotMilSec(DateTime.parse(taskData.createTime)),
        ),
        SizedBox(height: Styles.appQuadMargin),
        KzmTextInput(
          isActive: false,
          caption: 'Дата окончания'.tr,
          keyboardType: null,
          prefixIcon: KzmIcons.date,
          maxLines: 1,
          initValue: taskData.endTime == null ? '' : formatFullNotMilSec(DateTime.parse(taskData.endTime)),
        ),
        SizedBox(height: Styles.appQuadMargin),
        KzmTextInput(
          isActive: false,
          caption: 'Решение'.tr,
          keyboardType: null,
          prefixIcon: null,
          maxLines: 1,
          initValue: getOutcomeNameById(taskData.outcome) ?? '',
        ),
        SizedBox(height: Styles.appQuadMargin),
        KzmTextInput(
          isActive: false,
          height: Styles.appTextFieldMultilineHeight,
          maxLines: null,
          caption: 'Комментарий'.tr,
          initValue: taskData.comment ?? '',
          prefixIcon: null,
          keyboardType: null,
        ),
      ],
    );
  }
}
