
// To parse this JSON data, do
//
//     final processInstanceData = processInstanceDataFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';

class ProcessInstanceData {
  ProcessInstanceData({
    this.entityName,
    this.instanceName,
    this.id,
    this.processDefinitionId,
    this.startUserId,
    this.deploymentId,
    this.businessKey,
    this.processDefinitionName,
    this.startTime,
    this.processDefinitionVersion,
    this.suspended,
    this.processDefinitionKey,
  });

  String entityName;
  String instanceName;
  String id;
  String processDefinitionId;
  String startUserId;
  String deploymentId;
  String businessKey;
  String processDefinitionName;
  DateTime startTime;
  int processDefinitionVersion;
  bool suspended;
  String processDefinitionKey;

  factory ProcessInstanceData.fromJson(String str) => ProcessInstanceData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProcessInstanceData.fromMap(Map<String, dynamic> json) => ProcessInstanceData(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    processDefinitionId: json['processDefinitionId'],
    startUserId: json['startUserId'],
    deploymentId: json['deploymentId'],
    businessKey: json['businessKey'],
    processDefinitionName: json['processDefinitionName'],
    startTime: json['startTime'] == null ? null : DateTime.parse(json['startTime']),
    processDefinitionVersion: json['processDefinitionVersion'],
    suspended: json['suspended'],
    processDefinitionKey: json['processDefinitionKey'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'processDefinitionId': processDefinitionId,
    'startUserId': startUserId,
    'deploymentId': deploymentId,
    'businessKey': businessKey,
    'processDefinitionName': processDefinitionName,
    'startTime': startTime == null ? null : formatFullRest(startTime),
    'processDefinitionVersion': processDefinitionVersion,
    'suspended': suspended,
    'processDefinitionKey': processDefinitionKey,
  };
}
