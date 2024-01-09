/*
"_entityName":"tsadv_ExtTaskData"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_dic_hr_role.dart';
import 'package:kzm/core/models/entities/tsadv_user_ext.dart';

class TsadvExtTaskData {
  String entityName;
  String instanceName;
  String assignee;
  String createTime;
  String endTime;
  String id;
  String name;
  String outcome;
  String taskDefinitionKey;
  String comment;
  String executionId;
  String processDefinitionId;
  String processInstanceId;
  TsadvDicHrRole hrRole;
  List<TsadvUserExt> assigneeOrCandidates;

  TsadvExtTaskData({
    this.entityName,
    this.instanceName,
    this.assignee,
    this.createTime,
    this.endTime,
    this.id,
    this.name,
    this.outcome,
    this.taskDefinitionKey,
    this.comment,
    this.executionId,
    this.processDefinitionId,
    this.processInstanceId,
    this.hrRole,
    this.assigneeOrCandidates,
  });

  factory TsadvExtTaskData.fromJson(String str) {
    return TsadvExtTaskData.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvExtTaskData.fromMap(Map<String, dynamic> json) {
    return TsadvExtTaskData(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      assignee: json['assignee']?.toString(),
      createTime: json['createTime']?.toString(),
      endTime: json['endTime']?.toString(),
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      outcome: json['outcome']?.toString(),
      taskDefinitionKey: json['taskDefinitionKey']?.toString(),
      comment: json['comment']?.toString(),
      executionId: json['executionId']?.toString(),
      processDefinitionId: json['processDefinitionId']?.toString(),
      processInstanceId: json['processInstanceId']?.toString(),
      hrRole: json['hrRole'] == null ? null : TsadvDicHrRole.fromMap(json['hrRole'] as Map<String, dynamic>),
      assigneeOrCandidates: (json['assigneeOrCandidates'] == null)
          ? null
          : (json['assigneeOrCandidates'] as List<dynamic>)
              .map((dynamic i) => TsadvUserExt.fromMap(i as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'assignee': assignee,
      'createTime': createTime,
      'endTime': endTime,
      'id': id,
      'name': name,
      'outcome': outcome,
      'taskDefinitionKey': taskDefinitionKey,
      'comment': comment,
      'executionId': executionId,
      'processDefinitionId': processDefinitionId,
      'processInstanceId': processInstanceId,
      'hrRole': hrRole?.toMap(),
      'assigneeOrCandidates': assigneeOrCandidates?.map((TsadvUserExt e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
