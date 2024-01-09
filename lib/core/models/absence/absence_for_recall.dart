// To parse this JSON data, do
//
//     final absenceForRecall = absenceForRecallFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';

class AbsenceForRecall extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'absenceForRecallRequest';

  @override
  // TODO: implement view
  String get getView => 'absenceForRecall.edit';

  @override
  String get getEntityName => EntityNames.absenceForRecall;

  @override
  AbsenceForRecall getFromJson(String string) => AbsenceForRecall.fromJson(string);

  AbsenceForRecall({
    this.entityName,
    this.instanceName,
    this.id,
    this.employee,
    this.requestNumber,
    this.isAgree,
    this.files,
    this.requestDate,
    this.vacation,
    this.compensationPayment,
    this.recallDateTo,
    this.leaveOtherTime,
    this.isFamiliarization,
    this.recallDateFrom,
    this.absenceType,
    this.status,
    this.dateTo,
    this.dateFrom,
    this.purpose,
    this.purposeText,
  }) {
    requireAgreeAndFamiliarization = true;
  }

  String entityName;
  String instanceName;
  @override
  String id;
  @override
  PersonGroup employee;
  int requestNumber;
  bool isAgree;
  @override
  List<FileDescriptor> files;
  DateTime requestDate;
  Absence vacation;
  bool compensationPayment;
  DateTime recallDateTo;
  bool leaveOtherTime;
  bool isFamiliarization;
  DateTime recallDateFrom;
  DateTime dateFrom;
  DateTime dateTo;
  DicAbsenceType absenceType;
  @override
  AbstractDictionary status;
  AbstractDictionary purpose;
  String purposeText;

  factory AbsenceForRecall.fromJson(String str) => AbsenceForRecall.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbsenceForRecall.fromMap(Map<String, dynamic> json) => AbsenceForRecall(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        purposeText: json['purposeText'],
        id: json['id'],
        employee: json['employee'] == null ? null : PersonGroup.fromMap(json['employee']),
        requestNumber: json['requestNumber'],
        isAgree: json['isAgree'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        vacation: json['vacation'] == null ? null : Absence.fromMap(json['vacation']),
        compensationPayment: json['compensationPayment'],
        recallDateTo: json['recallDateTo'] == null ? null : DateTime.parse(json['recallDateTo']),
        leaveOtherTime: json['leaveOtherTime'],
        isFamiliarization: json['isFamiliarization'],
        recallDateFrom: json['recallDateFrom'] == null ? null : DateTime.parse(json['recallDateFrom']),
        dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
        dateFrom: json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
        absenceType: json['absenceType'] == null ? null : DicAbsenceType.fromMap(json['absenceType']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
        purpose: json['purpose'] == null ? null : AbstractDictionary.fromMap(json['purpose']),
        files: json['files'] == null ? null : List<FileDescriptor>.from(json['files'].map((x) => FileDescriptor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'employee': employee == null ? null : employee.toMapId(),
        'requestNumber': requestNumber,
        'isAgree': isAgree,
        'files': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap())),
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'vacation': vacation == null ? null : vacation.toMapId(),
        'compensationPayment': compensationPayment,
        'recallDateTo': recallDateTo == null ? null : formatFullRest(recallDateTo),
        'leaveOtherTime': leaveOtherTime,
        'isFamiliarization': isFamiliarization,
        'recallDateFrom': recallDateFrom == null ? null : formatFullRest(recallDateFrom),
        'dateTo': dateTo == null ? null : formatFullRest(dateTo),
        'dateFrom': dateFrom == null ? null : formatFullRest(dateFrom),
        'absenceType': absenceType == null ? null : absenceType.toMap(),
        'status': status == null ? null : status.toMap(),
        'purposeText': purposeText,
        'purpose': purpose == null ? null : purpose.toMap(),
        'agree': agree,
        'familiarization': familiarization,
      }..removeWhere((String key, dynamic value) => value == null);
}
