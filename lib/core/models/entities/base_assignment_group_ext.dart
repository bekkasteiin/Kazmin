/*
"_entityName": "base$AssignmentGroupExt"
*/

import 'dart:convert';

class BaseAssignmentGroupExt {
  String entityName;
  String instanceName;
  String assignmentNumber;
  String id;

  BaseAssignmentGroupExt({
    this.entityName,
    this.instanceName,
    this.assignmentNumber,
    this.id,
  });

  factory BaseAssignmentGroupExt.fromJson(String str) {
    return BaseAssignmentGroupExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory BaseAssignmentGroupExt.fromMap(Map<String, dynamic> json) {
    return BaseAssignmentGroupExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      assignmentNumber: json['assignmentNumber']?.toString(),
      id: json['id']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'assignmentNumber': assignmentNumber,
      'id': id,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
