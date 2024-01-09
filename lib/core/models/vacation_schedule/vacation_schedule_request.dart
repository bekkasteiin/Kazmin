// To parse this JSON data, do
//
//     final vacationScheduleRequest = vacationScheduleRequestFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/assignment/assignment.dart';

class VacationScheduleRequest extends AbstractBpmRequest {
  @override
  String get getEntityName => EntityNames.vacationScheduleRequest;

  @override
  VacationScheduleRequest getFromJson(String string) => VacationScheduleRequest.fromJson(string);

  @override
  String get getProcessDefinitionKey => 'vacationScheduleRequest';

  @override
  String get getView => '_local';

  VacationScheduleRequest(
      {this.entityName,
      this.instanceName,
      this.id,
      this.sentToOracle,
      this.personGroup,
      this.endDate,
      this.version,
      this.requestNumber,
      this.absenceDays,
      this.requestDate,
      this.startDate,
      this.comment,
      this.attachment,
      this.balance,
      this.approved,
      this.revision,
      this.commentManager,
      this.assignmentSchedule,
      });

  String entityName;
  String instanceName;
  @override
  String id;
  String sentToOracle;
  PersonGroup personGroup;
  DateTime endDate;
  int version;
  int requestNumber;
  int absenceDays;
  int balance;
  DateTime requestDate;
  DateTime startDate;
  String comment;
  String commentManager;
  FileDescriptor attachment;
  bool approved;
  bool revision;
  AssignmentScheduleModels assignmentSchedule;

  factory VacationScheduleRequest.fromJson(String str) => VacationScheduleRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VacationScheduleRequest.fromMap(Map<String, dynamic> json) => VacationScheduleRequest(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        commentManager: json['commentManager'],
        sentToOracle: json['sentToOracle'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        assignmentSchedule: json['assignmentSchedule'] == null ? null : AssignmentScheduleModels.fromMap(json['assignmentSchedule']),
        attachment: json['attachment'] == null ? null : FileDescriptor.fromMap(json['attachment']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        version: json['version'],
        requestNumber: json['requestNumber'],
        absenceDays: json['absenceDays'],
        balance: json['balance'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        comment: json['comment'],
        approved: json['approved'],
        revision: json['revision'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'commentManager': commentManager ?? '',
        'sentToOracle': sentToOracle,
        'personGroup': personGroup == null ? null : personGroup.toMapId(),
        'attachment': attachment == null ? null : attachment.toMap(),
        'assignmentSchedule': assignmentSchedule == null ? null : assignmentSchedule.toMap(),
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'version': version,
        'requestNumber': requestNumber,
        'absenceDays': absenceDays,
        'comment': comment,
        'balance': balance,
        'approved': approved,
        'revision': revision,
        'requestDate': requestDate == null
            ? null
            : "${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}",
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      }
        ..removeWhere((String key, dynamic value) => value == null);

  Map<String, dynamic> toMapId() => {
        'id': id,
      };
}


class AssignmentScheduleModels{
  String entityName;
  String instanceName;
  String id;
  PurpleSchedule schedule;

  AssignmentScheduleModels({
    this.entityName,
    this.instanceName,
    this.id,
    this.schedule,
  });


  factory AssignmentScheduleModels.fromMap(Map<String, dynamic> json) => AssignmentScheduleModels(
    entityName: json["_entityName"],
    instanceName: json["_instanceName"],
    id: json["id"],
    schedule: PurpleSchedule.fromMap(json["schedule"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName,
    "_instanceName": instanceName,
    "id": id,
    "schedule": schedule.toMap(),
  };
}

class PurpleSchedule {
  String entityName;
  String instanceName;
  String id;
  String scheduleName;
  String legacyId;

  PurpleSchedule({
    this.entityName,
    this.instanceName,
    this.id,
    this.scheduleName,
    this.legacyId,
  });

  factory PurpleSchedule.fromMap(Map<String, dynamic> json) => PurpleSchedule(
    entityName: json["_entityName"],
    instanceName: json["_instanceName"],
    id: json["id"],
    scheduleName: json["scheduleName"],
    legacyId: json["legacyId"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName,
    "_instanceName": instanceName,
    "id": id,
    "scheduleName": scheduleName,
    "legacyId": legacyId,
  };
}
