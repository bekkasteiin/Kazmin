import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/position/job_group.dart';
import 'package:kzm/core/models/position/position_group.dart';

part 'assignment_element.g.dart';
@HiveType(typeId: 4)
class AssignmentElement {
  AssignmentElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.primaryFlag,
    this.fte,
    this.organizationGroup,
    this.personGroup,
    this.jobGroup,
    this.positionGroup,
    this.startDate,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  bool primaryFlag;
  @HiveField(5)
  num fte;
  @HiveField(6)
  GroupElement organizationGroup;
  @HiveField(7)
  GroupElement personGroup;
  @HiveField(8)
  JobGroup jobGroup;
  @HiveField(9)
  PositionGroup positionGroup;
  @HiveField(10)
  DateTime startDate;

  factory AssignmentElement.fromJson(String str) =>
      AssignmentElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignmentElement.fromMap(Map<String, dynamic> json) =>
      AssignmentElement(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        endDate:
            json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        primaryFlag: json['primaryFlag'],
        fte: json['fte'],
        organizationGroup: json['organizationGroup'] == null
            ? null
            : GroupElement.fromMap(json['organizationGroup']),
        personGroup: json['personGroup'] == null
            ? null
            : GroupElement.fromMap(json['personGroup']),
        jobGroup: json['jobGroup'] == null
            ? null
            : JobGroup.fromMap(json['jobGroup']),
        positionGroup: json['positionGroup'] == null
            ? null
            : PositionGroup.fromMap(json['positionGroup']),
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'primaryFlag': primaryFlag,
        'fte': fte,
        'organizationGroup':
            organizationGroup == null ? null : organizationGroup.toMap(),
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'jobGroup': jobGroup == null ? null : jobGroup.toMap(),
        'positionGroup': positionGroup == null ? null : positionGroup.toMap(),
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}
