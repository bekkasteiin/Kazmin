import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/courses/course.dart';

class CourseSchedule extends StatelessWidget {
  final Course course;

  const CourseSchedule({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        children: course.courseSchedule
            .map(
              (CourseScheduleElement e) => ListTile(
                title: Text(e.name ?? ''),
                subtitle: Text(
                  '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)}',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(e?.learningCenter?.instanceName ?? ''),
                    Text(
                      e.address ?? '',
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
