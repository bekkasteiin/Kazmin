import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course.dart';

class CourseMainInfo extends StatelessWidget {
  final Course course;

  const CourseMainInfo({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<LearningType> preRequisition = course.preRequisition;
    return Card(
      child: Wrap(
        children: [
          ListTile(
            title: const Text('Пререквизиты'),
            subtitle: preRequisition.isNotEmpty
                ? Wrap(
                    children: preRequisition
                        .map((LearningType e) => Text(e.requisitionCourse.instanceName))
                        .toList(),
                  )
                : const SizedBox(),
          ),
          const ListTile(
            title: Text('Продолжительность'),
            subtitle: Text(''),
          ),
          ListTile(
            title: const Text('Тип обучения'),
            subtitle: Text(course?.learningType?.instanceName ?? ''),
          ),
        ],
      ),
    );
  }
}
