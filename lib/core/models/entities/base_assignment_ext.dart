/*
"_entityName": "base$AssignmentExt"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/base_assignment_group_ext.dart';
import 'package:kzm/core/models/entities/base_organization_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_assignment_status.dart';
import 'package:kzm/core/models/entities/tsadv_job_group.dart';

class BaseAssignmentExt {
  String entityName;
  String instanceName;
  TsadvDicAssignmentStatus assignmentStatus;
  BaseAssignmentGroupExt group;
  TsadvJobGroup jobGroup;
  BaseOrganizationGroupExt organizationGroup;
  String endDate;
  String id;
  bool primaryFlag;
  String startDate;

  BaseAssignmentExt({
    this.entityName,
    this.instanceName,
    this.assignmentStatus,
    this.endDate,
    this.group,
    this.id,
    this.jobGroup,
    this.organizationGroup,
    this.primaryFlag,
    this.startDate,
  });

  factory BaseAssignmentExt.fromJson(String str) {
    return BaseAssignmentExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BaseAssignmentExt.fromMap(Map<String, dynamic> json) {
    return BaseAssignmentExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
      primaryFlag: json['primaryFlag'] == null ? null : json['primaryFlag'] as bool,
      group: json['group'] == null ? null : BaseAssignmentGroupExt.fromMap(json['group'] as Map<String, dynamic>),
      jobGroup: json['jobGroup'] == null ? null : TsadvJobGroup.fromMap(json['jobGroup'] as Map<String, dynamic>),
      assignmentStatus: json['assignmentStatus'] == null
          ? null
          : TsadvDicAssignmentStatus.fromMap(json['assignmentStatus'] as Map<String, dynamic>),
      organizationGroup: json['organizationGroup'] == null
          ? null
          : BaseOrganizationGroupExt.fromMap(json['organizationGroup'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'endDate': endDate,
      'id': id,
      'primaryFlag': primaryFlag,
      'startDate': startDate,
      'assignmentStatus': assignmentStatus?.toMap(),
      'group': group?.toMap(),
      'jobGroup': jobGroup?.toMap(),
      'organizationGroup': organizationGroup?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
