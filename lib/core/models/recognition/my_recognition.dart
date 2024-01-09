import 'dart:convert';

import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/models/person_learning_contract.dart';
import 'package:kzm/core/models/recognition/my_medals.dart';

class MyRecognition {
  MyRecognition({
    this.entityName,
    this.instanceName,
    this.id,
    this.request,
    this.endDate,
    this.delivered,
    this.medal,
    this.company,
    this.personGroup,
    this.hasUpgraded,
    this.isActive,
    this.awardedBy,
    this.medalCount,
    this.startDate,
    this.awardType,
    this.deliveryDate,
    this.criteria,
    this.upgradedMedal
  });

  String entityName;
  String instanceName;
  String id;
  GroupElement request;
  DateTime endDate;
  bool delivered;
  bool isActive;
  Medal medal;
  AssignmentStatus company;
  PersonGroup personGroup;
  bool hasUpgraded;
  PersonGroup awardedBy;
  int medalCount;
  DateTime startDate;
  AssignmentStatus awardType;
  DateTime deliveryDate;
  Company criteria;
  Medal upgradedMedal;

  factory MyRecognition.fromJson(String str) => MyRecognition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyRecognition.fromMap(Map<String, dynamic> json) => MyRecognition(
    entityName:  json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["_instanceName"],
    request: json['request'] == null ? null : GroupElement.fromMap(json["request"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    delivered: json["delivered"] == null ? null : json["delivered"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    medal: json['medal'] == null ? null : Medal.fromMap(json["medal"]),
    company: json['company'] == null ? null : AssignmentStatus.fromMap(json["company"]),
    personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json["personGroup"]),
    hasUpgraded: json["hasUpgraded"] == null ? null : json["hasUpgraded"],
    awardedBy: json['awardedBy'] == null ? null : PersonGroup.fromMap(json["awardedBy"]),
    medalCount: json["medalCount"] == null ? null : json["medalCount"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    awardType: json['awardType'] == null ? null : AssignmentStatus.fromMap(json["awardType"]),
    criteria: json['criteria'] == null ? null : Company.fromMap(json["criteria"]),
    upgradedMedal: json['upgradedMedal'] == null ? null : Medal.fromMap(json["upgradedMedal"]),
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "request": request == null ? null : request.toMap(),
    "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "delivered": delivered == null ? null : delivered,
    "isActive": isActive == null ? null : isActive,
    "medal": medal == null ? null : medal.toMap(),
    "company": company == null ? null : company.toMap(),
    "personGroup": personGroup == null ? null : personGroup.toMap(),
    "hasUpgraded": hasUpgraded == null ? null : hasUpgraded,
    "awardedBy": awardedBy == null ? null : awardedBy.toMap(),
    "medalCount": medalCount == null ? null : medalCount,
    "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "awardType": awardType == null ? null : awardType.toMap(),
    "criteria": criteria == null ? null : criteria.toMap(),
    "upgradedMedal": upgradedMedal == null ? null : upgradedMedal.toMap(),
    "deliveryDate": deliveryDate == null ? null :  "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
  };
}