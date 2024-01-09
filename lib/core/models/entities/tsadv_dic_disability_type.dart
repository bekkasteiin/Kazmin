import 'dart:convert';


class TsadvDicDisabilityType {
  String entityName;
  String instanceName;
  bool active;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue1;

  TsadvDicDisabilityType({
    this.entityName,
    this.instanceName,
    this.active,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
  });

  static String get entity => 'tsadv\$DicDisabilityType';

  factory TsadvDicDisabilityType.fromJson(String str) {
    return TsadvDicDisabilityType.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicDisabilityType.fromMap(Map<String, dynamic> json) {
    return TsadvDicDisabilityType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      id: json['id']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      langValue1: json['langValue1']?.toString(),
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
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
