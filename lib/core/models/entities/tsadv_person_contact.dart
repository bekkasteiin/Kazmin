import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_dic_phone_type.dart';

class TsadvPersonContact {
  String entityName;
  String instanceName;
  String contactValue;
  DateTime endDate;
  String id;
  DateTime startDate;
  TsadvDicPhoneType type;

  TsadvPersonContact({
    this.entityName,
    this.instanceName,
    this.contactValue,
    this.endDate,
    this.id,
    this.startDate,
    this.type,
  });

  static String get entity => 'tsadv\$PersonContact';

  static String get view => 'portal.my-profile';

  static String get property => 'personGroup.id';

  factory TsadvPersonContact.fromJson(String str) {
    return TsadvPersonContact.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPersonContact.fromMap(Map<String, dynamic> json) {
    return TsadvPersonContact(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      contactValue: json['contactValue']?.toString(),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      id: json['id']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      type: json['type'] == null ? null : TsadvDicPhoneType.fromMap(json['type'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'contactValue': contactValue,
      'endDate': formatFullRestNotMilSec(endDate),
      'id': id,
      'startDate': formatFullRestNotMilSec(startDate),
      'type': type?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
