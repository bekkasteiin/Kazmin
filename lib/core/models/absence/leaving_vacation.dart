import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/assignment.dart';

class LeavingVacationRequest extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'leavingVacationRequest';

  @override
  String get getView => '';

  @override
  String getEntityName = EntityNames.leavingVacationRequest;

  @override
  LeavingVacationRequest getFromJson(String string) => LeavingVacationRequest.fromJson(string);

  LeavingVacationRequest(
      {this.entityName,
      this.instanceName,
      this.id,
      this.dateTo,
      this.endDate,
      this.requestNumber,
      this.comment,
      this.attachment,
      this.plannedStartDate,
      this.requestDate,
      this.vacation,
      this.dateFrom,
      this.startDate,
      this.personGroup,
      this.status,
      this.absenceDays,});

  String entityName;
  String instanceName;
  @override
  String id;
  DateTime dateTo;
  DateTime endDate;
  int requestNumber;
  String comment;
  PersonGroup personGroup;
  FileDescriptor attachment;
  DateTime plannedStartDate;
  DateTime requestDate;
  AbsenceRequest vacation;
  DateTime dateFrom;
  DateTime startDate;
  int absenceDays;
  @override
  AbstractDictionary status;

  factory LeavingVacationRequest.fromJson(String str) => LeavingVacationRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LeavingVacationRequest.fromMap(Map<String, dynamic> json) => LeavingVacationRequest(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        absenceDays: json['absenceDays'],
        id: json['id'] ?? '',
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        requestNumber: json['requestNumber'],
        comment: json['comment'],
        attachment: json['attachment'] == null ? null : FileDescriptor.fromMap(json['attachment']),
        plannedStartDate: json['plannedStartDate'] == null ? null : DateTime.parse(json['plannedStartDate']),
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        vacation: json['vacation'] == null ? null : AbsenceRequest.fromMap(json['vacation']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'endDate': endDate == null ? null : formatFullRest(endDate),
        'requestNumber': requestNumber,
        'absenceDays': absenceDays,
        'comment': comment,
        'attachment': attachment == null ? null : attachment.toMap(),
        'plannedStartDate': plannedStartDate == null ? null : formatFullRest(plannedStartDate),
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'vacation': vacation == null ? null : vacation.toMap(),
        'startDate': startDate == null ? null : formatFullRest(startDate),
        'status': status == null ? null : status.toMap(),
        'personGroup': personGroup == null ? null : personGroup.toMapId(),
      }
        ..removeWhere((String key, dynamic value) => value == null);
}
