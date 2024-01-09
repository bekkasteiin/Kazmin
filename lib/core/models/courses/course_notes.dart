// To parse this JSON data, do
//
//     final courseNote = courseNoteFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/courses/course.dart';

class CourseNote {
  CourseNote({
    this.entityName,
    this.instanceName,
    this.id,
    this.note,
    this.personGroup,
    this.course,
    this.version,
  });

  String entityName;
  String instanceName;
  String id;
  String note;
  PersonGroup personGroup;
  Course course;
  int version;

  factory CourseNote.fromJson(String str) => CourseNote.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseNote.fromMap(Map<String, dynamic> json) => CourseNote(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    note: json['note'],
    personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
    course: json['course'] == null ? null : Course.fromMap(json['course']),
    version: json['version'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'note': note,
    'personGroup': personGroup == null ? null : personGroup.toMap(),
    'course': course == null ? null : course.toMap(),
    'version': version,
  };
}



