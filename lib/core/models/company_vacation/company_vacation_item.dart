// To parse this JSON data, do
//
//     final companyVacationItem = companyVacationItemFromMap(jsonString);

import 'dart:convert';

CompanyVacationItem companyVacationItemFromMap(String str) => CompanyVacationItem.fromMap(json.decode(str));

String companyVacationItemToMap(CompanyVacationItem data) => json.encode(data.toMap());

class CompanyVacationItem {
  CompanyVacationItem({
    this.entityName,
    this.instanceName,
    this.id,
    this.nameForSiteLang3,
    this.createTs,
    this.forSubstitution,
    this.nameForSiteLang1,
    this.nameForSiteLang2,
    this.jobResponsibilitiesLang3,
    this.jobResponsibilitiesLang2,
    this.jobResponsibilitiesLang1,
    this.withoutOffer,
    this.startDate,
    this.code,
    this.openedPositionsCount,
    this.viewCount,
    this.videoInterviewRequired,
    this.generalAndAdditionalRequirementsLang1,
    this.generalAndAdditionalRequirementsLang2,
    this.generalAndAdditionalRequirementsLang3,
    this.positionGroup,
    this.requisitionStatus,
    this.employeeType,
    this.mandatoryQualificationsLang2,
    this.mandatoryQualificationsLang1,
    this.permanent,
    this.mandatoryQualificationsLang3,
    this.desirableRequirementsAndAdditionalCommentsLang1,
    this.desirableRequirementsAndAdditionalCommentsLang2,
    this.desirableRequirementsAndAdditionalCommentsLang3
  });

  String entityName;
  String instanceName;
  String id;
  String nameForSiteLang3;
  DateTime createTs;
  bool forSubstitution;
  String nameForSiteLang1;
  String nameForSiteLang2;
  String jobResponsibilitiesLang3;
  String jobResponsibilitiesLang2;
  String jobResponsibilitiesLang1;
  bool withoutOffer;
  DateTime startDate;
  String code;
  double openedPositionsCount;
  int viewCount;
  bool videoInterviewRequired;
  String generalAndAdditionalRequirementsLang1;
  String generalAndAdditionalRequirementsLang2;
  String generalAndAdditionalRequirementsLang3;
  PositionGroup positionGroup;
  String requisitionStatus;
  String employeeType;
  String mandatoryQualificationsLang2;
  String mandatoryQualificationsLang1;
  bool permanent;
  String mandatoryQualificationsLang3;
  String desirableRequirementsAndAdditionalCommentsLang1;
  String desirableRequirementsAndAdditionalCommentsLang2;
  String desirableRequirementsAndAdditionalCommentsLang3;

  CompanyVacationItem userInfoFromJson(String str) => CompanyVacationItem.fromMap(json.decode(str));

