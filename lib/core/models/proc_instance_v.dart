// To parse this JSON data, do
//
//     final procInstanceV = procInstanceVFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

part 'proc_instance_v.g.dart';

@HiveType(typeId: 15)
class ProcInstanceV {
  ProcInstanceV({
    this.entityName,
    this.instanceName,
    this.id,
    this.processKz,
    this.processEn,
    this.requestNumber,
    this.procInstanceVEntityName,
    this.requestDate,
    this.startTime,
    this.startUser,
    this.active,
    this.entityId,
    this.processRu,
    this.businessKey,
    this.status,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String processKz;
  @HiveField(4)
  String processEn;
  @HiveField(5)
  int requestNumber;
  @HiveField(6)
  String procInstanceVEntityName;
  @HiveField(7)
  DateTime requestDate;
  @HiveField(8)
  DateTime startTime;
  @HiveField(9)
  Person startUser;
  @HiveField(10)
  bool active;
  @HiveField(11)
  String entityId;
  @HiveField(12)
  String processRu;
  @HiveField(13)
  String businessKey;
  @HiveField(14)
  AbstractDictionary status;

  factory ProcInstanceV.fromJson(String str) => ProcInstanceV.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProcInstanceV.fromMap(Map<String, dynamic> json) => ProcInstanceV(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        processKz: json['processKz'],
        processEn: json['processEn'],
        requestNumber: json['requestNumber'],
        procInstanceVEntityName: json['entityName'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        startTime: json['startTime'] == null ? null : DateTime.parse(json['startTime']),
        startUser: json['startUser'] == null ? null : Person.fromMap(json['startUser']),
        active: json['active'],
        entityId: json['entityId'],
        processRu: json['processRu'],
        businessKey: json['businessKey'],
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'processKz': processKz,
        'processEn': processEn,
        'requestNumber': requestNumber,
        'entityName': procInstanceVEntityName,
        'requestDate': requestDate == null
            ? null
            : "${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}",
        'startTime': startTime == null ? null : startTime.toIso8601String(),
        'startUser': startUser == null ? null : startUser.toMap(),
        'active': active,
        'entityId': entityId,
        'processRu': processRu,
        'businessKey': businessKey,
        'status': status == null ? null : status.toMap(),
      };
}
