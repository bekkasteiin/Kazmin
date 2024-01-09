import 'dart:convert';

import 'package:kzm/core/models/entities/base_dic_company.dart';

class TsadvDicKindOfAward {
  String entityName;
  String instanceName;
  String id;
  BaseDicCompany company;
  String langValue5;
  String langValue4;
  String langValue3;
  String langValue2;
  String langValue1;

  TsadvDicKindOfAward({
    this.entityName,
    this.instanceName,
    this.id,
    this.company,
    this.langValue5,
    this.langValue4,
    this.langValue3,
    this.langValue2,
    this.langValue1,
  });

  static String get entity => 'tsadv_DicKindOfAward';

  factory TsadvDicKindOfAward.fromJson(String str) {
    return TsadvDicKindOfAward.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicKindOfAward.fromMap(Map<String, dynamic> json) {
    return TsadvDicKindOfAward(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      company: json['company'] == null ? null : BaseDicCompany.fromMap(json['company'] as Map<String, dynamic>),
      langValue5: json['langValue5']?.toString(),
      langValue4: json['langValue4']?.toString(),
      langValue3: json['langValue3']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue1: json['langValue1']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'company': company?.toMap(),
      'langValue5': langValue5,
      'langValue4': langValue4,
      'langValue3': langValue3,
      'langValue2': langValue2,
      'langValue1': langValue1,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
