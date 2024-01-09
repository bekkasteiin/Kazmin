/*
"_entityName": "base$PersonGroupExt"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/base_assignment_ext.dart';
import 'package:kzm/core/models/entities/base_dic_company.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';

class BasePersonGroupExt {
  String entityName;
  String instanceName;
  String fioWithEmployeeNumber;
  String firstLastName;
  String fullName;
  String personFioWithEmployeeNumber;
  String personFirstLastNameLatin;
  String personLatinFioWithEmployeeNumber;
  int version;
  List<BaseAssignmentExt> assignments;
  String id;
  String legacyId;
  List<BasePersonExt> list;
  BasePersonExt person;
  BaseDicCompany company;

  //todo personExperience
  List<Map<String, dynamic>> personExperience;

  BasePersonGroupExt({
    this.entityName,
    this.instanceName,
    this.fioWithEmployeeNumber,
    this.firstLastName,
    this.fullName,
    this.personFioWithEmployeeNumber,
    this.personFirstLastNameLatin,
    this.personLatinFioWithEmployeeNumber,
    this.version,
    this.assignments,
    this.id,
    this.legacyId,
    this.list,
    this.person,
    this.personExperience,
    this.company,
  });

  factory BasePersonGroupExt.fromJson(String str) {
    return BasePersonGroupExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BasePersonGroupExt.fromMap(Map<String, dynamic> json) {
    return BasePersonGroupExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      fioWithEmployeeNumber: json['fioWithEmployeeNumber']?.toString(),
      firstLastName: json['firstLastName']?.toString(),
      fullName: json['fullName']?.toString(),
      personFioWithEmployeeNumber: json['personFioWithEmployeeNumber']?.toString(),
      personFirstLastNameLatin: json['personFirstLastNameLatin']?.toString(),
      personLatinFioWithEmployeeNumber: json['personLatinFioWithEmployeeNumber']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
      id: json['id']?.toString(),
      legacyId: json['legacyId']?.toString(),
      assignments: (json['assignments'] == null)
          ? null
          : (json['assignments'] as List<dynamic>).map((dynamic i) => BaseAssignmentExt.fromMap(i as Map<String, dynamic>)).toList(),
      list: (json['list'] == null) ? null : (json['list'] as List<dynamic>).map((dynamic i) => BasePersonExt.fromMap(i as Map<String, dynamic>)).toList(),

      person: json['person'] == null ? null : BasePersonExt.fromMap(json['person'] as Map<String, dynamic>),

      //todo map
      personExperience:
          (json['personExperience'] == null) ? null : (json['personExperience'] as List<dynamic>).map((dynamic i) => i as Map<String, dynamic>).toList(),
      company: json['company'] == null ? null : BaseDicCompany.fromMap(json['company'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'fioWithEmployeeNumber': fioWithEmployeeNumber,
      'firstLastName': firstLastName,
      'fullName': fullName,
      'personFioWithEmployeeNumber': personFioWithEmployeeNumber,
      'personFirstLastNameLatin': personFirstLastNameLatin,
      'personLatinFioWithEmployeeNumber': personLatinFioWithEmployeeNumber,
      'version': version,
      'id': id,
      'legacyId': legacyId,
      'assignments': assignments?.map((BaseAssignmentExt e) => e.toMap())?.toList(),
      'list': list?.map((BasePersonExt e) => e.toMap())?.toList(),
      'personExperience': personExperience,
      'person': person?.toMap(),
      'company': company?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
