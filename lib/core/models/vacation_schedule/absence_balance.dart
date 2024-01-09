// To parse this JSON data, do
//
//     final absenceBalance = absenceBalanceFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/assignment/assignment.dart';

class AbsenceBalance {
  AbsenceBalance({
    this.entityName,
    this.instanceName,
    this.id,
    this.additionalBalanceDays,
    this.longAbsenceDays,
    this.balanceDays,
    this.extraDaysSpent,
    this.personGroup,
    this.dateFrom,
    this.daysSpent,
    this.dateTo,
  });

  String entityName;
  String instanceName;
  String id;
  num additionalBalanceDays;
  num longAbsenceDays;
  num balanceDays;
  num extraDaysSpent;
  PersonGroup personGroup;
  DateTime dateFrom;
  num daysSpent;
  DateTime dateTo;

  factory AbsenceBalance.fromJson(String str) => AbsenceBalance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbsenceBalance.fromMap(Map<String, dynamic> json) => AbsenceBalance(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    additionalBalanceDays: json['additionalBalanceDays'],
    longAbsenceDays: json['longAbsenceDays'],
    balanceDays: json['balanceDays'],
    extraDaysSpent: json['extraDaysSpent'],
    personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
    dateFrom: json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
    daysSpent: json['daysSpent'],
    dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'additionalBalanceDays': additionalBalanceDays,
    'longAbsenceDays': longAbsenceDays,
    'balanceDays': balanceDays,
    'extraDaysSpent': extraDaysSpent,
    'personGroup': personGroup == null ? null : personGroup.toMap(),
    'dateFrom': dateFrom == null ? null : "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
    'daysSpent': daysSpent,
    'dateTo': dateTo == null ? null : "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
  };
}
