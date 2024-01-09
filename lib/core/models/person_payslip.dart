// To parse this JSON data, do
//
//     final personPayslip = personPayslipFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/abstract/FileDescriptor.dart';

import 'package:kzm/core/models/assignment/assignment.dart';

class PersonPayslip {
  PersonPayslip({
    this.entityName,
    this.instanceName,
    this.id,
    this.period,
    this.personGroup,
    this.file,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime period;
  PersonGroup personGroup;
  FileDescriptor file;

  factory PersonPayslip.fromJson(String str) => PersonPayslip.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonPayslip.fromMap(Map<String, dynamic> json) => PersonPayslip(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    period: json['period'] == null ? null : DateTime.parse(json['period']),
    personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
    file: json['file'] == null ? null : FileDescriptor.fromMap(json['file']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'period': period == null ? null : "${period.year.toString().padLeft(4, '0')}-${period.month.toString().padLeft(2, '0')}-${period.day.toString().padLeft(2, '0')}",
    'personGroup': personGroup == null ? null : personGroup.toMap(),
    'file': file == null ? null : file.toMap(),
  };
}
