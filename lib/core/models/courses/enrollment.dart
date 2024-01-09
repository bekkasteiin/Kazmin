// To parse this JSON data, do
//
//     final enrollment = enrollmentFromMap(jsonString);

import 'dart:convert';
import 'package:kzm/core/models/abstract/group_element.dart';

import 'package:kzm/core/models/courses/course.dart';


class Enrollment {
  Enrollment({
    this.entityName,
    this.instanceName,
    this.id,
    this.date,
    this.personGroup,
    this.version,
    this.createdBy,
    this.course,
    this.createTs,
    this.updateTs,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime date;
  CourseTrainer personGroup;
  int version;
  String createdBy;
  GroupElement course;
  DateTime createTs;
  DateTime updateTs;
  String status;
  EnrollmentCourseSchedule courseSchedule;

  factory Enrollment.fromJson(String str) =>
      Enrollment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Enrollment.fromMap(Map<String, dynamic> json) =>
      Enrollment(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        personGroup: json['personGroup'] == null
            ? null
            : CourseTrainer.fromMap(json['personGroup']),
        version: json['version'],
        createdBy: json['createdBy'],
        course: json['course'] == null
            ? null
            : GroupElement.fromMap(json['course']),
        createTs:
            json['createTs'] == null ? null : DateTime.parse(json['createTs']),
        updateTs:
            json['updateTs'] == null ? null : DateTime.parse(json['updateTs']),
        status: json['status'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'date': date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'version': version,
        'createdBy': createdBy,
        'course': course == null ? null : course.toMap(),
        'createTs': createTs == null ? null : createTs.toIso8601String(),
        'updateTs': updateTs == null ? null : updateTs.toIso8601String(),
        'status': status,
      };
}
