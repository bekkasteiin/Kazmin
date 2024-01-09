import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course.dart';

class CourseTrainers extends StatelessWidget {
  final Course course;

  const CourseTrainers({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Тренера'),
        subtitle: Wrap(
          children: course.courseTrainers
              .map((CourseTrainer e) => ListTile(title: Text(e?.trainer?.instanceName ?? '',), contentPadding: const EdgeInsets.only(left: 0),))
              .toList(),
        ),
      ),
    );
  }
}
