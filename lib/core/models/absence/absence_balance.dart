// To parse this JSON data, do
//
//     final absenceBalance = absenceBalanceFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';

List<AbsenceVacationBalance> absenceBalanceFromMap(String str) => List<AbsenceVacationBalance>.from(json.decode(str).map((x) => AbsenceVacationBalance.fromMap(x)));

String absenceBalanceToMap(List<AbsenceVacationBalance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AbsenceVacationBalance extends AbstractBpmRequest{
  AbsenceVacationBalance({
    this.entityName,
    this.instanceName,
    this.id,
    this.additionalBalanceDays,
    this.ecologicalDaysLeft,
    this.balanceDays,
    this.extraDaysLeft,
    this.legacyId,
    this.daysLeft,
    this.overallBalanceDays,
    this.dateFrom,
    this.disabilityDaysLeft,
    this.dateTo,
    this.disabilityDueDays,
    this.ecologicalDueDays,
  });

  String entityName;
  String instanceName;
  String id;
  double additionalBalanceDays;
  double ecologicalDaysLeft;
  double balanceDays;
  double extraDaysLeft;
  String legacyId;
  double daysLeft;
  double overallBalanceDays;
  DateTime dateFrom;
  double disabilityDaysLeft;
  DateTime dateTo;
  double disabilityDueDays;
  double ecologicalDueDays;

  factory AbsenceVacationBalance.fromMap(Map<String, dynamic> json) => AbsenceVacationBalance(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    additionalBalanceDays: json["additionalBalanceDays"] == null ? null : json["additionalBalanceDays"],
    ecologicalDaysLeft: json["ecologicalDaysLeft"] == null ? null : json["ecologicalDaysLeft"],
    balanceDays: json["balanceDays"] == null ? null : json["balanceDays"],
    extraDaysLeft: json["extraDaysLeft"] == null ? null : json["extraDaysLeft"],
    legacyId: json["legacyId"] == null ? null : json["legacyId"],
    daysLeft: json["daysLeft"] == null ? null : json["daysLeft"].toDouble(),
    overallBalanceDays: json["overallBalanceDays"] == null ? null : json["overallBalanceDays"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    disabilityDaysLeft: json["disabilityDaysLeft"] == null ? null : json["disabilityDaysLeft"],
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
    disabilityDueDays: json["disabilityDueDays"] == null ? null : json["disabilityDueDays"],
    ecologicalDueDays: json["ecologicalDueDays"] == null ? null : json["ecologicalDueDays"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "additionalBalanceDays": additionalBalanceDays == null ? null : additionalBalanceDays,
    "ecologicalDaysLeft": ecologicalDaysLeft == null ? null : ecologicalDaysLeft,
    "balanceDays": balanceDays == null ? null : balanceDays,
    "extraDaysLeft": extraDaysLeft == null ? null : extraDaysLeft,
    "legacyId": legacyId == null ? null : legacyId,
    "daysLeft": daysLeft == null ? null : daysLeft,
    "overallBalanceDays": overallBalanceDays == null ? null : overallBalanceDays,
    "dateFrom": dateFrom == null ? null : "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
    "disabilityDaysLeft": disabilityDaysLeft == null ? null : disabilityDaysLeft,
    "dateTo": dateTo == null ? null : "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
    "disabilityDueDays": disabilityDueDays == null ? null : disabilityDueDays,
    "ecologicalDueDays": ecologicalDueDays == null ? null : ecologicalDueDays,
  };

  @override
  String get getProcessDefinitionKey => 'absenceForRecallRequest';

  @override
  // TODO: implement view
  String get getView => '_local';

  @override
  String get getEntityName => 'tsadv_AbsenceBalanceService';

  @override
  AbsenceVacationBalance getFromJson(var string) => AbsenceVacationBalance.fromJson(string);

  factory AbsenceVacationBalance.fromJson(String str) => AbsenceVacationBalance.fromMap(json.decode(str));
}
