import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/position/job_group.dart';

part 'organization_group_element.g.dart';

@HiveType(typeId: 7)
class OrganizationGroupExtElement {
  OrganizationGroupExtElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.internal,
    this.endDate,
    this.organizationNameLang1,
    this.organizationNameLang2,
    this.organizationNameLang3,
    this.group,
    this.updatedBy,
    this.startDate,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  bool internal;
  @HiveField(4)
  DateTime endDate;
  @HiveField(5)
  String organizationNameLang1;
  @HiveField(6)
  String organizationNameLang2;
  @HiveField(7)
  String organizationNameLang3;
  @HiveField(8)
  JobGroup group;
  @HiveField(9)
  String updatedBy;
  @HiveField(10)
  DateTime startDate;

  factory OrganizationGroupExtElement.fromJson(String str) =>
      OrganizationGroupExtElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrganizationGroupExtElement.fromMap(Map<String, dynamic> json) =>
      OrganizationGroupExtElement(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        internal: json['internal'],
        endDate:
            json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        organizationNameLang1: json['organizationNameLang1'],
        organizationNameLang2: json['organizationNameLang2'],
        organizationNameLang3: json['organizationNameLang3'],
        group: json['group'] == null ? null : JobGroup.fromMap(json['group']),
        updatedBy: json['updatedBy'],
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'internal': internal,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'organizationNameLang1':
            organizationNameLang1,
        'organizationNameLang2':
            organizationNameLang2,
        'organizationNameLang3':
            organizationNameLang3,
        'group': group == null ? null : group.toMap(),
        'updatedBy': updatedBy,
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}
