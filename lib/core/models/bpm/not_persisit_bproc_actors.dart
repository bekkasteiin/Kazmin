// To parse this JSON data, do
//
//     final notPersisitBprocActors = notPersisitBprocActorsFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/assignment/assignment.dart';

import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';

class NotPersisitBprocActors {
  NotPersisitBprocActors(
      {this.entityName,
      this.instanceName,
      this.id,
      this.isSystemRecord,
      this.isEditable,
      this.hrRole,
      this.bprocUserTaskCode,
      this.users,
      this.order,
      this.rolesLink,});

  String entityName;
  String instanceName;
  String id;
  bool isSystemRecord;
  bool isEditable;
  HrRole hrRole;
  String bprocUserTaskCode;
  List<User> users;
  int order;
  Link rolesLink;

  factory NotPersisitBprocActors.fromJson(String str) => NotPersisitBprocActors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotPersisitBprocActors.fromMap(Map<String, dynamic> json) => NotPersisitBprocActors(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        isSystemRecord: json['isSystemRecord'],
        isEditable: json['isEditable'],
        hrRole: json['hrRole'] == null ? null : HrRole.fromMap(json['hrRole']),
        rolesLink: json['rolesLink'] == null ? null : Link.fromMap(json['rolesLink']),
        bprocUserTaskCode: json['bprocUserTaskCode'],
        users: json['users'] == null ? null : List<User>.from(json['users'].map((x) => User.fromMap(x))),
        order: json['order'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'isSystemRecord': isSystemRecord,
        'isEditable': isEditable,
        'hrRole': hrRole == null ? null : hrRole.toMap(),
        'bprocUserTaskCode': bprocUserTaskCode,
        'users': users == null ? null : List<dynamic>.from(users.map((User x) => x.toMapForPersisit())),
        'order': order,
        'rolesLink': rolesLink == null ? null : rolesLink.toMap()
      }..removeWhere((String key, dynamic value) => value == null);
}

class User {
  User({
    this.entityName,
    this.instanceName,
    this.id,
    this.loginLowerCase,
    this.language,
    this.availability,
    this.login,
    this.password,
    this.changePasswordAtNextLogon,
    this.passwordChangeDate,
    this.personGroup,
    this.active,
    this.fullName,
    this.version,
    this.fullNameWithLogin,
    this.passwordEncryption,
    this.shortName,
    this.lastName,
    this.email,
    this.name,
    this.firstName,
    this.middleName,
  });

  String entityName;
  String instanceName;
  String id;
  String loginLowerCase;
  String language;
  bool availability;
  String login;
  String password;
  bool changePasswordAtNextLogon;
  DateTime passwordChangeDate;
  PersonGroup personGroup;
  bool active;
  String fullName;
  int version;
  String fullNameWithLogin;
  String passwordEncryption;
  String shortName;
  String lastName;
  String email;
  String firstName;
  String name;
  String middleName;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  String toJsonForRecallAbsence() => json.encode(toMapForRecallAbsence());

  factory User.fromMap(Map<String, dynamic> json) => User(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        loginLowerCase: json['loginLowerCase'],
        language: json['language'],
        availability: json['availability'],
        login: json['login'],
        password: json['password'],
        changePasswordAtNextLogon: json['changePasswordAtNextLogon'],
        passwordChangeDate: json['passwordChangeDate'] == null ? null : DateTime.parse(json['passwordChangeDate']),
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        active: json['active'],
        fullName: json['fullName'],
        version: json['version'],
        fullNameWithLogin: json['fullNameWithLogin'],
        passwordEncryption: json['passwordEncryption'],
        shortName: json['shortName'],
        lastName: json['lastName'],
        email: json['email'],
        firstName: json['firstName'],
        name: json['name'],
        middleName: json['middleName'],
      );

  Map<String, dynamic> toMapForRecallAbsence() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'lastName': shortName,
        'loginLowerCase': loginLowerCase,
        'language': language,
        'availability': availability,
        'login': login,
        'password': password,
        'changePasswordAtNextLogon': changePasswordAtNextLogon,
        'email': shortName,
        'passwordChangeDate': passwordChangeDate == null
            ? null
            : "${passwordChangeDate.year.toString().padLeft(4, '0')}-${passwordChangeDate.month.toString().padLeft(2, '0')}-${passwordChangeDate.day.toString().padLeft(2, '0')}",
        'active': active,
        'fullName': fullName,
        'firstName': shortName,
        'version': version,
        'passwordEncryption': passwordEncryption,
        'name': shortName,
        'middleName': shortName,
        'shortName': shortName,
      };

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'loginLowerCase': loginLowerCase,
        'language': language,
        'availability': availability,
        'login': login,
        'password': password,
        'changePasswordAtNextLogon': changePasswordAtNextLogon,
        'passwordChangeDate': passwordChangeDate == null
            ? null
            : "${passwordChangeDate.year.toString().padLeft(4, '0')}-${passwordChangeDate.month.toString().padLeft(2, '0')}-${passwordChangeDate.day.toString().padLeft(2, '0')}",
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'active': active,
        'fullName': fullName,
        'version': version,
        'fullNameWithLogin': fullNameWithLogin,
        'passwordEncryption': passwordEncryption,
        'shortName': shortName,
        'lastName': shortName,
        'email': shortName,
        'firstName': shortName,
        'name': shortName,
        'middleName': shortName,
      };

  Map<String, dynamic> toMapForPersisit() => {'id': id, 'fullNameWithLogin': fullNameWithLogin};
}

