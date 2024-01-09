import 'dart:convert';

class TsadvDicPhoneType {
  String entityName;
  String instanceName;
  String id;
  String langValue;
  String langValue1;
  String langValue2;
  String langValue3;

  TsadvDicPhoneType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue,
    this.langValue1,
    this.langValue2,
    this.langValue3,
  });

  factory TsadvDicPhoneType.fromJson(String str) {
    return TsadvDicPhoneType.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicPhoneType.fromMap(Map<String, dynamic> json) {
    return TsadvDicPhoneType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      langValue: json['langValue']?.toString(),
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
      'langValue': langValue,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
