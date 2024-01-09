import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_document_type.dart';
import 'package:kzm/core/models/position/position_group_element.dart';

part 'position_group.g.dart';

@HiveType(typeId: 10)
class PositionGroup {
  PositionGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.organizationGroup,
    this.company,
    this.list,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  List<PositionGroupElement> list;
  @HiveField(4)
  OrganizationGroup organizationGroup;
  @HiveField(5)
  TsadvDicMilitaryDocumentType company;

  PositionGroupElement get currentPosition {
    return list.where((PositionGroupElement element) {
      final DateTime dateTime = DateTime.now();
      return dateTime.isBefore(element.endDate) &&
          dateTime.isAfter(element.startDate);
    }).first;
  }

  factory PositionGroup.fromJson(String str) =>
      PositionGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionGroup.fromMap(Map<String, dynamic> json) => PositionGroup(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        list: json['list'] == null
            ? null
            : List<PositionGroupElement>.from(
                json['list'].map((x) => PositionGroupElement.fromMap(x)),),
      organizationGroup: json["organizationGroup"] == null ? null : OrganizationGroup.fromMap(json["organizationGroup"]),
      company: json["company"] == null ? null : TsadvDicMilitaryDocumentType.fromMap(json["company"]),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'organizationGroup': organizationGroup == null ? null : organizationGroup.toMap(),
        'company': company == null ? null : company.toMap(),
        'id': id,
        'list': list == null
            ? null
            : List<dynamic>.from(list.map((PositionGroupElement x) => x.toMap())),
      };
}
