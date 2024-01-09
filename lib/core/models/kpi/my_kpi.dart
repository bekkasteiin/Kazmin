import 'dart:convert';

import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/assignment.dart';

class AssignedPerformancePlan {
  AssignedPerformancePlan(
      {this.entityName,
      this.instanceName,
      this.id,
      this.assignedPerson,
      this.requestNumber,
      this.stepStageStatus,
      this.performancePlan,
      this.status,
      this.endDate,
      this.startDate,});

  String entityName;
  String instanceName;
  String id;
  PersonGroup assignedPerson;
  int requestNumber;
  String stepStageStatus;
  PerformancePlan performancePlan;
  AbstractDictionary status;
  DateTime endDate;
  DateTime startDate;

  factory AssignedPerformancePlan.fromJson(String str) => AssignedPerformancePlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignedPerformancePlan.fromMap(Map<String, dynamic> json) => AssignedPerformancePlan(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        assignedPerson: json['assignedPerson'] == null ? null : PersonGroup.fromMap(json['assignedPerson']),
        requestNumber: json['requestNumber'],
        stepStageStatus: json['stepStageStatus'],
        performancePlan: json['performancePlan'] == null ? null : PerformancePlan.fromMap(json['performancePlan']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'assignedPerson': assignedPerson == null ? null : assignedPerson.toMap(),
        'requestNumber': requestNumber,
        'stepStageStatus': stepStageStatus,
        'performancePlan': performancePlan == null ? null : performancePlan.toMap(),
        'status': status == null ? null : status.toMap(),
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class PerformancePlan {
  PerformancePlan({
    this.entityName,
    this.instanceName,
    this.id,
    this.performancePlanName,
    this.endDate,
    this.performancePlanNameEn,
    this.performancePlanNameKz,
    this.accessibilityStartDate,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  String performancePlanName;
  DateTime endDate;
  String performancePlanNameEn;
  PersonGroup assignedPerson;
  String performancePlanNameKz;
  DateTime accessibilityStartDate;
  DateTime startDate;

  factory PerformancePlan.fromJson(String str) => PerformancePlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PerformancePlan.fromMap(Map<String, dynamic> json) => PerformancePlan(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        performancePlanName: json['performancePlanName'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        performancePlanNameEn: json['performancePlanNameEn'],
        performancePlanNameKz: json['performancePlanNameKz'],
        accessibilityStartDate: json['accessibilityStartDate'] == null ? null : DateTime.parse(json['accessibilityStartDate']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'performancePlanName': performancePlanName,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'performancePlanNameEn': performancePlanNameEn,
        'performancePlanNameKz': performancePlanNameKz,
        'accessibilityStartDate': accessibilityStartDate == null
            ? null
            : "${accessibilityStartDate.year.toString().padLeft(4, '0')}-${accessibilityStartDate.month.toString().padLeft(2, '0')}-${accessibilityStartDate.day.toString().padLeft(2, '0')}",
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}
