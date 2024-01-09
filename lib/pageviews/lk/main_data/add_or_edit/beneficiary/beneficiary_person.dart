import 'dart:convert';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/assignment/assignment_element.dart';

class RelevantPerson {
  String entityName;
  String instanceName;
  String id;
  List<AssignmentElement> assignments;
  PersonGroup relevantPerson;
  List<RelevantPersonElement> list;
  String mobilePhone;
  AssignmentElement currentAssignment;

  RelevantPerson({
    this.entityName,
    this.instanceName,
    this.id,
    this.assignments,
    this.relevantPerson,
    this.list,
    this.mobilePhone,
    this.currentAssignment,
  });

  factory RelevantPerson.fromJson(String str) =>
      RelevantPerson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RelevantPerson.fromMap(Map<String, dynamic> json) => RelevantPerson(
    entityName: json["_entityName"],
    instanceName: json["_instanceName"],
    id: json["id"],
    assignments: json['assignments'] == null
        ? []
        : List<AssignmentElement>.from(
      json['assignments'].map((x) => AssignmentElement.fromMap(x)),),
    relevantPerson: json["relevantPerson"] == null ? null : PersonGroup.fromMap(json["relevantPerson"]),
    list: json["list"] == null ? [] : List<RelevantPersonElement>.from(json["list"].map((x) => RelevantPersonElement.fromJson(x))),
    mobilePhone: json["mobilePhone"],
    currentAssignment: json["currentAssignment"] == null ? null : AssignmentElement.fromMap(json["currentAssignment"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName,
    "_instanceName": instanceName,
    "id": id,
    "assignments": assignments == null ? [] : List<dynamic>.from(assignments.map((x) => x.toJson())),
    "relevantPerson": relevantPerson?.toMapId(),
    "list": list == null ? [] : List<dynamic>.from(list.map((x) => x.toJson())),
    "mobilePhone": mobilePhone,
    "currentAssignment": currentAssignment?.toJson(),
  };
}

class RelevantPersonElement {
  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  String employeeNumber;
  String firstName;
  DateTime startDate;
  String lastNameLatin;
  String lastName;
  String firstNameLatin;
  String middleName;
  String fullNameCyrillic;
  String fullNameNumberCyrillic;
  String nationalIdentifier;

  RelevantPersonElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.employeeNumber,
    this.firstName,
    this.startDate,
    this.lastNameLatin,
    this.lastName,
    this.firstNameLatin,
    this.middleName,
    this.fullNameCyrillic,
    this.fullNameNumberCyrillic,
    this.nationalIdentifier,
  });

  factory RelevantPersonElement.fromJson(Map<String, dynamic> json) => RelevantPersonElement(
    entityName: json["entityName"],
    instanceName: json["_instanceName"],
    id: json["id"],
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    employeeNumber: json["employeeNumber"],
    firstName:json["firstName"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    lastNameLatin: json["lastNameLatin"],
    lastName: json["lastName"],
    firstNameLatin: json["firstNameLatin"],
    middleName: json["middleName"],
    fullNameCyrillic: json["fullNameCyrillic"],
    fullNameNumberCyrillic: json["fullNameNumberCyrillic"],
    nationalIdentifier: json["nationalIdentifier"],
  );

  Map<String, dynamic> toJson() => {
    "_entityName": entityName,
    "_instanceName": instanceName,
    "id": id,
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "employeeNumber": employeeNumber,
    "firstName": firstName,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "lastNameLatin": lastNameLatin,
    "lastName": lastName,
    "firstNameLatin": firstNameLatin,
    "middleName": middleName,
    "fullNameCyrillic": fullNameCyrillic,
    "fullNameNumberCyrillic": fullNameNumberCyrillic,
    "nationalIdentifier": nationalIdentifier,
  };
}