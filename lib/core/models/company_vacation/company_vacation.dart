import 'dart:convert';

import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';


class CompanyVacation {
  CompanyVacation({
    this.entityName,
    this.instanceName,
    this.id,
    this.nameForSiteLang,
    this.nameForSiteLang3,
    this.createTs,
    this.nameForSiteLang1,
    this.nameForSiteLang2,
    this.startDate,
    this.code,
    this.operatingMode,
    this.positionGroup,
  });

  String entityName;
  String instanceName;
  String id;
  String nameForSiteLang;
  String nameForSiteLang3;
  DateTime createTs;
  String nameForSiteLang1;
  String nameForSiteLang2;
  DateTime startDate;
  String code;
  String operatingMode;
  PositionGroup positionGroup;

  factory CompanyVacation.fromJson(String str) => CompanyVacation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyVacation.fromMap(Map<String, dynamic> json) => CompanyVacation(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    nameForSiteLang: json["nameForSiteLang"] == null ? null : json["nameForSiteLang"],
    nameForSiteLang3: json["nameForSiteLang3"] == null ? null : json["nameForSiteLang3"],
    createTs: json["createTs"] == null ? null : DateTime.parse(json["createTs"]),
    nameForSiteLang1: json["nameForSiteLang1"] == null ? null : json["nameForSiteLang1"],
    nameForSiteLang2: json["nameForSiteLang2"] == null ? null : json["nameForSiteLang2"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    code: json["code"] == null ? null : json["code"],
    operatingMode: json["operatingMode"] == null ? null : json["operatingMode"],
    positionGroup: json["positionGroup"] == null ? null : PositionGroup.fromMap(json["positionGroup"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "nameForSiteLang": nameForSiteLang == null ? null : nameForSiteLang,
    "nameForSiteLang3": nameForSiteLang3 == null ? null : nameForSiteLang3,
    "createTs": createTs == null ? null : createTs.toIso8601String(),
    "nameForSiteLang1": nameForSiteLang1 == null ? null : nameForSiteLang1,
    "nameForSiteLang2": nameForSiteLang2 == null ? null : nameForSiteLang2,
    "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "code": code == null ? null : code,
    "operatingMode": operatingMode == null ? null : operatingMode,
    "positionGroup": positionGroup == null ? null : positionGroup.toMap(),
  };
}


class VacanciesRecommend {
  VacanciesRecommend({
    this.vacancy,
    this.referrer,
    this.file,
    this.relationshipToReferrer,
    this.workExperience,
    this.education,
    this.personGroup,
    this.personalEvaluation,
    this.cityResidence,
    this.firstName,
    this.lastName,
    this.mobilePhone,
    this.email,
    this.birthDate,
  });

  CompanyVacationItem vacancy;
  AbstractDictionary referrer;
  FileDescriptor file;
  AbstractDictionary relationshipToReferrer;
  AbstractDictionary workExperience;
  AbstractDictionary education;
  BasePersonGroupExt personGroup;
  AbstractDictionary personalEvaluation;
  String cityResidence;
  String firstName;
  String lastName;
  String mobilePhone;
  String email;
  DateTime birthDate;

  factory VacanciesRecommend.fromJson(String str) => VacanciesRecommend.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VacanciesRecommend.fromMap(Map<String, dynamic> json) => VacanciesRecommend(
    vacancy: json["vacancy"] == null ? null : CompanyVacationItem.fromMap(json["vacancy"]),
    referrer: json["referrer"] == null ? null : AbstractDictionary.fromMap(json["referrer"]),
    file: json["file"] == null ? null : FileDescriptor.fromMap(json["file"]),
    relationshipToReferrer: json["relationshipToReferrer"] == null ? null : AbstractDictionary.fromMap(json["relationshipToReferrer"]),
    workExperience: json["workExperience"] == null ? null : AbstractDictionary.fromMap(json["workExperience"]),
    education: json["education"] == null ? null : AbstractDictionary.fromMap(json["education"]),
    personGroup: json["personGroup"] == null ? null : BasePersonGroupExt.fromMap(json["personGroup"]),
    personalEvaluation: json["personalEvaluation"] == null ? null : AbstractDictionary.fromMap(json["personalEvaluation"]),
    cityResidence: json["cityResidence"] == null ? null : json["cityResidence"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    mobilePhone: json["mobilePhone"] == null ? null : json["mobilePhone"],
    email: json["email"] == null ? null : json["email"],
    birthDate: json['birthDate'] == null ? null : DateTime.parse(json['birthDate']),
  );

  Map<String, dynamic> toMap() => {
    "vacancy": vacancy == null ? null :vacancy.toMapId(),
    "referrer": referrer == null ? null :referrer.toMap(),
    "file": file == null ? null :file.toMap(),
    "relationshipToReferrer":relationshipToReferrer == null ? null : relationshipToReferrer.toMap(),
    "workExperience": workExperience == null ? null :workExperience.toMap(),
    "education": education == null ? null :education.toMap(),
    "personGroup": personGroup == null ? null :personGroup.toMap(),
    "personalEvaluation": personalEvaluation == null ? null :personalEvaluation.toMap(),
    "cityResidence": cityResidence == null ? null : cityResidence,
    "mobilePhone": mobilePhone == null ? null : mobilePhone,
    "email": email == null ? null : email,
    'birthDate': birthDate == null ? null : formatFullRest(birthDate),
  };
}