import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/assignment/employee_category.dart';
import 'package:kzm/core/models/organization/organization_group.dart';

import 'package:kzm/core/models/position/job_group.dart';

part 'position_group_element.g.dart';

@HiveType(typeId: 11)
class PositionGroupElement {
  PositionGroupElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.updatedBy,
    this.jobGroup,
    this.maxPersons,
    this.startDate,
    this.organizationGroupExt,
    this.fte,
    this.positionFullNameLang1,
    this.positionFullNameLang2,
    this.positionFullNameLang3,
    this.managerFlag,
    this.positionStatus,
    this.positionNameLang1,
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
  String updatedBy;
  @HiveField(5)
  JobGroup jobGroup;
  @HiveField(6)
  int maxPersons;
  @HiveField(7)
  DateTime startDate;
  @HiveField(8)
  OrganizationGroupExt organizationGroupExt;
  @HiveField(9)
  num fte;
  @HiveField(10)
  String positionFullNameLang1;
  @HiveField(11)
  String positionFullNameLang2;
  @HiveField(12)
  String positionFullNameLang3;
  @HiveField(13)
  bool managerFlag;
  @HiveField(14)
  EmployeeCategory positionStatus;
  @HiveField(15)
  String positionNameLang1;

  factory PositionGroupElement.fromJson(String str) =>
      PositionGroupElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionGroupElement.fromMap(Map<String, dynamic> json) =>
      PositionGroupElement(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        endDate:
            json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        updatedBy: json['updatedBy'],
        jobGroup: json['jobGroup'] == null
            ? null
            : JobGroup.fromMap(json['jobGroup']),
        maxPersons: json['maxPersons'],
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate']),
        organizationGroupExt: json['organizationGroupExt'] == null
            ? null
            : OrganizationGroupExt.fromMap(json['organizationGroupExt']),
        fte: json['fte'],
        positionFullNameLang1: json['positionFullNameLang1'],
        positionFullNameLang2: json['positionFullNameLang2'],
        positionFullNameLang3: json['positionFullNameLang3'],
        managerFlag: json['managerFlag'],
        positionStatus: json['positionStatus'] == null
            ? null
            : EmployeeCategory.fromMap(json['positionStatus']),
        positionNameLang1: json['positionNameLang1'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'updatedBy': updatedBy,
        'jobGroup': jobGroup == null ? null : jobGroup.toMap(),
        'maxPersons': maxPersons,
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'organizationGroupExt':
            organizationGroupExt == null ? null : organizationGroupExt.toMap(),
        'fte': fte,
        'positionFullNameLang1':
            positionFullNameLang1,
        'positionFullNameLang2':
            positionFullNameLang2,
        'positionFullNameLang3':
            positionFullNameLang3,
        'managerFlag': managerFlag,
        'positionStatus':
            positionStatus == null ? null : positionStatus.toMap(),
        'positionNameLang1':
            positionNameLang1,
      };
}
