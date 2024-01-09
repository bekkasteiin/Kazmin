/*
"_entityName": "tsadv$DicAssignmentStatus"
*/

import 'dart:convert';


class TsadvDicAssignmentStatus {
  String entityName;
  String instanceName;
  bool active;
  String code;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue1;
  String langValue2;
  String langValue3;
  String legacyId;

  TsadvDicAssignmentStatus({
    this.entityName,
    this.instanceName,
    this.active,
    this.code,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.legacyId,
  });

  factory TsadvDicAssignmentStatus.fromJson(String str) {
    return TsadvDicAssignmentStatus.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicAssignmentStatus.fromMap(Map<String, dynamic> json) {
    return TsadvDicAssignmentStatus(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      code: json['code']?.toString(),
      id: json['id']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      legacyId: json['legacyId']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'code': code,
      'id': id,
      'isDefault': isDefault,
      'isSystemRecord': isSystemRecord,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'legacyId': legacyId,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
