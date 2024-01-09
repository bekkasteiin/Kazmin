import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_dic_attitude_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_document_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_rank.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_officer_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_suitability_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_troops_structure.dart';
import 'package:kzm/core/models/entities/tsadv_dic_udo.dart';

class TsadvMilitaryForm {
  String entityName;
  String instanceName;
  TsadvDicAttitudeToMilitary attitudeToMilitary;
  DateTime dateFrom;
  DateTime dateTo;
  String documentNumber;
  String id;
  String legacyId;
  TsadvDicMilitaryDocumentType militaryDocumentType;
  TsadvDicMilitaryRank militaryRank;
  TsadvDicMilitaryType militaryType;
  TsadvDicOfficerType officerType;
  String specialization;
  TsadvDicSuitabilityToMilitary suitabilityToMilitary;
  TsadvDicUdo udo;
  TsadvDicTroopsStructure troopsStructure;

  TsadvMilitaryForm({
    this.entityName,
    this.instanceName,
    this.attitudeToMilitary,
    this.dateFrom,
    this.dateTo,
    this.documentNumber,
    this.id,
    this.legacyId,
    this.militaryDocumentType,
    this.militaryRank,
    this.militaryType,
    this.officerType,
    this.specialization,
    this.suitabilityToMilitary,
    this.udo,
    this.troopsStructure,
  });

  static String get entity => 'tsadv\$MilitaryForm';

  static String get view => 'militaryForm-view';

  static String get property => 'personGroup.id';

  factory TsadvMilitaryForm.fromJson(String str) {
    return TsadvMilitaryForm.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvMilitaryForm.fromMap(Map<String, dynamic> json) {
    return TsadvMilitaryForm(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      attitudeToMilitary:
          json['attitude_to_military'] == null ? null : TsadvDicAttitudeToMilitary.fromMap(json['attitude_to_military'] as Map<String, dynamic>),
      dateFrom: json['date_from'] == null ? null : DateTime.parse(json['date_from'].toString()),
      dateTo: json['date_to'] == null ? null : DateTime.parse(json['date_to'].toString()),
      documentNumber: json['document_number']?.toString(),
      id: json['id']?.toString(),
      legacyId: json['legacyId']?.toString(),
      militaryDocumentType:
          json['military_document_type'] == null ? null : TsadvDicMilitaryDocumentType.fromMap(json['military_document_type'] as Map<String, dynamic>),
      militaryRank: json['military_rank'] == null ? null : TsadvDicMilitaryRank.fromMap(json['military_rank'] as Map<String, dynamic>),
      militaryType: json['military_type'] == null ? null : TsadvDicMilitaryType.fromMap(json['military_type'] as Map<String, dynamic>),
      officerType: json['officer_type'] == null ? null : TsadvDicOfficerType.fromMap(json['officer_type'] as Map<String, dynamic>),
      specialization: json['specialization']?.toString(),
      suitabilityToMilitary:
          json['suitability_to_military'] == null ? null : TsadvDicSuitabilityToMilitary.fromMap(json['suitability_to_military'] as Map<String, dynamic>),
      udo: json['udo'] == null ? null : TsadvDicUdo.fromMap(json['udo'] as Map<String, dynamic>),
      troopsStructure: json['troops_structure'] == null ? null : TsadvDicTroopsStructure.fromMap(json['troops_structure'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'attitude_to_military': attitudeToMilitary?.toMap(),
      'date_from': formatFullRestNotMilSec(dateFrom),
      'date_to': formatFullRestNotMilSec(dateTo),
      'document_number': documentNumber,
      'id': id,
      'legacyId': legacyId,
      'military_document_type': militaryDocumentType?.toMap(),
      'military_rank': militaryRank?.toMap(),
      'military_type': militaryType?.toMap(),
      'officer_type': officerType?.toMap(),
      'specialization': specialization,
      'suitability_to_military': suitabilityToMilitary?.toMap(),
      'udo': udo?.toMap(),
      'troops_structure': troopsStructure?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
