// To parse this JSON data, do
//
//     final learningHistory = learningHistoryFromMap(jsonString);

import 'dart:convert';

class LearningHistory {
  LearningHistory({
    this.startDate,
    this.endDate,
    this.course,
    this.courseId,
    this.trainer,
    this.result,
    this.certificate,
    this.enrollmentStatus,
    this.enrollmentId,
    this.note,
  });

  DateTime startDate;
  DateTime endDate;
  String course;
  String courseId;
  String trainer;
  double result;
  String certificate;
  String enrollmentStatus;
  String enrollmentId;
  dynamic note;

  factory LearningHistory.fromJson(String str) =>
      LearningHistory.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory LearningHistory.fromMap(Map<String, dynamic> json) => LearningHistory(
        startDate: json['startDate'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['startDate']),
        endDate: json['endDate'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['endDate']),
        course: json['course'] as String,
        courseId: json['courseId'] as String,
        trainer: json['trainer'] as String,
        result: json['result'] as double,
        certificate: json['certificate'] as String,
        enrollmentStatus: json['enrollmentStatus'] as String,
        enrollmentId: json['enrollmentId'] as String,
        note: json['note'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'startDate': startDate,
        'endDate': endDate,
        'course': course,
        'courseId': courseId,
        'trainer': trainer,
        'result': result,
        'certificate': certificate,
        'enrollmentStatus': enrollmentStatus,
        'enrollmentId': enrollmentId,
        'note': note,
      };
}
