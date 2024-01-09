// To parse this JSON data, do
//
//     final contractAssistance = contractAssistanceFromMap(jsonString);

import 'dart:convert';

List<ContractAssistance> contractAssistanceFromMap(String str) => List<ContractAssistance>.from(json.decode(str).map((x) => ContractAssistance.fromMap(x)));

String contractAssistanceToMap(List<ContractAssistance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ContractAssistance {
  ContractAssistance({
    this.entityName,
    this.instanceName,
    this.id,
    this.assistance,
    this.version,
  });

  String entityName;
  String instanceName;
  String id;
  Assistance assistance;
  int version;

  factory ContractAssistance.fromMap(Map<String, dynamic> json) => ContractAssistance(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    assistance: json["assistance"] == null ? null : Assistance.fromMap(json["assistance"]),
    version: json["version"] == null ? null : json["version"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "assistance": assistance == null ? null : assistance.toMap(),
    "version": version == null ? null : version,
  };

  Map<String, dynamic> toMapId() => {'id': id};
}

class Assistance {
  Assistance({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue,
    this.version,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  String langValue;
  int version;
  String langValue1;

  factory Assistance.fromMap(Map<String, dynamic> json) => Assistance(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    langValue: json["langValue"] == null ? null : json["langValue"],
    version: json["version"] == null ? null : json["version"],
    langValue1: json["langValue1"] == null ? null : json["langValue1"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "langValue": langValue == null ? null : langValue,
    "version": version == null ? null : version,
    "langValue1": langValue1 == null ? null : langValue1,
  };
}
