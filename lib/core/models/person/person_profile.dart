// To parse this JSON data, do
//
//     final personProfile = personProfileFromMap(jsonString);

import 'dart:convert';

class PersonProfile {
  PersonProfile({
    this.id,
    this.groupId,
    this.fullName,
    this.hireDate,
    this.birthDate,
    this.sex,
    this.cityOfResidence,
    this.citizenship,
    this.imageId,
    this.organizationName,
    this.positionName,
    this.phone,
    this.email,
    this.assignmentGroupId,
  });

  String id;
  String groupId;
  String fullName;
  DateTime hireDate;
  DateTime birthDate;
  String sex;
  String cityOfResidence;
  String citizenship;
  String imageId;
  String organizationName;
  String positionName;
  String phone;
  String email;
  String assignmentGroupId;


  factory PersonProfile.fromJson(String str) => PersonProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonProfile.fromMap(Map<String, dynamic> json) => PersonProfile(
    id: json['id'],
    groupId: json['groupId'],
      fullName: json['fullName'],
    assignmentGroupId: json['assignmentGroupId'],

    hireDate: json['hireDate'] == null ? null : DateTime.parse(json['hireDate']),
    birthDate: json['birthDate'] == null ? null : DateTime.parse(json['birthDate']),
    sex: json['sex'],
    cityOfResidence: json['cityOfResidence'],
    citizenship: json['citizenship'],
    imageId: json['imageId'],
    organizationName: json['organizationName'],
    positionName: json['positionName'],
    phone: json['phone'],
    email: json['email'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'assignmentGroupId': assignmentGroupId,
    'groupId': groupId,
    'fullName': fullName,
    'hireDate': hireDate == null ? null : hireDate.toIso8601String(),
    'birthDate': birthDate == null ? null : birthDate.toIso8601String(),
    'sex': sex,
    'cityOfResidence': cityOfResidence,
    'citizenship': citizenship,
    'imageId': imageId,
    'organizationName': organizationName,
    'positionName': positionName,
    'phone': phone,
    'email': email,
  };
}
