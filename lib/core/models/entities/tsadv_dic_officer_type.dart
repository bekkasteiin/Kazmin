import 'dart:convert';

class TsadvDicOfficerType {
  String entityName;
  String instanceName;
  bool active;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue1;
  String langValue2;
  String langValue3;
  String legacyId;

  TsadvDicOfficerType({
    this.entityName,
    this.instanceName,
    this.active,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.legacyId,
  });

  static String get entity => 'tsadv\$DicOfficerType';

  factory TsadvDicOfficerType.fromJson(String str) {
    return TsadvDicOfficerType.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicOfficerType.fromMap(Map<String, dynamic> json) {
    return TsadvDicOfficerType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
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