  factory CompanyVacationItem.fromMap(Map<String, dynamic> json) => CompanyVacationItem(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    nameForSiteLang3: json["nameForSiteLang3"] == null ? null : json["nameForSiteLang3"],
    createTs: json["createTs"] == null ? null : DateTime.parse(json["createTs"]),
    forSubstitution: json["forSubstitution"] == null ? null : json["forSubstitution"],
    nameForSiteLang1: json["nameForSiteLang1"] == null ? null : json["nameForSiteLang1"],
    nameForSiteLang2: json["nameForSiteLang2"] == null ? null : json["nameForSiteLang2"],
    jobResponsibilitiesLang3: json["jobResponsibilitiesLang3"] == null ? null : json["jobResponsibilitiesLang3"],
    jobResponsibilitiesLang2: json["jobResponsibilitiesLang2"] == null ? null : json["jobResponsibilitiesLang2"],
    jobResponsibilitiesLang1: json["jobResponsibilitiesLang1"] == null ? null : json["jobResponsibilitiesLang1"],
    withoutOffer: json["withoutOffer"] == null ? null : json["withoutOffer"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    code: json["code"] == null ? null : json["code"],
    openedPositionsCount: json["openedPositionsCount"] == null ? null : json["openedPositionsCount"],
    viewCount: json["viewCount"] == null ? null : json["viewCount"],
    videoInterviewRequired: json["videoInterviewRequired"] == null ? null : json["videoInterviewRequired"],
    generalAndAdditionalRequirementsLang1: json["generalAndAdditionalRequirementsLang1"] == null ? null : json["generalAndAdditionalRequirementsLang1"],
    generalAndAdditionalRequirementsLang2: json["generalAndAdditionalRequirementsLang2"] == null ? null : json["generalAndAdditionalRequirementsLang2"],
    generalAndAdditionalRequirementsLang3: json["generalAndAdditionalRequirementsLang3"] == null ? null : json["generalAndAdditionalRequirementsLang3"],
    desirableRequirementsAndAdditionalCommentsLang1: json["desirableRequirementsAndAdditionalCommentsLang1"] == null ? null : json["desirableRequirementsAndAdditionalCommentsLang1"],
    desirableRequirementsAndAdditionalCommentsLang2: json["desirableRequirementsAndAdditionalCommentsLang2"] == null ? null : json["desirableRequirementsAndAdditionalCommentsLang2"],
    desirableRequirementsAndAdditionalCommentsLang3: json["desirableRequirementsAndAdditionalCommentsLang3"] == null ? null : json["desirableRequirementsAndAdditionalCommentsLang3"],
    positionGroup: json["positionGroup"] == null ? null : PositionGroup.fromMap(json["positionGroup"]),
    requisitionStatus: json["requisitionStatus"] == null ? null : json["requisitionStatus"],
    employeeType: json["employeeType"] == null ? null : json["employeeType"],
    mandatoryQualificationsLang2: json["mandatoryQualificationsLang2"] == null ? null : json["mandatoryQualificationsLang2"],
    mandatoryQualificationsLang1: json["mandatoryQualificationsLang1"] == null ? null : json["mandatoryQualificationsLang1"],
    permanent: json["permanent"] == null ? null : json["permanent"],
    mandatoryQualificationsLang3: json["mandatoryQualificationsLang3"] == null ? null : json["mandatoryQualificationsLang3"],
  );

  Map<String, dynamic> toMapId() => {'id': id};

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "nameForSiteLang3": nameForSiteLang3 == null ? null : nameForSiteLang3,
    "createTs": createTs == null ? null : createTs.toIso8601String(),
    "forSubstitution": forSubstitution == null ? null : forSubstitution,
    "nameForSiteLang1": nameForSiteLang1 == null ? null : nameForSiteLang1,
    "nameForSiteLang2": nameForSiteLang2 == null ? null : nameForSiteLang2,
    "jobResponsibilitiesLang3": jobResponsibilitiesLang3 == null ? null : jobResponsibilitiesLang3,
    "jobResponsibilitiesLang2": jobResponsibilitiesLang2 == null ? null : jobResponsibilitiesLang2,
    "jobResponsibilitiesLang1": jobResponsibilitiesLang1 == null ? null : jobResponsibilitiesLang1,
    "desirableRequirementsAndAdditionalCommentsLang1": desirableRequirementsAndAdditionalCommentsLang1 == null ? null : desirableRequirementsAndAdditionalCommentsLang1,
    "desirableRequirementsAndAdditionalCommentsLang2": desirableRequirementsAndAdditionalCommentsLang2 == null ? null : desirableRequirementsAndAdditionalCommentsLang2,
    "desirableRequirementsAndAdditionalCommentsLang3": desirableRequirementsAndAdditionalCommentsLang3 == null ? null : desirableRequirementsAndAdditionalCommentsLang3,
    "withoutOffer": withoutOffer == null ? null : withoutOffer,
    "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "code": code == null ? null : code,
    "openedPositionsCount": openedPositionsCount == null ? null : openedPositionsCount,
    "viewCount": viewCount == null ? null : viewCount,
    "videoInterviewRequired": videoInterviewRequired == null ? null : videoInterviewRequired,
    "generalAndAdditionalRequirementsLang1": generalAndAdditionalRequirementsLang1 == null ? null : generalAndAdditionalRequirementsLang1,
    "generalAndAdditionalRequirementsLang2": generalAndAdditionalRequirementsLang2 == null ? null : generalAndAdditionalRequirementsLang2,
    "generalAndAdditionalRequirementsLang3": generalAndAdditionalRequirementsLang3 == null ? null : generalAndAdditionalRequirementsLang3,
    "positionGroup": positionGroup == null ? null : positionGroup.toMap(),
    "requisitionStatus": requisitionStatus == null ? null : requisitionStatus,
    "employeeType": employeeType == null ? null : employeeType,
    "mandatoryQualificationsLang2": mandatoryQualificationsLang2 == null ? null : mandatoryQualificationsLang2,
    "mandatoryQualificationsLang1": mandatoryQualificationsLang1 == null ? null : mandatoryQualificationsLang1,
    "permanent": permanent == null ? null : permanent,
    "mandatoryQualificationsLang3": mandatoryQualificationsLang3 == null ? null : mandatoryQualificationsLang3,
  };
}

