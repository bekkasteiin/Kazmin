import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_dic_education_type.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_form_study.dart';

class TsadvPersonEducation {
  String entityName;
  String instanceName;
  String city;

  String diplomaNumber;
  BaseDicEducationType educationType;
  int endYear;
  String faculty;
  bool foreignEducation;
  TsadvDicFormStudy formStudy;
  DateTime graduationDate;
  String id;
  String legacyId;
  BasePersonGroupExt personGroup;
  String qualification;
  String school;
  String specialization;
  int startYear;

  TsadvPersonEducation({
    this.entityName,
    this.instanceName,
    this.city,
    this.diplomaNumber,
    this.educationType,
    this.endYear,
    this.faculty,
    this.foreignEducation,
    this.formStudy,
    this.graduationDate,
    this.id,
    this.legacyId,
    this.qualification,
    this.school,
    this.specialization,
    this.startYear,
    this.personGroup,
  });

  static String get entity => 'tsadv\$PersonEducation';

  static String get view => 'personEducation.full';

  static String get property => 'personGroup.id';

  factory TsadvPersonEducation.fromJson(String str) {
    return TsadvPersonEducation.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPersonEducation.fromMap(Map<String, dynamic> json) {
    return TsadvPersonEducation(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      city: json['city']?.toString(),
      diplomaNumber: json['diplomaNumber']?.toString(),
      educationType: json['educationType'] == null ? null : BaseDicEducationType.fromMap(json['educationType'] as Map<String, dynamic>),
      endYear: json['endYear'] == null ? null : int.parse(json['endYear'].toString()),
      faculty: json['faculty']?.toString(),
      foreignEducation: json['foreignEducation'] == null ? null : json['foreignEducation'] as bool,
      formStudy: json['formStudy'] == null ? null : TsadvDicFormStudy.fromMap(json['formStudy'] as Map<String, dynamic>),
      graduationDate: json['graduationDate'] == null ? null : DateTime.parse(json['graduationDate'].toString()),
      id: json['id']?.toString(),
      legacyId: json['legacyId']?.toString(),
      qualification: json['qualification']?.toString(),
      school: json['school']?.toString(),
      specialization: json['specialization']?.toString(),
      startYear: json['startYear'] == null ? null : int.parse(json['startYear'].toString()),
      personGroup: json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'city': city,
      'diplomaNumber': diplomaNumber,
      'educationType': educationType?.toMap(),
      'endYear': endYear,
      'faculty': faculty,
      'foreignEducation': foreignEducation,
      'formStudy': formStudy?.toMap(),
      'graduationDate': formatFullRestNotMilSec(graduationDate),
      'id': id,
      'legacyId': legacyId,
      'qualification': qualification,
      'school': school,
      'specialization': specialization,
      'startYear': startYear,
      'personGroup': personGroup?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
