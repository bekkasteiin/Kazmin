// To parse this JSON data, do
//
//     final personLearningContract = personLearningContractFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/course_schedule.dart';

import 'package:kzm/core/models/courses/course.dart';

class PersonLearningContract {
  PersonLearningContract({
    this.entityName,
    this.instanceName,
    this.id,
    this.contractDate,
    this.other,
    this.organizationBin,
    this.personGroup,
    this.contractEndDate,
    this.contractNumber,
    this.integrationUserLogin,
    this.termOfService,
    this.courseScheduleEnrollment,
    this.legacyId,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime contractDate;
  dynamic other;
  dynamic organizationBin;
  PersonLearningContractPersonGroup personGroup;
  DateTime contractEndDate;
  String contractNumber;
  dynamic integrationUserLogin;
  DateTime termOfService;
  CourseScheduleEnrollment courseScheduleEnrollment;
  dynamic legacyId;

  factory PersonLearningContract.fromJson(String str) => PersonLearningContract.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonLearningContract.fromMap(Map<String, dynamic> json) => PersonLearningContract(
    entityName: json['_entityName'] as String,
    instanceName: json['_instanceName'] as String,
    id: json['id'] as String,
    contractDate: DateTime.parse(json['contractDate'] as String),
    other: json['other'],
    organizationBin: json['organizationBin'],
    personGroup: PersonLearningContractPersonGroup.fromMap(json['personGroup']),
    contractEndDate: DateTime.parse(json['contractEndDate']),
    contractNumber: json['contractNumber'],
    integrationUserLogin: json['integrationUserLogin'],
    termOfService: DateTime.parse(json['termOfService']),
    courseScheduleEnrollment: CourseScheduleEnrollment.fromMap(json['courseScheduleEnrollment']),
    legacyId: json['legacyId'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'contractDate': "${contractDate.year.toString().padLeft(4, '0')}-${contractDate.month.toString().padLeft(2, '0')}-${contractDate.day.toString().padLeft(2, '0')}",
    'other': other,
    'organizationBin': organizationBin,
    'personGroup': personGroup.toMap(),
    'contractEndDate': "${contractEndDate.year.toString().padLeft(4, '0')}-${contractEndDate.month.toString().padLeft(2, '0')}-${contractEndDate.day.toString().padLeft(2, '0')}",
    'contractNumber': contractNumber,
    'integrationUserLogin': integrationUserLogin,
    'termOfService': "${termOfService.year.toString().padLeft(4, '0')}-${termOfService.month.toString().padLeft(2, '0')}-${termOfService.day.toString().padLeft(2, '0')}",
    'courseScheduleEnrollment': courseScheduleEnrollment.toMap(),
    'legacyId': legacyId,
  };
}

class CourseScheduleEnrollment {
  CourseScheduleEnrollment({
    this.entityName,
    this.instanceName,
    this.id,
    this.personGroup,
    this.courseSchedule,
    this.totalCost,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  CourseScheduleEnrollmentPersonGroup personGroup;
  CourseSchedule courseSchedule;
  double totalCost;
  String status;

  factory CourseScheduleEnrollment.fromJson(String str) => CourseScheduleEnrollment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseScheduleEnrollment.fromMap(Map<String, dynamic> json) => CourseScheduleEnrollment(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    personGroup: CourseScheduleEnrollmentPersonGroup.fromMap(json['personGroup']),
    courseSchedule: CourseSchedule.fromMap(json['courseSchedule']),
    totalCost: json['totalCost'],
    status: json['status'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'personGroup': personGroup.toMap(),
    'courseSchedule': courseSchedule.toMap(),
    'totalCost': totalCost,
    'status': status,
  };
}


class CourseScheduleEnrollmentPersonGroup {
  CourseScheduleEnrollmentPersonGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.list,
    this.mobilePhone,
  });

  String entityName;
  String instanceName;
  String id;
  List<PersonGroupList> list;
  dynamic mobilePhone;

  factory CourseScheduleEnrollmentPersonGroup.fromJson(String str) => CourseScheduleEnrollmentPersonGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseScheduleEnrollmentPersonGroup.fromMap(Map<String, dynamic> json) => CourseScheduleEnrollmentPersonGroup(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    list: List<PersonGroupList>.from(json['list'].map((x) => PersonGroupList.fromMap(x))),
    mobilePhone: json['mobilePhone'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'list': List<dynamic>.from(list.map((PersonGroupList x) => x.toMap())),
    'mobilePhone': mobilePhone,
  };
}

class PersonGroupList {
  PersonGroupList({
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
    this.middleNameLatin,
    this.middleName,
  });

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
  dynamic middleNameLatin;
  String middleName;

  factory PersonGroupList.fromJson(String str) => PersonGroupList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonGroupList.fromMap(Map<String, dynamic> json) => PersonGroupList(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: DateTime.parse(json['endDate']),
    employeeNumber: json['employeeNumber'],
    firstName: json['firstName'],
    startDate: DateTime.parse(json['startDate']),
    lastNameLatin: json['lastNameLatin'],
    lastName: json['lastName'],
    firstNameLatin: json['firstNameLatin'],
    middleNameLatin: json['middleNameLatin'],
    middleName: json['middleName'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'employeeNumber': employeeNumber,
    'firstName': firstName,
    'startDate': "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    'lastNameLatin': lastNameLatin,
    'lastName': lastName,
    'firstNameLatin': firstNameLatin,
    'middleNameLatin': middleNameLatin,
    'middleName': middleName,
  };
}

class PersonLearningContractPersonGroup {
  PersonLearningContractPersonGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.assignments,
    this.list,
    this.mobilePhone,
    this.personLatinFioWithEmployeeNumber,
    this.fullName,
  });

  String entityName;
  String instanceName;
  String id;
  List<Assignment> assignments;
  List<PersonGroupList> list;
  dynamic mobilePhone;
  String personLatinFioWithEmployeeNumber;
  String fullName;

  factory PersonLearningContractPersonGroup.fromJson(String str) => PersonLearningContractPersonGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonLearningContractPersonGroup.fromMap(Map<String, dynamic> json) => PersonLearningContractPersonGroup(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    assignments: List<Assignment>.from(json['assignments'].map((x) => Assignment.fromMap(x))),
    list: List<PersonGroupList>.from(json['list'].map((x) => PersonGroupList.fromMap(x))),
    mobilePhone: json['mobilePhone'],
    personLatinFioWithEmployeeNumber: json['personLatinFioWithEmployeeNumber'],
    fullName: json['fullName'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'assignments': List<dynamic>.from(assignments.map((Assignment x) => x.toMap())),
    'list': List<dynamic>.from(list.map((PersonGroupList x) => x.toMap())),
    'mobilePhone': mobilePhone,
    'personLatinFioWithEmployeeNumber': personLatinFioWithEmployeeNumber,
    'fullName': fullName,
  };
}

class Assignment {
  Assignment({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.primaryFlag,
    this.group,
    this.assignmentStatus,
    this.organizationGroup,
    this.personGroup,
    this.jobGroup,
    this.positionGroup,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  bool primaryFlag;
  Course group;
  AssignmentStatus assignmentStatus;
  OrganizationGroup organizationGroup;
  Course personGroup;
  JobGroup jobGroup;
  PositionGroup positionGroup;
  DateTime startDate;

  factory Assignment.fromJson(String str) => Assignment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Assignment.fromMap(Map<String, dynamic> json) => Assignment(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: DateTime.parse(json['endDate']),
    primaryFlag: json['primaryFlag'],
    group: Course.fromMap(json['group']),
    assignmentStatus: AssignmentStatus.fromMap(json['assignmentStatus']),
    organizationGroup: OrganizationGroup.fromMap(json['organizationGroup']),
    personGroup: Course.fromMap(json['personGroup']),
    // jobGroup: JobGroup.fromMap(json["jobGroup"]),
    positionGroup: PositionGroup.fromMap(json['positionGroup']),
    startDate: DateTime.parse(json['startDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'primaryFlag': primaryFlag,
    'group': group.toMap(),
    'assignmentStatus': assignmentStatus.toMap(),
    'organizationGroup': organizationGroup.toMap(),
    'personGroup': personGroup.toMap(),
    'jobGroup': jobGroup.toMap(),
    'positionGroup': positionGroup.toMap(),
    'startDate': "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class AssignmentStatus {
  AssignmentStatus({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.langValue5,
    this.langValue4,
    this.langValue3,
    this.langValue2,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  dynamic langValue5;
  dynamic langValue4;
  String langValue3;
  dynamic langValue2;
  String langValue1;

  factory AssignmentStatus.fromJson(String str) => AssignmentStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignmentStatus.fromMap(Map<String, dynamic> json) => AssignmentStatus(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    code: json['code'],
    langValue5: json['langValue5'],
    langValue4: json['langValue4'],
    langValue3: json['langValue3'],
    langValue2: json['langValue2'],
    langValue1: json['langValue1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'code': code,
    'langValue5': langValue5,
    'langValue4': langValue4,
    'langValue3': langValue3,
    'langValue2': langValue2,
    'langValue1': langValue1,
  };
}

class JobGroup {
  JobGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.jobNameLang4,
    this.jobNameLang5,
    this.jobNameLang2,
    this.jobNameLang3,
    this.jobNameLang1,
    this.jobName,
    this.list,
    this.endDate,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  dynamic jobNameLang4;
  dynamic jobNameLang5;
  String jobNameLang2;
  String jobNameLang3;
  String jobNameLang1;
  String jobName;
  List<JobGroup> list;
  DateTime endDate;
  DateTime startDate;

  factory JobGroup.fromJson(String str) => JobGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobGroup.fromMap(Map<String, dynamic> json) => JobGroup(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    jobNameLang4: json['jobNameLang4'],
    jobNameLang5: json['jobNameLang5'],
    jobNameLang2: json['jobNameLang2'],
    jobNameLang3: json['jobNameLang3'],
    jobNameLang1: json['jobNameLang1'],
    jobName: json['jobName'],
    list: json['list'] == null ? null : List<JobGroup>.from(json['list'].map((x) => JobGroup.fromMap(x))),
    endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'jobNameLang4': jobNameLang4,
    'jobNameLang5': jobNameLang5,
    'jobNameLang2': jobNameLang2,
    'jobNameLang3': jobNameLang3,
    'jobNameLang1': jobNameLang1,
    'jobName': jobName,
    'list': list == null ? null : List<dynamic>.from(list.map((JobGroup x) => x.toMap())),
    'endDate': endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'startDate': startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
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
    this.organizationNameLang4,
    this.organizationNameLang5,
    this.organizationName,
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
  dynamic organizationNameLang4;
  dynamic organizationNameLang5;
  String organizationName;
  List<OrganizationGroup> list;
  DateTime endDate;
  DateTime startDate;

  factory OrganizationGroup.fromJson(String str) => OrganizationGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrganizationGroup.fromMap(Map<String, dynamic> json) => OrganizationGroup(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    organizationNameLang1: json['organizationNameLang1'],
    organizationNameLang2: json['organizationNameLang2'],
    organizationNameLang3: json['organizationNameLang3'],
    organizationNameLang4: json['organizationNameLang4'],
    organizationNameLang5: json['organizationNameLang5'],
    organizationName: json['organizationName'],
    list: json['list'] == null ? null : List<OrganizationGroup>.from(json['list'].map((x) => OrganizationGroup.fromMap(x))),
    endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'organizationNameLang1': organizationNameLang1,
    'organizationNameLang2': organizationNameLang2,
    'organizationNameLang3': organizationNameLang3,
    'organizationNameLang4': organizationNameLang4,
    'organizationNameLang5': organizationNameLang5,
    'organizationName': organizationName,
    'list': list == null ? null : List<dynamic>.from(list.map((OrganizationGroup x) => x.toMap())),
    'endDate': endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'startDate': startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class PositionGroup {
  PositionGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.positionName,
    this.list,
  });

  String entityName;
  String instanceName;
  String id;
  String positionName;
  List<PositionGroupList> list;

  factory PositionGroup.fromJson(String str) => PositionGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionGroup.fromMap(Map<String, dynamic> json) => PositionGroup(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    positionName: json['positionName'],
    list: List<PositionGroupList>.from(json['list'].map((x) => PositionGroupList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'positionName': positionName,
    'list': List<dynamic>.from(list.map((PositionGroupList x) => x.toMap())),
  };
}

class PositionGroupList {
  PositionGroupList({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.startDate,
    this.positionFullNameLang1,
    this.positionFullNameLang2,
    this.positionFullNameLang3,
    this.positionFullNameLang4,
    this.positionFullNameLang5,
    this.positionNameLang3,
    this.positionNameLang2,
    this.positionNameLang5,
    this.positionNameLang4,
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
  dynamic positionFullNameLang4;
  dynamic positionFullNameLang5;
  String positionNameLang3;
  String positionNameLang2;
  dynamic positionNameLang5;
  dynamic positionNameLang4;
  String positionNameLang1;

  factory PositionGroupList.fromJson(String str) => PositionGroupList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionGroupList.fromMap(Map<String, dynamic> json) => PositionGroupList(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: DateTime.parse(json['endDate']),
    startDate: DateTime.parse(json['startDate']),
    positionFullNameLang1: json['positionFullNameLang1'],
    positionFullNameLang2: json['positionFullNameLang2'],
    positionFullNameLang3: json['positionFullNameLang3'],
    positionFullNameLang4: json['positionFullNameLang4'],
    positionFullNameLang5: json['positionFullNameLang5'],
    positionNameLang3: json['positionNameLang3'],
    positionNameLang2: json['positionNameLang2'],
    positionNameLang5: json['positionNameLang5'],
    positionNameLang4: json['positionNameLang4'],
    positionNameLang1: json['positionNameLang1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'startDate': "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    'positionFullNameLang1': positionFullNameLang1,
    'positionFullNameLang2': positionFullNameLang2,
    'positionFullNameLang3': positionFullNameLang3,
    'positionFullNameLang4': positionFullNameLang4,
    'positionFullNameLang5': positionFullNameLang5,
    'positionNameLang3': positionNameLang3,
    'positionNameLang2': positionNameLang2,
    'positionNameLang5': positionNameLang5,
    'positionNameLang4': positionNameLang4,
    'positionNameLang1': positionNameLang1,
  };
}
