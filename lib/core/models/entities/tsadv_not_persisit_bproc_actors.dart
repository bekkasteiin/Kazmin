/*
"_entityName": "tsadv_NotPersisitBprocActors"
 */

import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_bpm_roles_link.dart';
import 'package:kzm/core/models/entities/tsadv_dic_hr_role.dart';
import 'package:kzm/core/models/entities/tsadv_user_ext.dart';

class TsadvNotPersisitBprocActors {
  String entityName;
  String instanceName;
  String bprocUserTaskCode;
  String id;
  bool isEditable;
  bool isSystemRecord;
  int order;
  TsadvDicHrRole hrRole;
  TsadvBpmRolesLink rolesLink;
  List<TsadvUserExt> users;

  TsadvNotPersisitBprocActors({
    this.entityName,
    this.instanceName,
    this.bprocUserTaskCode,
    this.id,
    this.isEditable,
    this.isSystemRecord,
    this.order,
    this.hrRole,
    this.rolesLink,
    this.users,
  });

  factory TsadvNotPersisitBprocActors.fromJson(String str) {
    return TsadvNotPersisitBprocActors.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvNotPersisitBprocActors.fromMap(Map<String, dynamic> json) {
    return TsadvNotPersisitBprocActors(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      bprocUserTaskCode: json['bprocUserTaskCode']?.toString(),
      id: json['id']?.toString(),
      isEditable: json['isEditable'] == null ? null : json['isEditable'] as bool,
      isSystemRecord: json['isSystemRecord'] == null ? null : json['isSystemRecord'] as bool,
      order: json['order'] == null ? null : int.parse(json['order'].toString()),
      hrRole: json['hrRole'] == null ? null : TsadvDicHrRole.fromMap(json['hrRole'] as Map<String, dynamic>),
      rolesLink: json['rolesLink'] == null ? null : TsadvBpmRolesLink.fromMap(json['rolesLink'] as Map<String, dynamic>),
      users: (json['users'] == null) ? null : (json['users'] as List<dynamic>).map((dynamic i) => TsadvUserExt.fromMap(i as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    // log('-->> TsadvNotPersisitBprocActors.toMap -->> hrRole: $hrRole');
    // log('-->> TsadvNotPersisitBprocActors.toMap -->> rolesLink: $rolesLink');
    // log('-->> TsadvNotPersisitBprocActors.toMap -->> users: $users');
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'bprocUserTaskCode': bprocUserTaskCode,
      'id': id,
      'isEditable': isEditable,
      'isSystemRecord': isSystemRecord,
      'order': order,
      'hrRole': hrRole?.toMap(),
      'rolesLink': rolesLink?.toMap(),
      'users': users?.map((TsadvUserExt e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
