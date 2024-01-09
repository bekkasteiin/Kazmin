// To parse this JSON data, do
//
//     final bpmRolesDefiner = bpmRolesDefinerFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/absence_for_recall.dart';
import 'package:kzm/core/models/absence/change_days_request.dart';
import 'package:kzm/core/models/absence/leaving_vacation.dart';
import 'package:kzm/core/models/certificate/certificate.dart';
import 'package:kzm/core/models/rvd/absence_rvd_request.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';

class BpmRolesDefiner {
  BpmRolesDefiner({
    this.entityName,
    this.instanceName,
    this.id,
    this.links,
    this.version,
    this.removeAutoRedirect,
    this.processDefinitionKey,
    this.activeSupManagerExclusion,
    this.managerLaunches,
  });

  String entityName;
  String instanceName;
  String id;
  bool managerLaunches;
  bool removeAutoRedirect = false;
  bool activeSupManagerExclusion;
  List<Link> links;
  int version;
  String processDefinitionKey;

  factory BpmRolesDefiner.fromJson(String str) => BpmRolesDefiner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BpmRolesDefiner.fromMap(Map<String, dynamic> json) => BpmRolesDefiner(
        entityName: json['_entityName'],
        managerLaunches: json['managerLaunches'],
        removeAutoRedirect: json['removeAutoRedirect'],
        activeSupManagerExclusion: json['activeSupManagerExclusion'],
        instanceName: json['_instanceName'],
        id: json['id'],
        links: json['links'] == null ? null : List<Link>.from(json['links'].map((x) => Link.fromMap(x))),
        version: json['version'],
        processDefinitionKey: json['processDefinitionKey'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'activeSupManagerExclusion': activeSupManagerExclusion,
        'managerLaunches': managerLaunches,
        'id': id,
        'links': links == null ? null : List<dynamic>.from(links.map((Link x) => x.toMap())),
        'version': version,
        'removeAutoRedirect': removeAutoRedirect,
        'processDefinitionKey': processDefinitionKey,
      }..removeWhere((String key, value) => value == null);
}

class Link {
  Link(
      {this.entityName,
      this.instanceName,
      this.id,
      this.hrRole,
      this.findByCounter,
      this.isAddableApprover,
      this.bpmRolesDefiner,
      this.version,
      this.required,
      this.bprocUserTaskCode,
      this.order,
      this.forAssistant,});

  String entityName;
  String instanceName;
  String id;
  HrRole hrRole;
  bool findByCounter;
  bool isAddableApprover;
  BpmRolesDefinerClass bpmRolesDefiner;
  int version;
  bool required;
  String bprocUserTaskCode;
  int order;
  bool forAssistant;

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        hrRole: json['hrRole'] == null ? null : HrRole.fromMap(json['hrRole']),
        findByCounter: json['findByCounter'],
        isAddableApprover: json['isAddableApprover'],
        bpmRolesDefiner: json['bpmRolesDefiner'] == null ? null : BpmRolesDefinerClass.fromMap(json['bpmRolesDefiner']),
        version: json['version'],
        required: json['required'],
        bprocUserTaskCode: json['bprocUserTaskCode'],
        order: json['order'],
        forAssistant: json['forAssistant'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'hrRole': hrRole == null ? null : hrRole.toMap(),
        'findByCounter': findByCounter,
        'isAddableApprover': isAddableApprover,
        'bpmRolesDefiner': bpmRolesDefiner == null ? null : bpmRolesDefiner.toMap(),
        'version': version,
        'required': required,
        'bprocUserTaskCode': bprocUserTaskCode,
        'order': order,
        'forAssistant': forAssistant,
      };
}

class BpmRolesDefinerClass {
  BpmRolesDefinerClass({
    this.entityName,
    this.instanceName,
    this.id,
  });

  String entityName;
  String instanceName;
  String id;