class SaveBprocActors {
  SaveBprocActors({
    this.notPersisitBprocActors,
    this.entityId,
  });

  List<NotPersisitBprocActors> notPersisitBprocActors;
  var entityId;

  factory SaveBprocActors.fromJson(String str) => SaveBprocActors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaveBprocActors.fromMap(Map<String, dynamic> json) => SaveBprocActors(
        notPersisitBprocActors: json['notPersisitBprocActors'] == null
            ? null
            : List<NotPersisitBprocActors>.from(json['notPersisitBprocActors'].map((x) => NotPersisitBprocActors.fromMap(x))),
        entityId: json['entityId'],
      );

  Map<String, dynamic> toMap() => {
        'notPersisitBprocActors': notPersisitBprocActors == null ? null : List<dynamic>.from(notPersisitBprocActors.map((NotPersisitBprocActors x) => x.toMap())),
        'entityId': entityId,
      };
}

class BprocRuntimeService {
  BprocRuntimeService({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  Variables variables;

  factory BprocRuntimeService.fromJson(String str) => BprocRuntimeService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeService.fromMap(Map<String, dynamic> json) => BprocRuntimeService(
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

class BprocRuntimeLeavingVacationService {
  BprocRuntimeLeavingVacationService({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesLeavingVacation variables;

  factory BprocRuntimeLeavingVacationService.fromJson(String str) => BprocRuntimeLeavingVacationService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeLeavingVacationService.fromMap(Map<String, dynamic> json) => BprocRuntimeLeavingVacationService(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesLeavingVacation.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class BprocRuntimeServiceForRecall {
  BprocRuntimeServiceForRecall({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesForAbsenceForRecall variables;

  factory BprocRuntimeServiceForRecall.fromJson(String str) => BprocRuntimeServiceForRecall.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeServiceForRecall.fromMap(Map<String, dynamic> json) => BprocRuntimeServiceForRecall(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesForAbsenceForRecall.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class BprocRuntimeServiceForChangeDays {
  BprocRuntimeServiceForChangeDays({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesForChangeDaysAbsence variables;

  factory BprocRuntimeServiceForChangeDays.fromJson(String str) => BprocRuntimeServiceForChangeDays.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeServiceForChangeDays.fromMap(Map<String, dynamic> json) => BprocRuntimeServiceForChangeDays(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesForChangeDaysAbsence.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class BprocRuntimeServiceSchedule {
  BprocRuntimeServiceSchedule({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesForAbsenceSchedule variables;

  factory BprocRuntimeServiceSchedule.fromJson(String str) => BprocRuntimeServiceSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeServiceSchedule.fromMap(Map<String, dynamic> json) => BprocRuntimeServiceSchedule(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesForAbsenceSchedule.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class BprocRuntimeServiceRvdAbsenceRequest {
  BprocRuntimeServiceRvdAbsenceRequest({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesForRvdAbsenceRequest variables;

  factory BprocRuntimeServiceRvdAbsenceRequest.fromJson(String str) => BprocRuntimeServiceRvdAbsenceRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeServiceRvdAbsenceRequest.fromMap(Map<String, dynamic> json) => BprocRuntimeServiceRvdAbsenceRequest(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesForRvdAbsenceRequest.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}

class BprocRuntimeServiceCertificate {
  BprocRuntimeServiceCertificate({
    this.processDefinitionKey,
    this.businessKey,
    this.variables,
  });

  String processDefinitionKey;
  String businessKey;
  VariablesCertificate variables;

  factory BprocRuntimeServiceCertificate.fromJson(String str) => BprocRuntimeServiceCertificate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BprocRuntimeServiceCertificate.fromMap(Map<String, dynamic> json) => BprocRuntimeServiceCertificate(
        processDefinitionKey: json['processDefinitionKey'],
        businessKey: json['businessKey'],
        variables: json['variables'] == null ? null : VariablesCertificate.fromMap(json['variables']),
      );

  Map<String, dynamic> toMap() => {
        'processDefinitionKey': processDefinitionKey,
        'businessKey': businessKey,
        'variables': variables == null ? null : variables.toMap(),
      };
}
