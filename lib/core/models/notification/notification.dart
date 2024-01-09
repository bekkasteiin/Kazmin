import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/constants/globals.dart';

import '../../constants/UI_design.dart';

part 'notification.g.dart';

@HiveType(typeId: 13)
class NotificationTemplate {
  NotificationTemplate({
    this.entityName,
    this.instanceName,
    this.id,
    this.notificationHeaderKz,
    this.notificationHeaderEn,
    this.notificationBodyKz,
    this.description,
    this.referenceId,
    this.notificationBodyEn,
    this.nameRu,
    this.notificationTemplateCode,
    this.notificationHeaderRu,
    this.nameKz,
    this.notificationBodyRu,
    this.notificationBody,
    this.nameEn,
    this.startDateTime,
    this.updateTs,
    this.status,
    this.type,
    this.name,
    this.createTs,
    this.link,
    this.entityId,
    this.notificationHeader,
    this.version,
    this.createdBy,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String notificationHeaderKz;
  @HiveField(4)
  String notificationHeaderEn;
  @HiveField(5)
  String notificationBodyKz;
  @HiveField(6)
  String description;
  @HiveField(7)
  String referenceId;
  @HiveField(8)
  String notificationBodyEn;
  @HiveField(9)
  String nameRu;
  @HiveField(10)
  String notificationTemplateCode;
  @HiveField(11)
  String notificationHeaderRu;
  @HiveField(12)
  String nameKz;
  @HiveField(13)
  String notificationBodyRu;
  @HiveField(14)
  String nameEn;
  @HiveField(15)
  DateTime startDateTime;
  @HiveField(16)
  String status;
  @HiveField(17)
  ActivityType type;
  @HiveField(18)
  String name;
  @HiveField(19)
  DateTime createTs;
  @HiveField(20)
  String link;
  @HiveField(21)
  String entityId;
  @HiveField(22)
  DateTime updateTs;
  @HiveField(23)
  String notificationBody;
  @HiveField(25)
  String notificationHeader;
  @HiveField(24)
  int version;
  @HiveField(26)
  String createdBy;

  factory NotificationTemplate.fromJson(String str) => NotificationTemplate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // String get notificationBody {
  //   switch (language) {
  //     case 'ru':
  //       return notificationBodyRu;
  //     case 'en':
  //       return notificationBodyEn;
  //     case 'kk':
  //       return notificationHeaderKz;
  //     default:
  //       return notificationBodyRu;
  //   }
  // }
  //
  String  notificationHeaderLang(language) {
    if(language == 'ru'){
      return notificationHeaderRu;
    }else if(language == 'kz'){
      return notificationHeaderKz;
    }else if(language == 'en'){
      return notificationHeaderEn;
    }else{
     return notificationHeaderRu;
    }
  }

  factory NotificationTemplate.fromMap(Map<String, dynamic> json) => NotificationTemplate(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        notificationHeaderKz: json['notificationHeaderKz'],
        notificationHeaderEn: json['notificationHeaderEn'],
        notificationBodyKz: json['notificationBodyKz'],
        description: json['description'],
        type: json['type'] == null ? null : ActivityType.fromMap(json['type']),
        referenceId: json['referenceId'],
        notificationBodyEn: json['notificationBodyEn'],
        nameRu: json['nameRu'],
        notificationTemplateCode: json['notificationTemplateCode'],
        notificationHeaderRu: json['notificationHeaderRu'],
        nameKz: json['nameKz'],
        notificationBodyRu: json['notificationBodyRu'],
        notificationBody: json['notificationBody'],
        notificationHeader: json['notificationHeader'],
        nameEn: json['nameEn'],
        startDateTime: json['startDateTime'] == null ? null : DateTime.parse(json['startDateTime']),
        updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs']),
        createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs']),
        status: json['status'],
        name: json['name'],
        link: json['link'],
        version: json['version'],
        entityId: json['entityId'],
        createdBy: json['createdBy'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'notificationHeaderKz': notificationHeaderKz,
        'notificationHeaderEn': notificationHeaderEn,
        'notificationBodyKz': notificationBodyKz,
        'description': description,
        'type': type == null ? null : type.toMap(),
        'referenceId': referenceId,
        'notificationBodyEn': notificationBodyEn,
        'nameRu': nameRu,
        // 'createTs': createTs == null ? null : createTs.toIso8601String(),
        'createTs': createTs == null ? null : formatFullRest(createTs),
        'notificationTemplateCode': notificationTemplateCode,
        'notificationHeaderRu': notificationHeaderRu,
        'nameKz': nameKz,
        'notificationBodyRu': notificationBodyRu,
        'notificationBody': notificationBody,
        'nameEn': nameEn,
        'version': version,
        // 'startDateTime': startDateTime == null ? null : startDateTime.toIso8601String(),
        'startDateTime': startDateTime == null ? null : formatFullRest(startDateTime),
        'createdBy': createdBy,
        // 'updateTs': updateTs == null ? null : updateTs.toIso8601String(),
        'updateTs': updateTs == null ? null : formatFullRest(updateTs),
        'notificationHeader': notificationHeader,
        'status': status,
        'name': name,
        'link': link,
        'entityId': entityId,
      }..removeWhere((String key, dynamic value) => value == null);
// };
}

class ActivityType {
  ActivityType({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.screen,
    this.isSystemRecord,
    this.active,
    this.isDefault,
    this.windowProperty,
    this.langValue1,
    this.langValue3,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  String screen;
  bool isSystemRecord;
  bool active;
  bool isDefault;
  WindowProperty windowProperty;
  String langValue1;
  String langValue3;

  factory ActivityType.fromJson(String str) => ActivityType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActivityType.fromMap(Map<String, dynamic> json) => ActivityType(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        screen: json['screen'],
        isSystemRecord: json['isSystemRecord'],
        active: json['active'],
        isDefault: json['isDefault'],
        windowProperty: json['windowProperty'] == null ? null : WindowProperty.fromMap(json['windowProperty']),
        langValue1: json['langValue1'],
        langValue3: json['langValue3'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'screen': screen,
        'isSystemRecord': isSystemRecord,
        'langValue3': langValue3,
        'active': active,
        'isDefault': isDefault,
        'windowProperty': windowProperty == null ? null : windowProperty.toMap(),
        'langValue1': langValue1,
      }..removeWhere((String key, dynamic value) => value == null);
}

class WindowProperty {
  WindowProperty({
    this.entityName,
    this.instanceName,
    this.id,
    this.screenName,
    this.viewName,
    this.windowPropertyEntityName,
  });

  String entityName;
  String instanceName;
  String id;
  String screenName;
  String viewName;
  String windowPropertyEntityName;

  factory WindowProperty.fromJson(String str) => WindowProperty.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WindowProperty.fromMap(Map<String, dynamic> json) => WindowProperty(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        screenName: json['screenName'],
        viewName: json['viewName'],
        windowPropertyEntityName: json['entityName'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'screenName': screenName,
        'viewName': viewName,
        'entityName': windowPropertyEntityName,
      };
}
