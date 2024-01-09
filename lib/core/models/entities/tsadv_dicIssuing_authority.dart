/*
 "_entityName": "tsadv$DicDocumentType"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class TsadvDicIssuingAuthority {
  String entityName;
  String instanceName;
  String id;
  String langValue3;
  String langValueOrig;
  String langValueLocale;
  String langValue2;
  String langValue1;

  TsadvDicIssuingAuthority({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.langValueOrig,
    this.langValueLocale,
    this.langValue2,
    this.langValue1,
  });

  factory TsadvDicIssuingAuthority.fromJson(String str) =>
      TsadvDicIssuingAuthority.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  String get langValue => langValueOrig ?? langValueLocale;

  factory TsadvDicIssuingAuthority.fromMap(Map<String, dynamic> json) => TsadvDicIssuingAuthority(
        entityName: json['_entityName']?.toString(),
        instanceName: json['_instanceName']?.toString(),
        id: json['id']?.toString(),
        langValueOrig: json['langValue']?.toString(),
        langValueLocale: json['langValue']?.toString() ?? json['langValue${mapLocale()}']?.toString() ?? '',
        langValue1: json['langValue1']?.toString(),
        langValue2: json['langValue2']?.toString(),
        langValue3: json['langValue3']?.toString(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'langValue3': langValue3,
        'langValue': langValueOrig,
        'langValue2': langValue2,
        'langValue1': langValue1,
      }..removeWhere((String key, dynamic value) => value == null);
}
