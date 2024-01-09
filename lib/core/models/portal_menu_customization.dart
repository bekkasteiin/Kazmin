
// To parse this JSON data, do
//
//     final portalMenuCustomization = portalMenuCustomizationFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

@HiveType(typeId: 13)
class PortalMenuCustomization {
  PortalMenuCustomization({
    this.entityName,
    this.id,
    this.menuItem,
    this.version,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String menuItem;
  @HiveField(3)
  int version;

  factory PortalMenuCustomization.fromJson(String str) => PortalMenuCustomization.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PortalMenuCustomization.fromMap(Map<String, dynamic> json) => PortalMenuCustomization(
    entityName: json['_entityName'],
    id: json['id'],
    menuItem: json['menuItem'],
    version: json['version'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    'id': id,
    'menuItem': menuItem,
    'version': version,
  };
}
