/*
"_entityName": "sys$FileDescriptor"
*/

import 'dart:convert';

import 'dart:io';

class SysFileDescriptor {
  String entityName;
  String instanceName;
  String createDate;
  String extension;
  String id;
  String name;
  File file;

  SysFileDescriptor({
    this.entityName,
    this.instanceName,
    this.createDate,
    this.extension,
    this.id,
    this.name,
    this.file,
  });

  factory SysFileDescriptor.fromJson(String str) => SysFileDescriptor.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory SysFileDescriptor.fromMap(Map<String, dynamic> json) {
    return SysFileDescriptor(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      createDate: json['createDate']?.toString(),
      extension: json['extension']?.toString(),
      id: json['id']?.toString(),
      name: json['name']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'extension': extension,
      'name': name,
      'createDate': createDate
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
