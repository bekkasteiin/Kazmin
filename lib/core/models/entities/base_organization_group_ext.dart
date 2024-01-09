/*
"_entityName": "base$OrganizationGroupExt"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/entities/base_organization_ext.dart';

class BaseOrganizationGroupExt {
  String entityName;
  String instanceName;
  String id;
  List<BaseOrganizationExt> list;
  String organizationNameLocale;
  String organizationName;
  String organizationNameLang1;
  String organizationNameLang2;
  String organizationNameLang3;

  BaseOrganizationGroupExt({
    this.entityName,
    this.instanceName,
    this.id,
    this.list,
    this.organizationNameLocale,
    this.organizationName,
    this.organizationNameLang1,
    this.organizationNameLang2,
    this.organizationNameLang3,
  });

  factory BaseOrganizationGroupExt.fromJson(String str) {
    return BaseOrganizationGroupExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BaseOrganizationGroupExt.fromMap(Map<String, dynamic> json) {
    return BaseOrganizationGroupExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      list: (json['list'] == null)
          ? null
          : (json['list'] as List<dynamic>)
              .map((dynamic i) => BaseOrganizationExt.fromMap(i as Map<String, dynamic>))
              .toList(),
      organizationNameLocale: (json['organizationName${mapLocale()}'] ?? json['organizationNameLang1']) as String,
      organizationName: json['organizationName']?.toString(),
      organizationNameLang1: json['organizationNameLang1']?.toString(),
      organizationNameLang2: json['organizationNameLang2']?.toString(),
      organizationNameLang3: json['organizationNameLang3']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'organizationName': organizationName,
      'organizationNameLang1': organizationNameLang1,
      'organizationNameLang2': organizationNameLang2,
      'organizationNameLang3': organizationNameLang3,
      'list': list?.map((BaseOrganizationExt e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
