/*
"_entityName": "tsadv$DicHrRole"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class TsadvDicHrRole {
  String entityName;
  String instanceName;
  bool active;
  String code;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValueOrig;
  String langValueLocale;
  String langValue1;
  String langValue2;
  String langValue3;
  String createTs;
  String createdBy;
  String updateTs;
  String updatedBy;
  int order;
  int version;

  TsadvDicHrRole({
    this.entityName,
    this.instanceName,
    this.active,
    this.code,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValueOrig,
    this.langValueLocale,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.createTs,
    this.createdBy,
    this.updateTs,
    this.updatedBy,
    this.order,
    this.version,
  });

  factory TsadvDicHrRole.fromJson(String str) {
    return TsadvDicHrRole.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  String get langValue => langValueOrig ?? langValueLocale;

  factory TsadvDicHrRole.fromMap(Map<String, dynamic> json) {
    return TsadvDicHrRole(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      code: json['code']?.toString(),
      id: json['id']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      langValueOrig: json['langValue']?.toString(),
      langValueLocale: json['langValue']?.toString() ?? json['langValue${mapLocale()}']?.toString() ?? '',
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      createTs: json['createTs']?.toString(),
      createdBy: json['createdBy']?.toString(),
      updateTs: json['updateTs']?.toString(),
      updatedBy: json['updatedBy']?.toString(),
      order: json['order'] == null ? null : int.parse(json['order'].toString()),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'code': code,
      'id': id,
      'isDefault': isDefault,
      'isSystemRecord': isSystemRecord,
      'langValue': langValueOrig,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'createTs': createTs,
      'createdBy': createdBy,
      'updateTs': updateTs,
      'updatedBy': updatedBy,
      'order': order,
      'version': version,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
