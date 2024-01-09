import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/vacation_schedule/vacation_schedule_request.dart';

part 'absence.g.dart';

@HiveType(typeId: 12)
class AbsenceRequest extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'absenceRequest';

  @override
  String get getView => 'absenceRequest-for-mobile';

  @override
  String get getEntityName => EntityNames.absenceRequest;

  @override
  dynamic getFromJson(String string) => AbsenceRequest.fromJson(string);

  AbsenceRequest({
    this.entityName,
    this.id,
    this.type,
    this.absenceDays,
    this.personGroup,
    this.dateFrom,
    this.dateTo,
    this.assignmentGroup,
    this.compensation,
    this.distanceWorkingConfirm,
    this.requestDate,
    this.requestNumber,
    this.status,
    this.vacationScheduleRequest,
    this.reason,
    this.originalSheet,
    this.scheduleStartDate,
    this.scheduleEndDate,
    this.addNextYear,
    this.newStartDate,
    this.newEndDate,
    this.instanceName,
    this.periodDateFrom,
    this.agree,
    this.files,
    this.vacationDay,
    this.acquainted,
    this.periodDateTo,
    this.startTime,
    this.endTime,
  });

  @HiveField(0)
  String entityName;
  @override
  @HiveField(1)
  String id;
  @override
  @HiveField(2)
  DicAbsenceType type;
  @HiveField(3)
  int absenceDays;
  @HiveField(4)
  PersonGroup personGroup;
  @HiveField(5)
  DateTime dateFrom;
  @HiveField(6)
  DateTime dateTo;
  @override
  @HiveField(7)
  AbstractDictionary status;
  @HiveField(8)
  GroupElement assignmentGroup;
  @HiveField(9)
  bool distanceWorkingConfirm;
  @HiveField(10)
  DateTime requestDate;
  @HiveField(11)
  bool compensation;
  @HiveField(12)
  num requestNumber;
  @HiveField(13)
  VacationScheduleRequest vacationScheduleRequest;
  @HiveField(14)
  String reason;
  @HiveField(15)
  bool originalSheet;
  @HiveField(16)
  DateTime scheduleStartDate;
  @HiveField(17)
  DateTime scheduleEndDate;
  @HiveField(18)
  bool addNextYear;
  @HiveField(19)
  DateTime newStartDate;
  @HiveField(20)
  DateTime newEndDate;
  @HiveField(21)
  DateTime periodDateFrom;
  @HiveField(22)
  DateTime periodDateTo;
  @override
  @HiveField(23)
  List<FileDescriptor> files;
  @HiveField(24)
  String instanceName;
  @override
  @HiveField(28)
  bool agree;
  @HiveField(29)
  bool vacationDay;
  bool acquainted;
  @HiveField(30)
  String startTime;
  @HiveField(31)
  String endTime;


  factory AbsenceRequest.fromJson(String str) => AbsenceRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbsenceRequest.fromMap(Map<String, dynamic> json) => AbsenceRequest(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        type: json['type'] == null ? null : DicAbsenceType.fromMap(json['type']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
        assignmentGroup: json['assignmentGroup'] == null ? null : GroupElement.fromMap(json['assignmentGroup']),
        compensation: json['compensation'],
        absenceDays: json['absenceDays'],
        requestNumber: json['requestNumber'],
        distanceWorkingConfirm: json['distanceWorkingConfirm'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        dateFrom: json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
        dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        vacationScheduleRequest: json['vacationScheduleRequest'] == null ? null : VacationScheduleRequest.fromMap(json['vacationScheduleRequest']),
        scheduleStartDate: json['scheduleStartDate'] == null ? null : DateTime.parse(json['scheduleStartDate']),
        scheduleEndDate: json['scheduleEndDate'] == null ? null : DateTime.parse(json['scheduleEndDate']),
        newStartDate: json['newStartDate'] == null ? null : DateTime.parse(json['newStartDate']),
        newEndDate: json['newEndDate'] == null ? null : DateTime.parse(json['newEndDate']),
        periodDateTo: json['periodDateTo'] == null ? null : DateTime.parse(json['periodDateTo']),
        periodDateFrom: json['periodDateFrom'] == null ? null : DateTime.parse(json['periodDateFrom']),
        originalSheet: json['originalSheet'],
        addNextYear: json['addNextYear'],
        reason: json['reason'],
        files: json['files'] == null ? null : List<FileDescriptor>.from(json['files'].map((x) => FileDescriptor.fromMap(x))),
        vacationDay: json['vacationDay'],
        agree: json['agree'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'startTime': startTime ?? '',
        'endTime': endTime ?? '',
        'id': id ?? '',
        'addNextYear': addNextYear ?? false,
        'requestNumber': requestNumber,
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'vacationDay': vacationDay,
        'agree': agree,
        'originalSheet': originalSheet ?? false,
        'distanceWorkingConfirm': distanceWorkingConfirm,
        'acquainted': acquainted ?? false,
        'compensation': compensation,
        'status': status == null ? null : status.toMap(),
        'personGroup': personGroup == null ? null : personGroup.toMapId(),
        'type': type == null ? null : type.toMapId(),
        'dateFrom': dateFrom == null ? null : formatFullRest(dateFrom),
        'dateTo': dateTo == null ? null : formatFullRest(dateTo),
        'absenceDays': absenceDays,
        // "vacationScheduleRequest": vacationScheduleRequest == null
        //     ? null
        //     : vacationScheduleRequest.toMapId(),
        'scheduleStartDate': scheduleStartDate == null ? null : formatFullRest(scheduleStartDate),
        'scheduleEndDate': scheduleEndDate == null ? null : formatFullRest(scheduleEndDate),
        'newStartDate': newStartDate == null ? null : formatFullRest(newStartDate),
        'newEndDate': newEndDate == null ? null : formatFullRest(newEndDate),
        'periodDateFrom': periodDateFrom == null ? null : formatFullRest(periodDateFrom),
        'periodDateTo': periodDateTo == null ? null : formatFullRest(periodDateTo),
        'reason': reason,
        'familiarization': familiarization,
        'files': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap()))
      };
}

