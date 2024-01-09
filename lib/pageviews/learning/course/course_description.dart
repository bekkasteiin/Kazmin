import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kzm/core/models/courses/course.dart';

class CourseDescription extends StatefulWidget {
  final Course course;

  const CourseDescription(this.course);

  @override
  _CourseDescriptionState createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    String description = widget?.course?.description;
    description ??= '';
    return GestureDetector(
      onTap: () {
        setState(() {
          isFull = !isFull;
        });
      },
      child: Card(
        child: Html(
            data: isFull
                ? description
                : ('${description.substring(0, description.length ~/ 12)}...'),),
      ),
    );
  }
}
