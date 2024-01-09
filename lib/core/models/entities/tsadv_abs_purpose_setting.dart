import 'dart:convert';

import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';

class TsadvAbsPurposeSetting {
  String entityName;
  String instanceName;
  String id;
  AbstractDictionary absencePurpose;
  DicAbsenceType absenceType;

  TsadvAbsPurposeSetting({
    this.entityName,
    this.instanceName,
    this.id,
    this.absencePurpose,
    this.absenceType,
  });

  static String get entity => 'tsadv_AbsPurposeSetting';

  static String get view => null;

  static String get property => null;

  factory TsadvAbsPurposeSetting.fromJson(String str) {
    return TsadvAbsPurposeSetting.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvAbsPurposeSetting.fromMap(Map<String, dynamic> json) {
    return TsadvAbsPurposeSetting(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      absencePurpose: json['absencePurpose'] == null ? null : AbstractDictionary.fromMap(json['absencePurpose'] as Map<String, dynamic>),
      absenceType: json['absenceType'] == null ? null : DicAbsenceType.fromMap(json['absenceType'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'absencePurpose': absencePurpose?.toMap(),
      'absenceType': absenceType?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
