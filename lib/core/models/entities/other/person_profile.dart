import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/other/manager_list.dart';

class PersonProfile {
  String assignmentGroupId;
  DateTime birthDate;
  String citizenship;
  String cityOfResidence;
  String companyCode;
  String firstLastName;
  String fullName;
  String groupId;
  DateTime hireDate;
  String id;
  String imageId;
  List<ManagerList> managerList;
  String nationality;
  String organizationGroupId;
  String organizationName;
  String positionGroupId;
  String positionId;
  String positionName;
  String sex;
  BasePersonExt ext;
  AbstractDictionary maritalStatus;

  PersonProfile({
    this.assignmentGroupId,
    this.birthDate,
    this.citizenship,
    this.cityOfResidence,
    this.companyCode,
    this.firstLastName,
    this.fullName,
    this.groupId,
    this.hireDate,
    this.id,
    this.imageId,
    this.managerList,
    this.nationality,
    this.organizationGroupId,
    this.organizationName,
    this.positionGroupId,
    this.positionId,
    this.positionName,
    this.sex,
    this.maritalStatus,
  });

  factory PersonProfile.fromJson(String str) {
    return PersonProfile.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory PersonProfile.fromMap(Map<String, dynamic> json) {
    return PersonProfile(
      assignmentGroupId: json['assignmentGroupId']?.toString(),
      birthDate: json['birthDate'] == null ? null : DateTime.parse(json['birthDate'].toString()),
      citizenship: json['citizenship']?.toString(),
      cityOfResidence: json['cityOfResidence']?.toString(),
      companyCode: json['companyCode']?.toString(),
      firstLastName: json['firstLastName']?.toString(),
      fullName: json['fullName']?.toString(),
      groupId: json['groupId']?.toString(),
      hireDate: json['hireDate'] == null ? null : DateTime.parse(json['hireDate'].toString()),
      id: json['id']?.toString(),
      imageId: json['imageId']?.toString(),
      managerList: (json['managerList'] == null)
          ? null
          : (json['managerList'] as List<dynamic>).map((dynamic i) => ManagerList.fromMap(i as Map<String, dynamic>)).toList(),
      nationality: json['nationality']?.toString(),
      organizationGroupId: json['organizationGroupId']?.toString(),
      organizationName: json['organizationName']?.toString(),
      positionGroupId: json['positionGroupId']?.toString(),
      positionId: json['positionId']?.toString(),
      positionName: json['positionName']?.toString(),
      sex: json['sex']?.toString(),
      maritalStatus: json['maritalStatus'] == null ? null: AbstractDictionary.fromMap(json['maritalStatus'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'assignmentGroupId': assignmentGroupId,
      'birthDate': formatFullRestNotMilSec(birthDate),
      'citizenship': citizenship,
      'cityOfResidence': cityOfResidence,
      'companyCode': companyCode,
      'firstLastName': firstLastName,
      'fullName': fullName,
      'groupId': groupId,
      'hireDate': formatFullRestNotMilSec(hireDate),
      'id': id,
      'imageId': imageId,
      'nationality': nationality,
      'organizationGroupId': organizationGroupId,
      'organizationName': organizationName,
      'positionGroupId': positionGroupId,
      'positionId': positionId,
      'positionName': positionName,
      'sex': sex,
      'maritalStatus': maritalStatus.toMap(),
      'managerList': managerList?.map((ManagerList e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
