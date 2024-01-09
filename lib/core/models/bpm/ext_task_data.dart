// To parse this JSON data, do
//
//     final extTaskData = extTaskDataFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';

class ExtTaskData {
  ExtTaskData({
    this.entityName,
    this.instanceName,
    this.id,
    this.hrRole,
    this.taskDefinitionKey,
    this.createTime,
    this.assigneeOrCandidates,
    this.name,
    this.assignee,
    this.endTime,
    this.outcome,
    this.processInstanceId,
    this.processDefinitionId,
    this.executionId,
    this.comment,
    this.claimTime,
  });

  String entityName;
  String instanceName;
  String id;
  HrRole hrRole;
  String taskDefinitionKey;
  DateTime createTime;
  List<User> assigneeOrCandidates;
  String name;
  String assignee;
  DateTime endTime;
  String outcome;
  String processInstanceId;
  String processDefinitionId;
  String executionId;
  String comment;
  DateTime claimTime;

  factory ExtTaskData.fromJson(String str) => ExtTaskData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExtTaskData.fromMap(Map<String, dynamic> json) => ExtTaskData(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    hrRole: json['hrRole'] == null ? null : HrRole.fromMap(json['hrRole']),
    taskDefinitionKey: json['taskDefinitionKey'],
    createTime: json['createTime'] == null ? null : DateTime.parse(json['createTime']),
    assigneeOrCandidates: json['assigneeOrCandidates'] == null ? null : List<User>.from(json['assigneeOrCandidates'].map((x) => User.fromMap(x))),
    name: json['name'],
    assignee: json['assignee'],
    endTime: json['endTime'] == null ? null : DateTime.parse(json['endTime']),
    outcome: json['outcome'],
    processInstanceId: json['processInstanceId'],
    processDefinitionId: json['processDefinitionId'],
    executionId: json['executionId'],
    comment: json['comment'],
    claimTime: json['claimTime'] == null ? null : DateTime.parse(json['claimTime']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'hrRole': hrRole == null ? null : hrRole.toMap(),
    'taskDefinitionKey': taskDefinitionKey,
    'createTime': createTime == null ? null : formatFullRest(createTime),
    'assigneeOrCandidates': assigneeOrCandidates == null ? null : List<dynamic>.from(assigneeOrCandidates.map((User x) => x.toMap())),
    'name': name,
    'assignee': assignee,
    'endTime': endTime == null ? null : endTime.toIso8601String(),
    'outcome': outcome,
    'processInstanceId': processInstanceId,
    'processDefinitionId': processDefinitionId,
    'executionId': executionId,
    'comment': comment,
    'claimTime': claimTime == null ? null : formatFullRest(claimTime),
  };
}

class Group {
  Group({
    this.entityName,
    this.instanceName,
    this.id,
  });

  String entityName;
  String instanceName;
  String id;

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Group.fromMap(Map<String, dynamic> json) => Group(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
  };
}

