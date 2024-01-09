import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/bpm/ext_task_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';

const String fName = 'lib/core/bpm_helpers/task/task_item.dart';

class TaskItem extends StatelessWidget {
  final ExtTaskData e;

  const TaskItem(this.e);

  @override
  Widget build(BuildContext context) {
    String users = '';
    final String countUser = e.assigneeOrCandidates.length > 1 ? ' [${e.assigneeOrCandidates.length}]' : '';
    for (int i = 0; i < e.assigneeOrCandidates.length; i++) {
      if (i != e.assigneeOrCandidates.length - 1) {
        users = '$users${e.assigneeOrCandidates[i].fullName}[${e.assigneeOrCandidates[i].login}], ';
      } else {
        users = '$users${e.assigneeOrCandidates[i].fullName}[${e.assigneeOrCandidates[i].login}]';
      }
    }
    // log('-->> $fName, build -->> ExtTaskData: ${e.toJson()}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: KzmContentShadow(
        hideMargin: true,
        bottomPadding: 6.0,
        child: KzmExpansionTile(
          title: '${e.hrRole?.instanceName ?? ''} $countUser',
          subtitle: users,
          children: <FieldBones>[
            FieldBones(
              placeholder: S.current.user,
              textValue: e.hrRole?.instanceName ?? '',
            ),
            FieldBones(
              placeholder: S.current.createTime,
              textValue: formatFullNotMilSec(e.createTime) ?? '',
            ),
            FieldBones(
              placeholder: S.current.endTime,
              textValue: formatFullNotMilSec(e.endTime) ?? '',
            ),
            FieldBones(
              placeholder: S.current.outcome,
              textValue: getOutcomeNameById(e.outcome),
            ),
            FieldBones(
              placeholder: S.current.comment,
              textValue: e.comment ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
