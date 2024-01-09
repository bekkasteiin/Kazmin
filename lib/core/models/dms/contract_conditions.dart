// To parse this JSON data, do
//
//     final contractConditions = contractConditionsFromMap(jsonString);

import 'dart:convert';

class ContractConditions {
  ContractConditions({
    this.entityName,
    this.instanceName,
    this.id,
    this.costInKzt,
    this.ageMax,
    this.version,
    this.ageMin,
    this.isFree,
  });

  String entityName;
  String instanceName;
  String id;
  double costInKzt;
  int ageMax;
  int version;
  int ageMin;
  bool isFree;

  factory ContractConditions.fromJson(String str) => ContractConditions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractConditions.fromMap(Map<String, dynamic> json) => ContractConditions(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    costInKzt: json['costInKzt'],
    ageMax: json['ageMax'],
    version: json['version'],
    ageMin: json['ageMin'],
    isFree: json['isFree'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'costInKzt': costInKzt,
    'ageMax': ageMax,
    'version': version,
    'ageMin': ageMin,
    'isFree': isFree,
  };
}
