import 'dart:convert';

import 'package:kzm/core/models/entities/base_dic_company.dart';

class BaseDicEducationType {
  String entityName;
  String instanceName;
  String id;
  String langValue1;
  String legacyId;
  BaseDicCompany company;

  BaseDicEducationType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
    this.legacyId,
    this.company,
  });

  factory BaseDicEducationType.fromJson(String str) => BaseDicEducationType.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory BaseDicEducationType.fromMap(Map<String, dynamic> json) {
    return BaseDicEducationType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      langValue1: json['langValue1']?.toString(),
      legacyId: json['legacyId']?.toString(),
      company: json['company'] == null ? null : BaseDicCompany.fromMap(json['company'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'langValue1': langValue1,
      'legacyId': legacyId,
      'company': company?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
