import 'dart:convert';

class BaseDicCountry {
  String entityName;
  String instanceName;
  String id;
  String langValue1;
  String langValue2;
  String langValue3;
  String languageValue;

  BaseDicCountry({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.languageValue,
  });

  factory BaseDicCountry.fromJson(String str) {
    return BaseDicCountry.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BaseDicCountry.fromMap(Map<String, dynamic> json) {
    return BaseDicCountry(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      languageValue: json['languageValue']?.toString(),
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
      'languageValue': languageValue,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
