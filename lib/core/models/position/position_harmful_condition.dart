// To parse this JSON data, do
//
//     final positionHarmfulCondition = positionHarmfulConditionFromMap(jsonString);

import 'dart:convert';

class PositionHarmfulCondition {
  PositionHarmfulCondition({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.version,
    this.legacyId,
    this.days,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  int version;
  String legacyId;
  int days;
  DateTime startDate;

  factory PositionHarmfulCondition.fromJson(String str) => PositionHarmfulCondition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionHarmfulCondition.fromMap(Map<String, dynamic> json) => PositionHarmfulCondition(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
    version: json['version'],
    legacyId: json['legacyId'],
    days: json['days'],
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'version': version,
    'legacyId': legacyId,
    'days': days,
    'startDate': startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}
