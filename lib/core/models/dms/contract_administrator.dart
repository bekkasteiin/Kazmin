import 'dart:convert';

import 'package:kzm/core/models/assignment/assignment.dart';

class ContractAdministrator {
  ContractAdministrator({
    this.entityName,
    this.instanceName,
    this.id,
    this.notifyAboutNewAttachments,
    this.employee,
  });

  String entityName;
  String instanceName;
  String id;
  bool notifyAboutNewAttachments;
  PersonGroup employee;

  factory ContractAdministrator.fromJson(String str) => ContractAdministrator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractAdministrator.fromMap(Map<String, dynamic> json) => ContractAdministrator(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    notifyAboutNewAttachments: json['notifyAboutNewAttachments'],
    employee: json['employee'] == null ? null : PersonGroup.fromMap(json['employee']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'notifyAboutNewAttachments': notifyAboutNewAttachments,
    'employee': employee == null ? null : employee.toMap(),
  };
}
