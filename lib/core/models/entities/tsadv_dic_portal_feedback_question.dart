import 'dart:convert';

class TsadvDicPortalFeedbackQuestion {
  String entityName;
  String instanceName;
  String deleteTs;
  String deletedBy;
  String id;
  String langValue;
  String langValue1;
  String langValue2;
  String langValue3;
  int version;

  TsadvDicPortalFeedbackQuestion({
    this.entityName,
    this.instanceName,
    this.deleteTs,
    this.deletedBy,
    this.id,
    this.langValue,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.version,
  });

  factory TsadvDicPortalFeedbackQuestion.fromJson(String str) {
    return TsadvDicPortalFeedbackQuestion.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicPortalFeedbackQuestion.fromMap(Map<String, dynamic> json) {
    return TsadvDicPortalFeedbackQuestion(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      deleteTs: json['deleteTs']?.toString(),
      deletedBy: json['deletedBy']?.toString(),
      id: json['id']?.toString(),
      langValue: json['langValue']?.toString(),
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'deleteTs': deleteTs,
      'deletedBy': deletedBy,
      'id': id,
      'langValue': langValue,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'version': version
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
