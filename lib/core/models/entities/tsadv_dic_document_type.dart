/*
 "_entityName": "tsadv$DicDocumentType"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class TsadvDicDocumentType {
  String entityName;
  String instanceName;
  String id;
  String langValue3;
  String langValueOrig;
  String langValueLocale;
  String langValue2;
  String langValue1;
  String code;
  String legacyId;
  bool isIdOrPassport;
  bool isSystemRecord;
  bool active;
  bool isDefault;
  bool foreigner;
  int order;

  TsadvDicDocumentType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.langValueOrig,
    this.langValueLocale,
    this.langValue2,
    this.langValue1,
    this.code,
    this.legacyId,
    this.isIdOrPassport,
    this.isSystemRecord,
    this.active,
    this.isDefault,
    this.foreigner,
    this.order,
  });

  factory TsadvDicDocumentType.fromJson(String str) => TsadvDicDocumentType.fromMap(json.decode(str) as Map<String, dynamic>);

  String get langValue => langValueOrig ?? langValueLocale;

  String toJson() => json.encode(toMap());

  factory TsadvDicDocumentType.fromMap(Map<String, dynamic> json) => TsadvDicDocumentType(
        entityName: json['_entityName']?.toString(),
        instanceName: json['_instanceName']?.toString(),
        id: json['id']?.toString(),
        langValueOrig: json['langValue']?.toString(),
        langValueLocale: json['langValue']?.toString() ?? json['langValue${mapLocale()}']?.toString() ?? '',
        langValue1: json['langValue1']?.toString(),
        langValue2: json['langValue2']?.toString(),
        langValue3: json['langValue3']?.toString(),
        code: json['code']?.toString(),
        legacyId: json['legacyId']?.toString(),
        isIdOrPassport: json['isIdOrPassport'] == null ? null : json['isIdOrPassport'] as bool,
        isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
        active: json['active'] == null ? null : json['active'] as bool,
        isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
        foreigner: json['foreigner'] == null ? null : json['foreigner'] as bool,
        order: json['order'] == null ? null : int.parse(json['order'].toString()),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'langValue3': langValue3,
        'langValue': langValueOrig,
        'langValue2': langValue2,
        'langValue1': langValue1,
        'code': code,
        'legacyId': legacyId,
        'isIdOrPassport': isIdOrPassport,
        'isSystemRecord': isSystemRecord,
        'active': active,
        'isDefault': isDefault,
        'foreigner': foreigner,
        'order': order,
      }..removeWhere((String key, dynamic value) => value == null);
}