class Absence {
  Absence({
    this.entityName,
    this.instanceName,
    this.id,
    this.type,
    this.absenceDays,
    this.personGroup,
    this.dateFrom,
    this.dateTo,
    this.projectStartDate,
    this.projectEndDate,
    this.compensation,
  });

  String entityName;
  String instanceName;
  String id;
  DicAbsenceType type;
  int absenceDays;
  PersonGroup personGroup;
  DateTime dateFrom;
  DateTime dateTo;
  DateTime projectStartDate;
  DateTime projectEndDate;
  bool compensation;

  factory Absence.fromJson(String str) => Absence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Absence.fromMap(Map<String, dynamic> json) => Absence(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        type: json['type'] == null ? null : DicAbsenceType.fromMap(json['type']),
        absenceDays: json['absenceDays'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        dateFrom: json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
        dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
        projectStartDate: json['projectStartDate'] == null ? null : DateTime.parse(json['projectStartDate']),
        projectEndDate: json['projectEndDate'] == null ? null : DateTime.parse(json['projectEndDate']),
        compensation: json['compensation'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'type': type == null ? null : type.toMap(),
        'absenceDays': absenceDays,
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'dateFrom': dateFrom == null ? null : formatFullRest(dateFrom),
        'dateTo': dateTo == null ? null : formatFullRest(dateTo),
        'projectStartDate': projectStartDate == null ? null : formatFullRest(projectStartDate),
        'projectEndDate': projectEndDate == null ? null : formatFullRest(projectEndDate),
        'compensation': compensation,
      };

  Map<String, dynamic> toMapId() => {
        'id': id,
      };
}
