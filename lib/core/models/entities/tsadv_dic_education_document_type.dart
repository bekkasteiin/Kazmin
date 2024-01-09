import 'dart:convert';

class TsadvDicEducationDocumentType {
  String entityName;
  String instanceName;
  String id;
  String langValue1;

  TsadvDicEducationDocumentType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
  });

  factory TsadvDicEducationDocumentType.fromJson(String str) => TsadvDicEducationDocumentType.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvDicEducationDocumentType.fromMap(Map<String, dynamic> json) {
    return TsadvDicEducationDocumentType(
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
