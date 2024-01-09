import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/courses/learnig_history.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class LearnStory extends StatefulWidget {
  @override
  _LearnStoryState createState() => _LearnStoryState();
}

class _LearnStoryState extends State<LearnStory> {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;
    return Scaffold(
      appBar: KzmAppBar(context: context, showMenu: false),
      body: FutureBuilder<List<LearningHistory>>(
        future: model.learningHistory,
        builder: (BuildContext context, AsyncSnapshot<List<LearningHistory>> snapshot) {
          if (snapshot.data == null) {
            return const LoaderWidget();
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final LearningHistory e = snapshot.data[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(index == 0) pageTitle(
                    title: S.current.trainingHistory,
                    fontSize: 15.w,
                  ),
                  KzmCard(
                    title: e.course,
                    subtitle: e.startDate != null && e.endDate != null ? '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)}' : '',
                    trailing: Text(e.enrollmentStatus),
                    selected: () async {
                      await model.openStory(e);
                    },
                  ),
                ],
              );
            },
            itemCount: snapshot.data.length,
          );
        },
      ),
    );
  }
}
