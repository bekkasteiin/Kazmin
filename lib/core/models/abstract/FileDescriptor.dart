import 'dart:convert';

import 'package:hive/hive.dart';
// import 'package:kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';

part 'FileDescriptor.g.dart';

@HiveType(typeId: 1)
class FileDescriptor {
  FileDescriptor({
    this.entityName,
    this.id,
    this.extension,
    this.name,
    this.createDate,
  }) {
    url = Kinfolk.getFileUrl(id);
  }

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String extension;
  @HiveField(3)
  String name;
  @HiveField(4)
  String url;
  @HiveField(5)
  DateTime createDate;

  factory FileDescriptor.fromJson(String str) => FileDescriptor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileDescriptor.fromMap(Map<String, dynamic> json) => FileDescriptor(
        entityName: json['_entityName'],
        id: json['id'],
        extension: json['extension'],
        name: json['name'],
        createDate: json['createDate'] == null ? null : DateTime.parse(json['createDate']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
      };
}
