import 'dart:convert';

class TsadvDicFormStudy {
  String entityName;
  String instanceName;
  String code;
  String id;
  String langValue1;
  String legacyId;

  TsadvDicFormStudy({
    this.entityName,
    this.instanceName,
    this.code,
    this.id,
    this.langValue1,
    this.legacyId,
  });

  factory TsadvDicFormStudy.fromJson(String str) => TsadvDicFormStudy.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvDicFormStudy.fromMap(Map<String, dynamic> json) {
    return TsadvDicFormStudy(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      code: json['code']?.toString(),
      id: json['id']?.toString(),
      langValue1: json['langValue1']?.toString(),
      legacyId: json['legacyId']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'code': code,
      'id': id,
      'langValue1': langValue1,
      'legacyId': legacyId,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
