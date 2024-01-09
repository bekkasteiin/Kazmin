import 'dart:convert';

class BaseDicCompany {
  String entityName;
  String instanceName;
  String code;
  String id;
  String langValue1;
  String langValue2;
  String langValue3;
  String legacyId;

  BaseDicCompany({
    this.entityName,
    this.instanceName,
    this.code,
    this.id,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.legacyId,
  });

  factory BaseDicCompany.fromJson(String str) => BaseDicCompany.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory BaseDicCompany.fromMap(Map<String, dynamic> json) {
    return BaseDicCompany(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      code: json['code']?.toString(),
      id: json['id']?.toString(),
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
      'code': code,
      'id': id,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'legacyId': legacyId,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
