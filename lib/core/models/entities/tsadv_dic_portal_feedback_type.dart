import 'dart:convert';

class TsadvDicPortalFeedbackType {
  String entityName;
  String instanceName;
  bool active;
  String code;
  String id;
  bool isDefault;
  bool isSystemRecord;
  String langValue;
  String langValue1;
  String langValue2;
  String langValue3;
  String systemNotificationText;
  String systemNotificationText1;
  String systemNotificationText2;
  String systemNotificationText3;
  int version;

  TsadvDicPortalFeedbackType({
    this.entityName,
    this.instanceName,
    this.active,
    this.code,
    this.id,
    this.isDefault,
    this.isSystemRecord,
    this.langValue,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.systemNotificationText,
    this.systemNotificationText1,
    this.systemNotificationText2,
    this.systemNotificationText3,
    this.version,
  });

  factory TsadvDicPortalFeedbackType.fromJson(String str) {
    return TsadvDicPortalFeedbackType.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvDicPortalFeedbackType.fromMap(Map<String, dynamic> json) {
    return TsadvDicPortalFeedbackType(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      code: json['code']?.toString(),
      id: json['id']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      langValue: json['langValue']?.toString(),
      langValue1: json['langValue1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      systemNotificationText: json['systemNotificationText']?.toString(),
      systemNotificationText1: json['systemNotificationText1']?.toString(),
      systemNotificationText2: json['systemNotificationText2']?.toString(),
      systemNotificationText3: json['systemNotificationText3']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'code': code,
      'id': id,
      'isDefault': isDefault,
      'isSystemRecord': isSystemRecord,
      'langValue': langValue,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'systemNotificationText': systemNotificationText,
      'systemNotificationText1': systemNotificationText1,
      'systemNotificationText2': systemNotificationText2,
      'systemNotificationText3': systemNotificationText3,
      'version': version,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