  factory BpmRolesDefinerClass.fromJson(String str) => BpmRolesDefinerClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BpmRolesDefinerClass.fromMap(Map<String, dynamic> json) => BpmRolesDefinerClass(
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

class HrRole {
  HrRole({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.order,
    this.isSystemRecord,
    this.langValue3,
    this.langValue,
    this.active,
    this.version,
    this.isDefault,
    this.langValue2,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  int order;
  bool isSystemRecord;
  String langValue3;
  String langValue;
  bool active;
  int version;
  bool isDefault;
  String langValue2;
  String langValue1;

  factory HrRole.fromJson(String str) => HrRole.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HrRole.fromMap(Map<String, dynamic> json) => HrRole(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        order: json['order'],
        isSystemRecord: json['isSystemRecord'],
        langValue3: json['langValue3'],
        langValue: json['langValue'],
        active: json['active'],
        version: json['version'],
        isDefault: json['isDefault'],
        langValue2: json['langValue2'],
        langValue1: json['langValue1'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'order': order,
        'isSystemRecord': isSystemRecord,
        'langValue3': langValue3,
        'langValue': langValue,
        'active': active,
        'version': version,
        'isDefault': isDefault,
        'langValue2': langValue2,
        'langValue1': langValue1,
      };
}

class StartProcessInstance {
  StartProcessInstance({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  Variables variables;

  factory StartProcessInstance.fromJson(String str) => StartProcessInstance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartProcessInstance.fromMap(Map<String, dynamic> json) => StartProcessInstance(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : Variables.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class Variables {
  Variables({
    this.entity,
    this.rolesLinks,
    this.employeePersonGroupId,
    this.isAssistant
  });

  dynamic entity;
  List<Link> rolesLinks;
  String employeePersonGroupId;
  bool isAssistant;

  factory Variables.fromJson(String str) => Variables.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variables.fromMap(Map<String, dynamic> json) => Variables(
        entity: json['entity'] == null ? null : AbsenceRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
        employeePersonGroupId: json['employeePersonGroupId'],
        isAssistant: json['isAssistant'],
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
        'employeePersonGroupId': employeePersonGroupId,
        'isAssistant': isAssistant
      };
}

class VariablesLeavingVacation {
  VariablesLeavingVacation({
    this.entity,
    this.rolesLinks,
  });

  LeavingVacationRequest entity;
  List<Link> rolesLinks;

  factory VariablesLeavingVacation.fromJson(String str) => VariablesLeavingVacation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesLeavingVacation.fromMap(Map<String, dynamic> json) => VariablesLeavingVacation(
        entity: json['entity'] == null ? null : LeavingVacationRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}

class VariablesForAbsenceForRecall {
  VariablesForAbsenceForRecall({
    this.entity,
    this.rolesLinks,
  });

  AbsenceForRecall entity;
  List<Link> rolesLinks;

  factory VariablesForAbsenceForRecall.fromJson(String str) => VariablesForAbsenceForRecall.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesForAbsenceForRecall.fromMap(Map<String, dynamic> json) => VariablesForAbsenceForRecall(
        entity: json['entity'] == null ? null : AbsenceForRecall.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}

class VariablesForChangeDaysAbsence {
  VariablesForChangeDaysAbsence({
    this.entity,
    this.rolesLinks,
  });

  ChangeAbsenceDaysRequest entity;
  List<Link> rolesLinks;

  factory VariablesForChangeDaysAbsence.fromJson(String str) => VariablesForChangeDaysAbsence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesForChangeDaysAbsence.fromMap(Map<String, dynamic> json) => VariablesForChangeDaysAbsence(
        entity: json['entity'] == null ? null : ChangeAbsenceDaysRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}

class VariablesForAbsenceSchedule {
  VariablesForAbsenceSchedule({
    this.entity,
    this.rolesLinks,
  });

  ScheduleOffsetsRequest entity;
  List<Link> rolesLinks;

  factory VariablesForAbsenceSchedule.fromJson(String str) => VariablesForAbsenceSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesForAbsenceSchedule.fromMap(Map<String, dynamic> json) => VariablesForAbsenceSchedule(
        entity: json['entity'] == null ? null : ScheduleOffsetsRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}

class VariablesForRvdAbsenceRequest {
  VariablesForRvdAbsenceRequest({
    this.entity,
    this.rolesLinks,
  });

  AbsenceRvdRequest entity;
  List<Link> rolesLinks;

  factory VariablesForRvdAbsenceRequest.fromJson(String str) => VariablesForRvdAbsenceRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesForRvdAbsenceRequest.fromMap(Map<String, dynamic> json) => VariablesForRvdAbsenceRequest(
        entity: json['entity'] == null ? null : AbsenceRvdRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}

class VariablesCertificate {
  VariablesCertificate({
    this.entity,
    this.rolesLinks,
  });

  CertificateRequest entity;
  List<Link> rolesLinks;

  factory VariablesCertificate.fromJson(String str) => VariablesCertificate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariablesCertificate.fromMap(Map<String, dynamic> json) => VariablesCertificate(
        entity: json['entity'] == null ? null : CertificateRequest.fromMap(json['entity']),
        rolesLinks: json['rolesLinks'] == null ? null : List<Link>.from(json['rolesLinks'].map((x) => Link.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'entity': entity == null ? null : entity.toMap(),
        'rolesLinks': rolesLinks == null ? null : List<dynamic>.from(rolesLinks.map((Link x) => x.toMap())),
      };
}
