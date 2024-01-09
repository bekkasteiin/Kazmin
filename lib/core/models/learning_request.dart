
// To parse this JSON data, do
//
//     final learningRequest = learningRequestFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/assignment/assignment.dart';

class LearningRequest {
  LearningRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.totalCosts,
    this.learningType,
    this.numberOfDays,
    this.livingCosts,
    this.transferKnowledge,
    this.competence,
    this.requestNumber,
    this.typeOfTraining,
    this.costOfEducation,
    this.dailyLivingCosts,
    this.requestDate,
    this.travelCosts,
    this.personGroup,
    this.numberOfHours,
    this.dateFrom,
    this.courseDescription,
    this.courseName,
    this.instruction,
    this.dateTo,
    this.comment,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  double totalCosts;
  LearningType learningType;
  int numberOfDays;
  double livingCosts;
  LearningType transferKnowledge;
  Competence competence;
  int requestNumber;
  LearningType typeOfTraining;
  double costOfEducation;
  double dailyLivingCosts;
  DateTime requestDate;
  double travelCosts;
  PersonGroup personGroup;
  int numberOfHours;
  DateTime dateFrom;
  String courseDescription;
  String courseName;
  String instruction;
  DateTime dateTo;
  String comment;
  LearningType status;

  factory LearningRequest.fromJson(String str) => LearningRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LearningRequest.fromMap(Map<String, dynamic> json) => LearningRequest(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    totalCosts: json['totalCosts'],
    learningType: LearningType.fromMap(json['learningType']),
    numberOfDays: json['numberOfDays'],
    livingCosts: json['livingCosts'],
    transferKnowledge: LearningType.fromMap(json['transferKnowledge']),
    competence: Competence.fromMap(json['competence']),
    requestNumber: json['requestNumber'],
    typeOfTraining: LearningType.fromMap(json['typeOfTraining']),
    costOfEducation: json['costOfEducation'],
    dailyLivingCosts: json['dailyLivingCosts'],
    requestDate: DateTime.parse(json['requestDate']),
    travelCosts: json['travelCosts'],
    personGroup: PersonGroup.fromMap(json['personGroup']),
    numberOfHours: json['numberOfHours'],
    dateFrom: DateTime.parse(json['dateFrom']),
    courseDescription: json['courseDescription'],
    courseName: json['courseName'],
    instruction: json['instruction'],
    dateTo: DateTime.parse(json['dateTo']),
    comment: json['comment'],
    status: LearningType.fromMap(json['status']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'totalCosts': totalCosts,
    'learningType': learningType.toMap(),
    'numberOfDays': numberOfDays,
    'livingCosts': livingCosts,
    'transferKnowledge': transferKnowledge.toMap(),
    'competence': competence.toMap(),
    'requestNumber': requestNumber,
    'typeOfTraining': typeOfTraining.toMap(),
    'costOfEducation': costOfEducation,
    'dailyLivingCosts': dailyLivingCosts,
    'requestDate': "${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}",
    'travelCosts': travelCosts,
    'personGroup': personGroup.toMap(),
    'numberOfHours': numberOfHours,
    'dateFrom': "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
    'courseDescription': courseDescription,
    'courseName': courseName,
    'instruction': instruction,
    'dateTo': "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
    'comment': comment,
    'status': status.toMap(),
  };
}

class Competence {
  Competence({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.competenceNameLang3,
    this.scale,
    this.competenceNameLang1,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  String competenceNameLang3;
  LearningType scale;
  String competenceNameLang1;
  DateTime startDate;

  factory Competence.fromJson(String str) => Competence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Competence.fromMap(Map<String, dynamic> json) => Competence(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: DateTime.parse(json['endDate']),
    competenceNameLang3: json['competenceNameLang3'],
    scale: LearningType.fromMap(json['scale']),
    competenceNameLang1: json['competenceNameLang1'],
    startDate: DateTime.parse(json['startDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'competenceNameLang3': competenceNameLang3,
    'scale': scale.toMap(),
    'competenceNameLang1': competenceNameLang1,
    'startDate': "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class LearningType {
  LearningType({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.langValue1,
    this.code,
    this.langValue2,
  });

  String entityName;
  String instanceName;
  String id;
  String langValue3;
  String langValue1;
  String code;
  String langValue2;

  factory LearningType.fromJson(String str) => LearningType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LearningType.fromMap(Map<String, dynamic> json) => LearningType(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    langValue3: json['langValue3'],
    langValue1: json['langValue1'],
    code: json['code'],
    langValue2: json['langValue2'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'langValue3': langValue3,
    'langValue1': langValue1,
    'code': code,
    'langValue2': langValue2,
  };
}


