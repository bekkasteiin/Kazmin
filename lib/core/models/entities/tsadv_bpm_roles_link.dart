/*
"_entityName": "tsadv$BpmRolesLink"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_bpm_roles_definer.dart';
import 'package:kzm/core/models/entities/tsadv_dic_hr_role.dart';

class TsadvBpmRolesLink {
  String entityName;
  String instanceName;
  String bprocUserTaskCode;
  bool findByCounter;
  bool forAssistant;
  String id;
  bool isAddableApprover;
  int order;
  bool required;
  int version;
  TsadvDicHrRole hrRole;
  TsadvBpmRolesDefiner bpmRolesDefiner;

  TsadvBpmRolesLink({
    this.entityName,
    this.instanceName,
    this.bprocUserTaskCode,
    this.findByCounter,
    this.forAssistant,
    this.id,
    this.isAddableApprover,
    this.order,
    this.required,
    this.version,
    this.hrRole,
    this.bpmRolesDefiner,
  });

  factory TsadvBpmRolesLink.fromJson(String str) {
    return TsadvBpmRolesLink.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvBpmRolesLink.fromMap(Map<String, dynamic> json) {
    return TsadvBpmRolesLink(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      bprocUserTaskCode: json['bprocUserTaskCode']?.toString(),
      findByCounter: json['findByCounter'] == null ? null : json['findByCounter'] as bool,
      forAssistant: json['forAssistant'] == null ? null : json['forAssistant'] as bool,
      id: json['id']?.toString(),
      isAddableApprover: json['isAddableApprover'] == null ? null : json['isAddableApprover'] as bool,
      order: json['order'] == null ? null : int.parse(json['order'].toString()),
      required: json['required'] == null ? null : json['required'] as bool,
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
      hrRole: json['hrRole'] == null ? null : TsadvDicHrRole.fromMap(json['hrRole'] as Map<String, dynamic>),
      bpmRolesDefiner: json['bpmRolesDefiner'] == null
          ? null
          : TsadvBpmRolesDefiner.fromMap(json['bpmRolesDefiner'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'bprocUserTaskCode': bprocUserTaskCode,
      'findByCounter': findByCounter,
      'forAssistant': forAssistant,
      'id': id,
      'isAddableApprover': isAddableApprover,
      'order': order,
      'required': required,
      'version': version,
      'hrRole': hrRole?.toMap(),
      'bpmRolesDefiner': bpmRolesDefiner?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
