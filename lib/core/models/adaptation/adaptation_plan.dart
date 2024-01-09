// To parse this JSON data, do
//
//     final adaptationPlan = adaptationPlanFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/assignment.dart';

class AdaptationPlan {
  AdaptationPlan({
    this.entityName,
    this.instanceName,
    this.id,
    this.organizationBin,
    this.planName,
    this.adaptationSetting,
    this.isApprovedPlan,
    this.requestNumber,
    this.integrationUserLogin,
    this.requestDate,
    this.legacyId,
    this.employeePassedProbationPeriod,
    this.tasks,
    this.personGroup,
    this.dateFrom,
    this.dateTo,
    this.employeePassedProbationaryEvents,
    this.comment,
    this.adaptationStatus,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  String organizationBin;
  String planName;
  AdaptationSetting adaptationSetting;
  bool isApprovedPlan;
  int requestNumber;
  String integrationUserLogin;
  DateTime requestDate;
  String legacyId;
  bool employeePassedProbationPeriod;
  List<AdaptationTask> tasks;
  PersonGroup personGroup;
  DateTime dateFrom;
  DateTime dateTo;
  bool employeePassedProbationaryEvents;
  String comment;
  String adaptationStatus;
  AbstractDictionary status;

  factory AdaptationPlan.fromJson(String str) =>
      AdaptationPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdaptationPlan.fromMap(Map<String, dynamic> json) => AdaptationPlan(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        organizationBin: json['organizationBin'],
        planName: json['planName'],
        adaptationSetting: json['adaptationSetting'] == null
            ? null
            : AdaptationSetting.fromMap(json['adaptationSetting']),
        isApprovedPlan:
            json['isApprovedPlan'],
        requestNumber:
            json['requestNumber'],
        integrationUserLogin: json['integrationUserLogin'],
        requestDate: json['requestDate'] == null
            ? null
            : DateTime.parse(json['requestDate']),
        legacyId: json['legacyId'],
        employeePassedProbationPeriod:
            json['employeePassedProbationPeriod'],
        tasks: json['tasks'] == null
            ? null
            : (json['tasks'] as List)
                .map((e) => AdaptationTask.fromMap(e as Map<String, dynamic>))
                .toList(),
        personGroup: json['personGroup'] == null
            ? null
            : PersonGroup.fromMap(json['personGroup']),
        dateFrom:
            json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
        dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
        employeePassedProbationaryEvents:
            json['employeePassedProbationaryEvents'],
        comment: json['comment'],
        adaptationStatus:
            json['adaptationStatus'],
        status: json['status'] == null
            ? null
            : AbstractDictionary.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'organizationBin': organizationBin,
        'planName': planName,
        'adaptationSetting':
            adaptationSetting == null ? null : adaptationSetting.toMap(),
        'isApprovedPlan': isApprovedPlan,
        'requestNumber': requestNumber,
        'integrationUserLogin': integrationUserLogin,
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'legacyId': legacyId,
        'employeePassedProbationPeriod': employeePassedProbationPeriod,
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'dateFrom': dateFrom == null ? null : formatFullRest(dateFrom),
        'dateTo': dateTo == null ? null : formatFullRest(dateTo),
        'employeePassedProbationaryEvents':
            employeePassedProbationaryEvents,
        'comment': comment,
        'adaptationStatus': adaptationStatus,
        'status': status == null ? null : status.toMap(),
      };
}

class AdaptationSetting {
  AdaptationSetting({
    this.entityName,
    this.instanceName,
    this.id,
    this.planNameLang1,
    this.instructionLang3,
    this.instructionLang2,
    this.instructionLang1,
    this.planNameLang2,
    this.planNameLang3,
  });

  String entityName;
  String instanceName;
  String id;
  String planNameLang1;
  String instructionLang3;
  String instructionLang2;
  String instructionLang1;
  String planNameLang2;
  String planNameLang3;

  factory AdaptationSetting.fromMap(Map<String, dynamic> json) =>
      AdaptationSetting(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        planNameLang1:
            json['planNameLang1'],
        instructionLang3:
            json['instructionLang3'],
        instructionLang2:
            json['instructionLang2'],
        instructionLang1:
            json['instructionLang1'],
        planNameLang2:
            json['planNameLang2'],
        planNameLang3:
            json['planNameLang3'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'planNameLang1': planNameLang1,
        'instructionLang3': instructionLang3,
        'instructionLang2': instructionLang2,
        'instructionLang1': instructionLang1,
        'planNameLang2': planNameLang2,
        'planNameLang3': planNameLang3,
      };
}

class AdaptationTask {
  AdaptationTask({
    this.entityName,
    this.instanceName,
    this.id,
    this.expectedResultsLang1,
    this.expectedResultsLang2,
    this.expectedResultsLang3,
    this.assignmentLang1,
    this.assignmentLang2,
    this.achievedResultsLang3,
    this.achievedResultsLang1,
    this.achievedResultsLang2,
    this.assignmentLang3,
  });

  String entityName;
  String instanceName;
  String id;
  String expectedResultsLang1;
  dynamic expectedResultsLang2;
  dynamic expectedResultsLang3;
  String assignmentLang1;
  dynamic assignmentLang2;
  dynamic achievedResultsLang3;
  String achievedResultsLang1;
  dynamic achievedResultsLang2;
  dynamic assignmentLang3;

  factory AdaptationTask.fromJson(String str) =>
      AdaptationTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdaptationTask.fromMap(Map<String, dynamic> json) => AdaptationTask(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        expectedResultsLang1: json['expectedResultsLang1'],
        expectedResultsLang2: json['expectedResultsLang2'],
        expectedResultsLang3: json['expectedResultsLang3'],
        assignmentLang1:
            json['assignmentLang1'],
        assignmentLang2: json['assignmentLang2'],
        achievedResultsLang3: json['achievedResultsLang3'],
        achievedResultsLang1: json['achievedResultsLang1'],
        achievedResultsLang2: json['achievedResultsLang2'],
        assignmentLang3: json['assignmentLang3'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'expectedResultsLang1':
            expectedResultsLang1,
        'expectedResultsLang2': expectedResultsLang2,
        'expectedResultsLang3': expectedResultsLang3,
        'assignmentLang1': assignmentLang1,
        'assignmentLang2': assignmentLang2,
        'achievedResultsLang3': achievedResultsLang3,
        'achievedResultsLang1':
            achievedResultsLang1,
        'achievedResultsLang2': achievedResultsLang2,
        'assignmentLang3': assignmentLang3,
      };
}
