import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/models/course_schedule.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/learning/course_schedules/course_schedule_grouped_list.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';


class CourseScheduleView extends StatefulWidget {
  const CourseScheduleView({Key key}) : super(key: key);

  @override
  State<CourseScheduleView> createState() => _CourseScheduleViewState();
}

class _CourseScheduleViewState extends State<CourseScheduleView> {
  final GroupedItemScrollController controller = GroupedItemScrollController();

  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: FutureBuilder<List<CourseSchedule>>(
        future: model.getCourseSchedules(),
        builder: (BuildContext context, AsyncSnapshot<List<CourseSchedule>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return KZMNoData();
            }
            return CourseScheduleGL(
              list: snapshot.data,
              model: model,
            );
          } else {
            return const LoaderWidget();
          }
        },
      ),
    );
  }
}
