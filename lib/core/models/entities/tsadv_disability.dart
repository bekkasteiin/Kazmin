import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_disability_type.dart';

class TsadvDisability {
  String entityName;
  String instanceName;
  DateTime createTs;
  String createdBy;
  DateTime dateFrom;
  DateTime dateTo;
  TsadvDicDisabilityType disabilityType;
  DateTime endDateHistory;
  bool hasDisability;
  String haveDisability;
  String id;
  BasePersonGroupExt personGroupExt;
  DateTime startDateHistory;
  DateTime updateTs;
  String updatedBy;
  int version;

  TsadvDisability({
    this.entityName,
    this.instanceName,
    this.createTs,
    this.createdBy,
    this.dateFrom,
    this.dateTo,
    this.disabilityType,
    this.endDateHistory,
    this.hasDisability,
    this.haveDisability,
    this.id,
    this.personGroupExt,
    this.startDateHistory,
    this.updateTs,
    this.updatedBy,
    this.version,
  });

  static String get entity => 'tsadv\$Disability';

  static String get view => 'disability.all';

  static String get property => 'personGroupExt.id';

  factory TsadvDisability.fromJson(String str) {
    return TsadvDisability.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDisability.fromMap(Map<String, dynamic> json) {
    return TsadvDisability(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs'].toString()),
      createdBy: json['createdBy']?.toString(),
      dateFrom: json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom'].toString()),
      dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo'].toString()),
      disabilityType: json['disabilityType'] == null ? null : TsadvDicDisabilityType.fromMap(json['disabilityType'] as Map<String, dynamic>),
      endDateHistory: json['endDateHistory'] == null ? null : DateTime.parse(json['endDateHistory'].toString()),
      hasDisability: json['hasDisability'] == null ? null : json['hasDisability'] as bool,
      haveDisability: json['haveDisability']?.toString(),
      id: json['id']?.toString(),
      personGroupExt: json['personGroupExt'] == null ? null : BasePersonGroupExt.fromMap(json['personGroupExt'] as Map<String, dynamic>),
      startDateHistory: json['startDateHistory'] == null ? null : DateTime.parse(json['startDateHistory'].toString()),
      updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs'].toString()),
      updatedBy: json['updatedBy']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'createTs': formatFullRest(createTs),
      'createdBy': createdBy,
      'dateFrom': formatFullRestNotMilSec(dateFrom),
      'dateTo': formatFullRestNotMilSec(dateTo),
      'disabilityType': disabilityType?.toMap(),
      'endDateHistory': formatFullRestNotMilSec(endDateHistory),
      'hasDisability': hasDisability,
      'haveDisability': haveDisability,
      'id': id,
      'personGroupExt': personGroupExt?.toMap(),
      'startDateHistory': formatFullRestNotMilSec(startDateHistory),
      'updateTs': formatFullRest(updateTs),
      'updatedBy': updatedBy,
      'version': version,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
