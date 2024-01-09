import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:kzm/core/constants/globals.dart';

part 'abstract_dictionary.g.dart';

const String fName = 'lib/core/models/abstract/abstract_dictionary.dart';

@HiveType(typeId: 0)
class AbstractDictionary {
  AbstractDictionary({
    this.active,
    this.code,
    this.color,
    this.createdBy,
    this.createTs,
    this.customField1,
    this.deletedBy,
    this.deleteTs,
    this.description1,
    this.description2,
    this.description3,
    this.description4,
    this.description5,
    this.endDate,
    this.entityName,
    this.id,
    this.instanceName,
    this.isDefault,
    this.isSystemRecord,
    this.langValue1,
    this.langValue2,
    this.langValue3,
    this.langValue4,
    this.langValue5,
    this.languageValue,
    this.legacyId,
    this.name,
    this.amount,
    this.order,
    this.rate,
    this.startDate,
    this.updatedBy,
    this.updateTs,
    this.version,
    this.absencePurpose,
    this.langValueOrig,
    this.langValueLocale,
    this.closeRelative
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  int version;

  @HiveField(2)
  String entityName;

  @HiveField(3)
  DateTime createTs;

  @HiveField(4)
  String createdBy;

  @HiveField(5)
  DateTime updateTs;

  @HiveField(6)
  String updatedBy;

  @HiveField(7)
  DateTime deleteTs;

  @HiveField(8)
  String deletedBy;

  @HiveField(9)
  String legacyId;

  @HiveField(10)
  String langValue1;

  @HiveField(11)
  String description1;

  @HiveField(12)
  String langValue2;

  @HiveField(13)
  String description2;

  @HiveField(14)
  String langValue3;

  @HiveField(15)
  String description3;

  @HiveField(16)
  String langValue4;

  @HiveField(17)
  String description4;

  @HiveField(18)
  String langValue5;

  @HiveField(19)
  String description5;

  @HiveField(20)
  DateTime startDate;

  @HiveField(21)
  DateTime endDate;

  @HiveField(22)
  String code;

  @HiveField(23)
  bool isSystemRecord;

  @HiveField(24)
  bool active;

  @HiveField(25)
  int order;

  @HiveField(26)
  String name;

  @HiveField(27)
  num rate;

  @HiveField(28)
  String instanceName;

  @HiveField(29)
  String color;

  @HiveField(30)
  String customField1;

  @HiveField(31)
  bool isDefault;

  @HiveField(32)
  String languageValue;

  @HiveField(33)
  String absencePurpose;

  @HiveField(34)
  String langValueOrig;

  @HiveField(35)
  String langValueLocale;

  @HiveField(36)
  bool closeRelative;

  @HiveField(37)
  double amount;

  factory AbstractDictionary.fromJson(String str) => AbstractDictionary.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory AbstractDictionary.fromMap(Map<String, dynamic> json) {
    return AbstractDictionary(
      id: json['id']?.toString(),
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
      createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs'].toString()),
      createdBy: json['createdBy']?.toString(),
      updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs'].toString()),
      updatedBy: json['updatedBy']?.toString(),
      deleteTs: json['deleteTs'] == null ? null : DateTime.parse(json['deleteTs'].toString()),
      deletedBy: json['deletedBy']?.toString(),
      legacyId: json['legacyID']?.toString(),
      langValue1: json['langValue1']?.toString(),
      description1: json['description1']?.toString(),
      langValue2: json['langValue2']?.toString(),
      description2: json['description2']?.toString(),
      langValue3: json['langValue3']?.toString(),
      description3: json['description3']?.toString(),
      langValue4: json['langValue4']?.toString(),
      description4: json['description4']?.toString(),
      langValue5: json['langValue5']?.toString(),
      languageValue: json['languageValue']?.toString(),
      description5: json['description5']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      code: json['code']?.toString(),
      color: json['color']?.toString(),
      isDefault: json['isDefault'] == null ? null : json['isDefault'] as bool,
      closeRelative: json['closeRelative'] == null ? null : json['closeRelative'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      active: json['active'] == null ? null : json['active'] as bool,
      order: json['order'] == null ? null : int.parse(json['order'].toString()),
      name: json['name']?.toString(),
      amount: json['amount'] == null ? 0.0 : double.parse(json['amount'].toString()),
      rate: json['rate'] == null ? null : num.parse(json['rate'].toString()),
      customField1: json['customField1']?.toString(),
      langValueOrig: json['langValue']?.toString(),
      langValueLocale: json['langValue']?.toString() ?? json['langValue${mapLocale()}']?.toString() ?? '',
    );
  }

  String toJSON() {
    return jsonEncode({
      'code': code,
      'color': color,
      'createdBy': createdBy,
      'createTs': createTs.toString(),
      'customField1': customField1,
      'deletedBy': deletedBy,
      'deleteTs': deleteTs.toString(),
      'description1': description1,
      'description2': description2,
      'description3': description3,
      'description4': description4,
      'description5': description5,
      'endDate': endDate.toString(),
      'entityName': entityName,
      'id': id,
      'instanceName': instanceName,
      'isDefault': isDefault,
      'isSystemRecord': isSystemRecord,
      'closeRelative': closeRelative,
      'langValue1': langValue1,
      'langValue2': langValue2,
      'langValue3': langValue3,
      'langValue4': langValue4,
      'langValue5': langValue5,
      'languageValue': languageValue,
      'legacyId': legacyId,
      'name': name,
      'order': order,
      'rate': rate,
      'amount': amount,
      'startDate': startDate.toString(),
      'updatedBy': updatedBy,
      'updateTs': updateTs.toString(),
      'version': version,
      'absencePurpose': absencePurpose,
      'langValueOrig': langValueOrig,
      'langValueLocale': langValueLocale,
    });
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  String get langValue => langValueOrig ?? langValueLocale;
}