class PositionGroup {
  PositionGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.legacyId,
    this.company,
    this.organizationGroup,
    this.position,
  });

  String entityName;
  String instanceName;
  String id;
  String legacyId;
  Company company;
  OrganizationGroup organizationGroup;
  Position position;

  factory PositionGroup.fromMap(Map<String, dynamic> json) => PositionGroup(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    legacyId: json["legacyId"] == null ? null : json["legacyId"],
    company: json["company"] == null ? null : Company.fromMap(json["company"]),
    organizationGroup: json["organizationGroup"] == null ? null : OrganizationGroup.fromMap(json["organizationGroup"]),
    position: json["position"] == null ? null : Position.fromMap(json["position"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "legacyId": legacyId == null ? null : legacyId,
    "company": company == null ? null : company.toMap(),
    "organizationGroup": organizationGroup == null ? null : organizationGroup.toMap(),
    "position": position == null ? null : position.toMap(),
  };
}

class Company {
  Company({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.legacyId,
    this.order,
    this.isSystemRecord,
    this.langValue3,
    this.active,
    this.isDefault,
    this.langValue2,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  String legacyId;
  int order;
  bool isSystemRecord;
  String langValue3;
  bool active;
  bool isDefault;
  String langValue2;
  String langValue1;

  factory Company.fromMap(Map<String, dynamic> json) => Company(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    legacyId: json["legacyId"] == null ? null : json["legacyId"],
    order: json["order"] == null ? null : json["order"],
    isSystemRecord: json["isSystemRecord"] == null ? null : json["isSystemRecord"],
    langValue3: json["langValue3"] == null ? null : json["langValue3"],
    active: json["active"] == null ? null : json["active"],
    isDefault: json["isDefault"] == null ? null : json["isDefault"],
    langValue2: json["langValue2"] == null ? null : json["langValue2"],
    langValue1: json["langValue1"] == null ? null : json["langValue1"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "legacyId": legacyId == null ? null : legacyId,
    "order": order == null ? null : order,
    "isSystemRecord": isSystemRecord == null ? null : isSystemRecord,
    "langValue3": langValue3 == null ? null : langValue3,
    "active": active == null ? null : active,
    "isDefault": isDefault == null ? null : isDefault,
    "langValue2": langValue2 == null ? null : langValue2,
    "langValue1": langValue1 == null ? null : langValue1,
  };
}

class OrganizationGroup {
  OrganizationGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.organizationNameLang1,
    this.organizationNameLang2,
    this.organizationNameLang3,
    this.list,
    this.endDate,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  String organizationNameLang1;
  String organizationNameLang2;
  String organizationNameLang3;
  List<OrganizationGroup> list;
  DateTime endDate;
  DateTime startDate;

  factory OrganizationGroup.fromMap(Map<String, dynamic> json) => OrganizationGroup(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    organizationNameLang1: json["organizationNameLang1"] == null ? null : json["organizationNameLang1"],
    organizationNameLang2: json["organizationNameLang2"] == null ? null : json["organizationNameLang2"],
    organizationNameLang3: json["organizationNameLang3"] == null ? null : json["organizationNameLang3"],
    list: json["list"] == null ? null : List<OrganizationGroup>.from(json["list"].map((x) => OrganizationGroup.fromMap(x))),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "organizationNameLang1": organizationNameLang1 == null ? null : organizationNameLang1,
    "organizationNameLang2": organizationNameLang2 == null ? null : organizationNameLang2,
    "organizationNameLang3": organizationNameLang3 == null ? null : organizationNameLang3,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toMap())),
    "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class Position {
  Position({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.startDate,
    this.positionFullNameLang1,
    this.positionFullNameLang2,
    this.positionFullNameLang3,
    this.positionNameLang3,
    this.positionNameLang2,
    this.positionNameLang1,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  DateTime startDate;
  String positionFullNameLang1;
  String positionFullNameLang2;
  String positionFullNameLang3;
  String positionNameLang3;
  String positionNameLang2;
  String positionNameLang1;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    positionFullNameLang1: json["positionFullNameLang1"] == null ? null : json["positionFullNameLang1"],
    positionFullNameLang2: json["positionFullNameLang2"] == null ? null : json["positionFullNameLang2"],
    positionFullNameLang3: json["positionFullNameLang3"] == null ? null : json["positionFullNameLang3"],
    positionNameLang3: json["positionNameLang3"] == null ? null : json["positionNameLang3"],
    positionNameLang2: json["positionNameLang2"] == null ? null : json["positionNameLang2"],
    positionNameLang1: json["positionNameLang1"] == null ? null : json["positionNameLang1"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "endDate": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "positionFullNameLang1": positionFullNameLang1 == null ? null : positionFullNameLang1,
    "positionFullNameLang2": positionFullNameLang2 == null ? null : positionFullNameLang2,
    "positionFullNameLang3": positionFullNameLang3 == null ? null : positionFullNameLang3,
    "positionNameLang3": positionNameLang3 == null ? null : positionNameLang3,
    "positionNameLang2": positionNameLang2 == null ? null : positionNameLang2,
    "positionNameLang1": positionNameLang1 == null ? null : positionNameLang1,
  };
}
