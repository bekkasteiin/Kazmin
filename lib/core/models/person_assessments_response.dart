// To parse this JSON data, do
//
//     final personAssessmentsResponse = personAssessmentsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/person_assessment_form.dart';

class PersonAssessmentsResponse {
  PersonAssessmentsResponse({
    this.type,
    this.value,
  });

  String type;
  String value;

  factory PersonAssessmentsResponse.fromJson(String str) => PersonAssessmentsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonAssessmentsResponse.fromMap(Map<String, dynamic> json) => PersonAssessmentsResponse(
    type: json['type'],
    value: json['value'],
  );

  Map<String, dynamic> toMap() => {
    'type': type,
    'value': value,
  };
}

class PersonAssessments {
  PersonAssessments({
    this.personAssessmentId,
    this.personGroupId,
    this.dateFrom,
    this.dateTo,
    this.statusCode,
    this.sessionName,
    this.employeeFullName,
    this.participantPersonGroupId,
    this.participantTypeCode,
    this.totalResult,
    this.competenses,
    this.instruction,
    this.participantStatusCode,
  });

  String personAssessmentId;
  String personGroupId;
  DateTime dateFrom;
  DateTime dateTo;
  String statusCode;
  String sessionName;
  String employeeFullName;
  String participantPersonGroupId;
  String participantTypeCode;
  String participantStatusCode;
  double totalResult;
  String instruction;
  List<PersonAssessmentForm> competenses;

  factory PersonAssessments.fromJson(String str) => PersonAssessments.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonAssessments.fromMap(Map<String, dynamic> json) => PersonAssessments(
    personAssessmentId: json['person_assessment_id'] as String,
    //part1 EMPLOYEE
    //part2 MANAGER
    //entity_name Assesment болса не доступно для редактирования
    //

    personGroupId: json['person_group_id'] as String,
    participantStatusCode: json['participant_status_code'] as String,
    instruction: json['instruction'] as String,
    dateFrom: json['date_from'] != null ? DateTime.parse(json['date_from'] as String): null,
    dateTo: json['date_to'] != null ? DateTime.parse(json['date_to'] as String): null,
    statusCode: json['status_code'] as String,
    sessionName: json['session_name'] as String,
    employeeFullName: json['employeeFullName'] as String,
    participantPersonGroupId: json['participant_person_group_id'] as String,
    participantTypeCode: json['participant_type_code'] as String,
    totalResult: json['total_result'] as double,
  );

  Map<String, dynamic> toMap() => {
    'person_assessment_id': personAssessmentId,
    'instruction': instruction,
    'person_group_id': personGroupId,
    'date_from': "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
    'date_to': "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
    'status_code': statusCode,
    'session_name': sessionName,
    'employeeFullName': employeeFullName,
    'participant_person_group_id': participantPersonGroupId,
    'participant_type_code': participantTypeCode,
    'total_result': totalResult,
  };
}
