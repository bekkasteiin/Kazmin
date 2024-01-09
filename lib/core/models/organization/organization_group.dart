import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/abstract/group_element.dart';

import 'package:kzm/core/models/organization/organization_group_element.dart';

part 'organization_group.g.dart';

@HiveType(typeId: 6)
class OrganizationGroupExt {
  OrganizationGroupExt({
    this.entityName,
    this.instanceName,
    this.id,
    this.analytics,
    this.updatedBy,
    this.list,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  GroupElement analytics;
  @HiveField(4)
  String updatedBy;
  @HiveField(5)
  List<OrganizationGroupExtElement> list;

  OrganizationGroupExtElement get currentOrganization {
    return list.where((OrganizationGroupExtElement element) {
      final DateTime dateTime = DateTime.now();
      return dateTime.isBefore(element.endDate) &&
          dateTime.isAfter(element.startDate);
    }).first;
  }

  factory OrganizationGroupExt.fromJson(String str) =>
      OrganizationGroupExt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrganizationGroupExt.fromMap(Map<String, dynamic> json) =>
      OrganizationGroupExt(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        analytics: json['analytics'] == null
            ? null
            : GroupElement.fromMap(json['analytics']),
        updatedBy: json['updatedBy'],
        list: json['list'] == null
            ? null
            : List<OrganizationGroupExtElement>.from(json['list']
                .map((x) => OrganizationGroupExtElement.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'analytics': analytics == null ? null : analytics.toMap(),
        'updatedBy': updatedBy,
        'list': list == null
            ? null
            : List<dynamic>.from(list.map((OrganizationGroupExtElement x) => x.toMap())),
      };
}
