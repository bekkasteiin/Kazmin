import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_education_document_type.dart';

class TsadvPersonQualification {
  String entityName;
  String instanceName;
  String courseName;
  String diploma;
  TsadvDicEducationDocumentType educationDocumentType;
  String educationalInstitutionName;
  DateTime endDate;
  DateTime expiryDate;
  String id;
  DateTime issuedDate;
  BasePersonGroupExt personGroup;
  String profession;
  String qualification;
  DateTime startDate;

  TsadvPersonQualification({
    this.entityName,
    this.instanceName,
    this.courseName,
    this.diploma,
    this.educationDocumentType,
    this.educationalInstitutionName,
    this.endDate,
    this.expiryDate,
    this.id,
    this.issuedDate,
    this.personGroup,
    this.profession,
    this.qualification,
    this.startDate,
  });

  static String get entity => 'tsadv\$PersonQualification';

  static String get view => 'personQualification-view';

  static String get property => 'personGroup.id';

  factory TsadvPersonQualification.fromJson(String str) {
    return TsadvPersonQualification.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPersonQualification.fromMap(Map<String, dynamic> json) {
    return TsadvPersonQualification(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      courseName: json['courseName']?.toString(),
      diploma: json['diploma']?.toString(),
      educationDocumentType:
          json['educationDocumentType'] == null ? null : TsadvDicEducationDocumentType.fromMap(json['educationDocumentType'] as Map<String, dynamic>),
      educationalInstitutionName: json['educationalInstitutionName']?.toString(),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      expiryDate: json['expiryDate'] == null ? null : DateTime.parse(json['expiryDate'].toString()),
      id: json['id']?.toString(),
      issuedDate: json['issuedDate'] == null ? null : DateTime.parse(json['issuedDate'].toString()),
      personGroup: json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
      profession: json['profession']?.toString(),
      qualification: json['qualification']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'courseName': courseName,
      'diploma': diploma,
      'educationDocumentType': educationDocumentType?.toMap(),
      'educationalInstitutionName': educationalInstitutionName,
      'endDate': formatFullRestNotMilSec(endDate),
      'expiryDate': formatFullRestNotMilSec(expiryDate),
      'id': id,
      'issuedDate': formatFullRestNotMilSec(issuedDate),
      'personGroup': personGroup?.toMap(),
      'profession': profession,
      'qualification': qualification,
      'startDate': formatFullRestNotMilSec(startDate),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
