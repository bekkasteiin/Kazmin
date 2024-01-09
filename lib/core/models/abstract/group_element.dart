import 'dart:convert';

import 'package:hive/hive.dart';
part 'group_element.g.dart';

@HiveType(typeId: 2)
class GroupElement {
  GroupElement({
    this.entityName,
    this.instanceName,
    this.id,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;

  factory GroupElement.fromJson(String str) =>
      GroupElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupElement.fromMap(Map<String, dynamic> json) => GroupElement(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
      };
}
