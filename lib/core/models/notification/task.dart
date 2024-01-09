// To parse this JSON data, do
//
//     final taskEntity = taskEntityFromMap(jsonString);

import 'dart:convert';

class TaskEntity {
  TaskEntity({
    this.id,
    this.createTs,
    this.code,
    this.name,
    this.link,
    this.entityId,
  });

  String id;
  DateTime createTs;
  String code;
  String name;
  String link;
  String entityId;

  factory TaskEntity.fromJson(String str) => TaskEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskEntity.fromMap(Map<String, dynamic> json) => TaskEntity(
    id: json['id'],
    createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs']),
    code: json['code'],
    name: json['name'],
    link: json['link'],
    entityId: json['entityId'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'createTs': createTs == null ? null : createTs.toIso8601String(),
    'code': code,
    'name': name,
    'link': link,
    'entityId': entityId,
  };
}