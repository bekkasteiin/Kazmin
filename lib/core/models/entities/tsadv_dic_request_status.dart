/*
"_entityName": "tsadv$DicRequestStatus"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class TsadvDicRequestStatus {
  String entityName;
  String instanceName;
  String code;
  String id;
  String langValueOrig;
  String langValueLocale;
  String langValue1;
  String langValue2;
  String langValue3;

  TsadvDicRequestStatus({
    this.entityName,
    this.instanceName,
    this.code,
    this.id,
    this.langValueOrig,
    this.langValueLocale,
    this.langValue1,
    this.langValue2,
    this.langValue3,
  });

  factory TsadvDicRequestStatus.fromJson(String str) {
    return TsadvDicRequestStatus.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  String get langValue => langValueOrig ?? langValueLocale;

  factory TsadvDicRequestStatus.fromMap(Map<String, dynamic> json) {
    return TsadvDicRequestStatus(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      code: json['code']?.toString(),
      id: json['id']?.toString(),
      langValueOrig: json['langValue']?.toString(),
      langValueLocale: json['langValue']?.toString() ?? json['langValue${mapLocale()}']?.toString() ?? '',
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'code': code,
      'id': id,
      'langValue': langValueOrig,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
    }..removeWhere((String key, dynamic value) => value == null);
  }

  bool get isDraft => ((code ?? '') == 'DRAFT') || ((code ?? '') == 'TO_BE_REVISED');
}
