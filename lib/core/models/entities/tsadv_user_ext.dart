/*
"_entityName": "tsadv$UserExt"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/base_person_group_ext.dart';

class TsadvUserExt {
  String entityName;
  String instanceName;
  bool active;
  bool activeDirectoryUser;
  bool availability;
  bool changePasswordAtNextLogon;
  String firstName;
  String fullName;
  String fullNameWithLogin;
  String id;
  String language;
  String lastName;
  String login;
  String loginLowerCase;
  String middleName;
  String name;
  String password;
  String passwordChangeDate;
  String passwordEncryption;
  String position;
  String shortName;
  String email;
  int version;
  BasePersonGroupExt personGroup;

  TsadvUserExt({
    this.entityName,
    this.instanceName,
    this.active,
    this.activeDirectoryUser,
    this.availability,
    this.changePasswordAtNextLogon,
    this.firstName,
    this.fullName,
    this.fullNameWithLogin,
    this.id,
    this.language,
    this.lastName,
    this.login,
    this.loginLowerCase,
    this.middleName,
    this.name,
    this.password,
    this.passwordChangeDate,
    this.passwordEncryption,
    this.position,
    this.shortName,
    this.version,
    this.email,
    this.personGroup,
  });

  factory TsadvUserExt.fromJson(String str) {
    return TsadvUserExt.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvUserExt.fromMap(Map<String, dynamic> json) {
    return TsadvUserExt(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      activeDirectoryUser: json['activeDirectoryUser'] == null ? null : json['activeDirectoryUser'] as bool,
      availability: json['availability'] == null ? null : json['availability'] as bool,
      changePasswordAtNextLogon:
          json['changePasswordAtNextLogon'] == null ? null : json['changePasswordAtNextLogon'] as bool,
      firstName: json['firstName']?.toString(),
      fullName: json['fullName']?.toString(),
      fullNameWithLogin: json['fullNameWithLogin']?.toString(),
      id: json['id']?.toString(),
      language: json['language']?.toString(),
      lastName: json['lastName']?.toString(),
      login: json['login']?.toString(),
      loginLowerCase: json['loginLowerCase']?.toString(),
      middleName: json['middleName']?.toString(),
      name: json['name']?.toString(),
      password: json['password']?.toString(),
      passwordChangeDate: json['passwordChangeDate']?.toString(),
      passwordEncryption: json['passwordEncryption']?.toString(),
      position: json['position']?.toString(),
      shortName: json['shortName']?.toString(),
      email: json['email']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
      personGroup:
          json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'activeDirectoryUser': activeDirectoryUser,
      'availability': availability,
      'changePasswordAtNextLogon': changePasswordAtNextLogon,
      'firstName': firstName,
      'fullName': fullName,
      'fullNameWithLogin': fullNameWithLogin,
      'id': id,
      'language': language,
      'lastName': lastName,
      'login': login,
      'loginLowerCase': loginLowerCase,
      'middleName': middleName,
      'name': name,
      'password': password,
      'passwordChangeDate': passwordChangeDate,
      'passwordEncryption': passwordEncryption,
      'position': position,
      'shortName': shortName,
      'version': version,
      'email': email,
      'personGroup': personGroup?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
