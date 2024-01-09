import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/course_schedule.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class CourseScheduleItem extends StatelessWidget {
  final CourseSchedule element;
  final LearningModel model;

  const CourseScheduleItem({@required this.element, @required this.model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KzmCard(
      selected: () => model.openCourseSchedule(element),
      title: element.nameLang1 ?? '',
      subtitle: '${formatShortly(element.startDate)} - ${formatShortly(element.endDate)}',
      trailing: Text(
        element.status != null ? element.statusRu : '${element.placesLeft <= 0 ? "нет" : element.placesLeft} мест',
      ),
    );
  }
}
