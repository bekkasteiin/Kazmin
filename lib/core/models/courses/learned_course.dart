// To parse this JSON data, do
//
//     final learnedCourse = learnedCourseFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/course_schedule.dart';
import 'package:kzm/core/models/courses/course.dart';

class LearnedCourse {
  LearnedCourse({
    this.entityName,
    this.instanceName,
    this.id,
    this.date,
    this.courseSchedule,
    this.certificateFiles,
    this.course,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime date;
  CourseSchedule courseSchedule;
  List<CertificateFileElement> certificateFiles;
  Course course;
  String status;

  factory LearnedCourse.fromJson(String str) => LearnedCourse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LearnedCourse.fromMap(Map<String, dynamic> json) => LearnedCourse(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    date: json['date'] == null ? null : DateTime.parse(json['date']),
    courseSchedule: json['courseSchedule'] == null ? null : CourseSchedule.fromMap(json['courseSchedule']),
    certificateFiles: json['certificateFiles'] == null ? null : List<CertificateFileElement>.from(json['certificateFiles'].map((x) => CertificateFileElement.fromMap(x))),
    course: json['course'] == null ? null : Course.fromMap(json['course']),
    status: json['status'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'date': date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    'courseSchedule': courseSchedule == null ? null : courseSchedule.toMap(),
    'certificateFiles': certificateFiles == null ? null : List<dynamic>.from(certificateFiles.map((CertificateFileElement x) => x.toMap())),
    'course': course == null ? null : course.toMap(),
    'status': status,
  };
}

class CertificateFileElement {
  CertificateFileElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.certificateFile,
  });

  String entityName;
  String instanceName;
  String id;
  CertificateFileCertificateFile certificateFile;

  factory CertificateFileElement.fromJson(String str) => CertificateFileElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CertificateFileElement.fromMap(Map<String, dynamic> json) => CertificateFileElement(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    certificateFile: json['certificateFile'] == null ? null : CertificateFileCertificateFile.fromMap(json['certificateFile']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'certificateFile': certificateFile == null ? null : certificateFile.toMap(),
  };
}

class CertificateFileCertificateFile {
  CertificateFileCertificateFile({
    this.entityName,
    this.instanceName,
    this.id,
    this.extension,
    this.name,
    this.createDate,
  });

  String entityName;
  String instanceName;
  String id;
  String extension;
  String name;
  DateTime createDate;

  factory CertificateFileCertificateFile.fromJson(String str) => CertificateFileCertificateFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CertificateFileCertificateFile.fromMap(Map<String, dynamic> json) => CertificateFileCertificateFile(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    extension: json['extension'],
    name: json['name'],
    createDate: json['createDate'] == null ? null : DateTime.parse(json['createDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'extension': extension,
    'name': name,
    'createDate': createDate == null ? null : createDate.toIso8601String(),
  };
}
