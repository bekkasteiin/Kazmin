import 'dart:convert';

class TsadvDicMilitaryRank {
  String entityName;
  String instanceName;
  bool active;
  String description1;
  String description2;
  String description3;
  String description4;
  String description5;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue1;
  String langValue2;
  String langValue3;
  String legacyId;

  TsadvDicMilitaryRank({
    this.entityName,
    this.instanceName,
    this.active,
    this.description1,
    this.description2,
    this.description3,
    this.description4,
    this.description5,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.legacyId,
  });

  static String get entity => 'tsadv\$DicMilitaryRank';

  factory TsadvDicMilitaryRank.fromJson(String str) {
    return TsadvDicMilitaryRank.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicMilitaryRank.fromMap(Map<String, dynamic> json) {
    return TsadvDicMilitaryRank(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      id: json['id']?.toString(),
      description1: json['description1']?.toString(),
      description2: json['description2']?.toString(),
      description3: json['description3']?.toString(),
      description4: json['description4']?.toString(),
      description5: json['description5']?.toString(),
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
      'description1': description1,
      'description2': description2,
      'description3': description3,
      'description4': description4,
      'description5': description5,
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
