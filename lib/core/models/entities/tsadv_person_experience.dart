import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';

class TsadvPersonExperience {
  String entityName;
  String instanceName;
  String company;
  String description;
  String location;
  DateTime endMonth;
  String id;
  String job;
  BasePersonGroupExt personGroup;
  DateTime startMonth;

  TsadvPersonExperience({
    this.entityName,
    this.instanceName,
    this.company,
    this.description,
    this.location,
    this.endMonth,
    this.id,
    this.job,
    this.personGroup,
    this.startMonth,
  });

  static String get entity => 'tsadv\$PersonExperience';

  static String get view => 'personExperience.full';

  static String get property => 'personGroup.id';

  factory TsadvPersonExperience.fromJson(String str) {
    return TsadvPersonExperience.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPersonExperience.fromMap(Map<String, dynamic> json) {
    return TsadvPersonExperience(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      company: json['company']?.toString(),
      description: json['description']?.toString(),
      location: json['location']?.toString(),
      endMonth: json['endMonth'] == null ? null : DateTime.parse(json['endMonth'].toString()),
      id: json['id']?.toString(),
      job: json['job']?.toString(),
      personGroup: json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
      startMonth: json['startMonth'] == null ? null : DateTime.parse(json['startMonth'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'company': company,
      'description': description,
      'location': location,
      'endMonth': formatFullRestNotMilSec(endMonth),
      'id': id,
      'job': job,
      'personGroup': personGroup?.toMap(),
      'startMonth': formatFullRestNotMilSec(startMonth),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
