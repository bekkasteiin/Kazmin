import 'dart:convert';

class TsadvDicEducationDegree {
  String entityName;
  String instanceName;
  String id;
  String langValue1;

  TsadvDicEducationDegree({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
  });

  factory TsadvDicEducationDegree.fromJson(String str) => TsadvDicEducationDegree.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvDicEducationDegree.fromMap(Map<String, dynamic> json) {
    return TsadvDicEducationDegree(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      langValue1: json['langValue1']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'langValue1': langValue1,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
