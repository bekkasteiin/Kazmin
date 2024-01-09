/*
"_entityName": "base$OrganizationExt"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class BaseOrganizationExt {
  String entityName;
  String instanceName;
  String endDate;
  String id;
  String organizationNameLocale;
  String organizationName;
  String organizationNameLang1;
  String organizationNameLang2;
  String organizationNameLang3;
  String startDate;

  BaseOrganizationExt({
    this.entityName,
    this.instanceName,
    this.endDate,
    this.id,
    this.organizationNameLocale,
    this.organizationName,
    this.organizationNameLang1,
    this.organizationNameLang2,
    this.organizationNameLang3,
    this.startDate,
  });

  factory BaseOrganizationExt.fromJson(String str) {
    return BaseOrganizationExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BaseOrganizationExt.fromMap(Map<String, dynamic> json) {
    return BaseOrganizationExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      endDate: json['endDate']?.toString(),
      id: json['id']?.toString(),
      organizationNameLocale: (json['organizationName${mapLocale()}'] ?? json['organizationNameLang1']) as String,
      organizationName: json['organizationName']?.toString(),
      organizationNameLang1: json['organizationNameLang1']?.toString(),
      organizationNameLang2: json['organizationNameLang2']?.toString(),
      organizationNameLang3: json['organizationNameLang3']?.toString(),
      startDate: json['startDate']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'endDate': endDate,
      'id': id,
      'organizationName': organizationName,
      'organizationNameLang1': organizationNameLang1,
      'organizationNameLang2': organizationNameLang2,
      'organizationNameLang3': organizationNameLang3,
      'startDate': startDate,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
