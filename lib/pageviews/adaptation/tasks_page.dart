import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';

import 'package:kzm/generated/l10n.dart';

class AdaptationTaskView extends StatelessWidget {
  bool shouldShowAchievements;
  AdaptationTask currentTask;

  AdaptationTaskView({Key key, @required this.currentTask, this.shouldShowAchievements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(context: context, centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pageTitle(title: S.current.newEmployeesTaskCard),
          buildInstance(S.current.task1, currentTask.assignmentLang1),
          buildInstance(
            S.current.newEmployeesExpectedResults,
            currentTask.expectedResultsLang1,
          ),
          if (shouldShowAchievements)
            buildInstance(
              S.current.newEmployeesResultsAchieved,
              currentTask.achievedResultsLang1,
            )
          else
            const SizedBox()
        ],
      ),
    );
  }

  Container buildInstance(String label, String text) {
    return Container(
      margin: EdgeInsets.only(top: 16.w, left: 16.w, bottom: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Styles.mainTS,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
