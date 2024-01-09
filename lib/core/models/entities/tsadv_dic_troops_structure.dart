import 'dart:convert';

import 'package:kzm/core/models/entities/base_dic_company.dart';

class TsadvDicTroopsStructure {
  String entityName;
  String instanceName;
  bool active;
  BaseDicCompany company;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue1;
  String langValue2;
  String langValue3;
  String legacyId;

  TsadvDicTroopsStructure({
    this.entityName,
    this.instanceName,
    this.active,
    this.company,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.legacyId,
  });

  static String get entity => 'tsadv\$DicTroopsStructure';

  factory TsadvDicTroopsStructure.fromJson(String str) {
    return TsadvDicTroopsStructure.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicTroopsStructure.fromMap(Map<String, dynamic> json) {
    return TsadvDicTroopsStructure(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      company: json['company'] == null ? null : BaseDicCompany.fromMap(json['company'] as Map<String, dynamic>),
      id: json['id']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      legacyId: json['legacyId']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'company': company?.toMap(),
      'id': id,
      'isDefault': isDefault,
      'isSystemRecord': isSystemRecord,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'legacyId': legacyId,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
