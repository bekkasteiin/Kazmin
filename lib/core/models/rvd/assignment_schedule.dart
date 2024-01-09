import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';

class AssignmentSchedule {
  AssignmentSchedule({
    this.entityName,
    this.instanceName,
    this.id,
    this.offset,
    this.endDate,
    this.schedule,
    this.colorsSet,
    this.assignmentGroup,
    this.startDate,
    this.endPolicyCode,
  });

  String entityName;
  String instanceName;
  String id;
  OffsetSchedule offset;
  DateTime endDate;
  CurrentSchedule schedule;
  String colorsSet;
  String endPolicyCode;
  PersonGroup assignmentGroup;
  DateTime startDate;

  factory AssignmentSchedule.fromJson(String str) => AssignmentSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignmentSchedule.fromMap(Map<String, dynamic> json) => AssignmentSchedule(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        offset: json['offset'] == null ? null : OffsetSchedule.fromMap(json['offset']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        schedule: json['schedule'] == null ? null : CurrentSchedule.fromMap(json['schedule']),
        colorsSet: json['colorsSet'],
        endPolicyCode: json['endPolicyCode'],
        assignmentGroup: json['assignmentGroup'] == null ? null : PersonGroup.fromMap(json['assignmentGroup']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'offset': offset == null ? null : offset.toMap(),
        'endDate': endDate == null ? null : formatFullRest(endDate),
        'schedule': schedule == null ? null : schedule.toMap(),
        'colorsSet': colorsSet,
        'endPolicyCode': endPolicyCode,
        'assignmentGroup': assignmentGroup == null ? null : assignmentGroup.toMapId(),
        'startDate': startDate == null ? null : formatFullRest(startDate),
      };
}

class OffsetSchedule {
  OffsetSchedule({
    this.entityName,
    this.instanceName,
    this.id,
    this.standardSchedule,
    this.offsetDisplayDays,
    this.offsetDisplay,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  CurrentSchedule standardSchedule;
  int offsetDisplayDays;
  String offsetDisplay;
  DateTime startDate;

  factory OffsetSchedule.fromMap(Map<String, dynamic> json) => OffsetSchedule(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        standardSchedule: json['standardSchedule'] == null ? null : CurrentSchedule.fromMap(json['standardSchedule']),
        offsetDisplayDays: json['offsetDisplayDays'],
        offsetDisplay: json['offsetDisplay'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'standardSchedule': standardSchedule == null ? null : standardSchedule.toMap(),
        'offsetDisplayDays': offsetDisplayDays,
        'offsetDisplay': offsetDisplay,
        'startDate': startDate == null ? null : formatFullRest(startDate),
      };
}
