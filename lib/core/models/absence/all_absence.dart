// To parse this JSON data, do
//
//     final allAbsenceRequest = allAbsenceRequestFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

class AllAbsenceRequest {
  AllAbsenceRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.personGroup,
    this.endDate,
    this.type,
    this.requestNumber,
    this.absenceDays,
    this.allAbsenceRequestEntityName,
    this.requestDate,
    this.startDate,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  PersonGroup personGroup;
  DateTime endDate;
  AbstractDictionary type;
  int requestNumber;
  int absenceDays;
  String allAbsenceRequestEntityName;
  DateTime requestDate;
  DateTime startDate;
  AbstractDictionary status;

  factory AllAbsenceRequest.fromJson(String str) => AllAbsenceRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllAbsenceRequest.fromMap(Map<String, dynamic> json) => AllAbsenceRequest(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        type: json['type'] == null ? null : AbstractDictionary.fromMap(json['type']),
        requestNumber: json['requestNumber'],
        absenceDays: json['absenceDays'],
        allAbsenceRequestEntityName: json['entityName'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'endDate': endDate == null ? null : formatFullRest(endDate),
        'type': type == null ? null : type.toMap(),
        'requestNumber': requestNumber,
        'absenceDays': absenceDays,
        'entityName': allAbsenceRequestEntityName,
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'startDate': startDate == null ? null : formatFullRest(startDate),
        'status': status == null ? null : status.toMap(),
      };
}
