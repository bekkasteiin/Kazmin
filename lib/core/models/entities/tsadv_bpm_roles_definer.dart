/*
"_entityName": "tsadv$BpmRolesDefiner"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_bpm_roles_link.dart';

class TsadvBpmRolesDefiner {
  String entityName;
  String instanceName;
  bool activeSupManagerExclusion;
  String id;
  bool managerLaunches;
  String processDefinitionKey;
  int version;
  List<TsadvBpmRolesLink> links;

  TsadvBpmRolesDefiner({
    this.entityName,
    this.instanceName,
    this.activeSupManagerExclusion,
    this.id,
    this.managerLaunches,
    this.processDefinitionKey,
    this.version,
    this.links,
  });

  factory TsadvBpmRolesDefiner.fromJson(String str) {
    return TsadvBpmRolesDefiner.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvBpmRolesDefiner.fromMap(Map<String, dynamic> json) {
    return TsadvBpmRolesDefiner(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      activeSupManagerExclusion:
          json['activeSupManagerExclusion'] == null ? null : json['activeSupManagerExclusion'] as bool,
      id: json['id']?.toString(),
      managerLaunches: json['managerLaunches'] == null ? null : json['managerLaunches'] as bool,
      processDefinitionKey: json['processDefinitionKey']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
      links: (json['links'] == null)
          ? null
          : (json['links'] as List<dynamic>)
              .map((dynamic i) => TsadvBpmRolesLink.fromMap(i as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'activeSupManagerExclusion': activeSupManagerExclusion,
      'id': id,
      'managerLaunches': managerLaunches,
      'processDefinitionKey': processDefinitionKey,
      'version': version,
      'links': links?.map((TsadvBpmRolesLink e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
