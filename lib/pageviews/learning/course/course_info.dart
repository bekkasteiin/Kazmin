import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/learning/course/course_continue_enroll_button.dart';
import 'package:kzm/pageviews/learning/course/course_description.dart';
import 'package:kzm/pageviews/learning/course/course_main_info.dart';
import 'package:kzm/pageviews/learning/course/course_reviews.dart';
import 'package:kzm/pageviews/learning/course/course_schedule.dart';
import 'package:kzm/pageviews/learning/course/course_trainers.dart';
import 'package:kzm/pageviews/learning/course/leave_course_review.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CourseInfo extends StatefulWidget {
  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    final EdgeInsets insets = EdgeInsets.symmetric(horizontal: 8.w);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: insets,
              child: Text(
                model.selectedCourse.instanceName,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            FutureProvider<bool>(
              create: (_) => model.getCourse(model.selectedCourse.id),
              initialData: null,
              child: Consumer<bool>(
                builder: (BuildContext context, bool data, _) {
                  return data == null
                      ? const LoaderWidget()
                      : Column(
                          children: <Widget>[
                            CourseMainInfo(course: model.selectedCourse),
                            CourseTrainers(course: model.selectedCourse),
                            CourseDescription(model.selectedCourse),
                            CourseSchedule(course: model.selectedCourse),
                            CourseReviews(course: model.selectedCourse),
                            LeaveCourseReview(course: model.selectedCourse),
                            CourseContinueEnrollButton()
                          ],
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
