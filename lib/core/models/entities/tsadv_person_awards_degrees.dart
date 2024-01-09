import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kind_of_award.dart';
import 'package:kzm/core/models/entities/tsadv_dic_promotion_type.dart';

class TsadvPersonAwardsDegrees {
  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  TsadvDicKindOfAward kind;
  String description;
  TsadvDicPromotionType type;
  BasePersonGroupExt employee;
  DateTime startDate;

  TsadvPersonAwardsDegrees({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.kind,
    this.description,
    this.type,
    this.employee,
    this.startDate,
  });

  static String get entity => 'tsadv_PersonAwardsDegrees';

  static String get view => 'personAwardsDegrees.edit';

  static String get property => 'employee.id';

  factory TsadvPersonAwardsDegrees.fromJson(String str) {
    return TsadvPersonAwardsDegrees.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPersonAwardsDegrees.fromMap(Map<String, dynamic> json) {
    return TsadvPersonAwardsDegrees(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      kind: json['kind'] == null ? null : TsadvDicKindOfAward.fromMap(json['kind'] as Map<String, dynamic>),
      description: json['description']?.toString(),
      type: json['type'] == null ? null : TsadvDicPromotionType.fromMap(json['type'] as Map<String, dynamic>),
      employee: json['employee'] == null ? null : BasePersonGroupExt.fromMap(json['employee'] as Map<String, dynamic>),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'endDate': formatFullRestNotMilSec(endDate),
      'kind': kind?.toMap(),
      'description': description,
      'type': type?.toMap(),
      'employee': employee?.toMap(),
      'startDate': formatFullRestNotMilSec(startDate),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
