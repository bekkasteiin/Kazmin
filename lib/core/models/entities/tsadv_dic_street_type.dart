import 'dart:convert';

class TsadvDicStreetType {
  String entityName;
  String instanceName;
  String id;
  String langValue1;
  String langValue2;
  String langValue3;

  TsadvDicStreetType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
    this.langValue2,
    this.langValue3,
  });

  factory TsadvDicStreetType.fromJson(String str) {
    return TsadvDicStreetType.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicStreetType.fromMap(Map<String, dynamic> json) {
    return TsadvDicStreetType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
