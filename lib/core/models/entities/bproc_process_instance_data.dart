/*
"_entityName":"bproc_ProcessInstanceData"
*/

import 'dart:convert';

class BprocProcessInstanceData {
  String entityName;
  String instanceName;
  String businessKey;
  String deploymentId;
  String id;
  String processDefinitionId;
  String processDefinitionKey;
  String processDefinitionName;
  int processDefinitionVersion;
  String startTime;
  String startUserId;
  bool suspended;

  BprocProcessInstanceData({
    this.entityName,
    this.instanceName,
    this.businessKey,
    this.deploymentId,
    this.id,
    this.processDefinitionId,
    this.processDefinitionKey,
    this.processDefinitionName,
    this.processDefinitionVersion,
    this.startTime,
    this.startUserId,
    this.suspended,
  });

  factory BprocProcessInstanceData.fromJson(String str) =>
      BprocProcessInstanceData.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory BprocProcessInstanceData.fromMap(Map<String, dynamic> json) {
    return BprocProcessInstanceData(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      businessKey: json['businessKey']?.toString(),
      deploymentId: json['deploymentId']?.toString(),
      id: json['id']?.toString(),
      processDefinitionId: json['processDefinitionId']?.toString(),
      processDefinitionKey: json['processDefinitionKey']?.toString(),
      processDefinitionName: json['processDefinitionName']?.toString(),
      processDefinitionVersion:
          json['processDefinitionVersion'] == null ? null : int.parse(json['processDefinitionVersion'].toString()),
      startTime: json['startTime']?.toString(),
      startUserId: json['startUserId']?.toString(),
      suspended: json['suspended'] == null ? null : json['suspended'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'businessKey': businessKey,
      'deploymentId': deploymentId,
      'id': id,
      'processDefinitionId': processDefinitionId,
      'processDefinitionKey': processDefinitionKey,
      'processDefinitionName': processDefinitionName,
      'processDefinitionVersion': processDefinitionVersion,
      'startTime': startTime,
      'startUserId': startUserId,
      'suspended': suspended,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
