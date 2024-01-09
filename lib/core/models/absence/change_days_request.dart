// To parse this JSON data, do
//
//     final changeAbsenceDaysRequest = changeAbsenceDaysRequestFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

class ChangeAbsenceDaysRequest extends AbstractBpmRequest {
  @override
  String getView = 'changeAbsenceDaysRequest.edit';

  @override
  String getProcessDefinitionKey = 'changeAbsenceDaysRequest';

  @override
  String getEntityName = EntityNames.changeAbsenceDaysRequest;

  @override
  dynamic getFromJson(String string) => ChangeAbsenceDaysRequest.fromJson(string);

  ChangeAbsenceDaysRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.newStartDate,
    this.purpose,
    this.employee,
    this.periodEndDate,
    this.requestNumber,
    this.files,
    this.requestDate,
    this.vacation,
    this.periodStartDate,
    // this.familiarization,
    // this.agree,
    this.scheduleEndDate,
    this.scheduleStartDate,
    this.newEndDate,
    this.status,
    this.purposeText,
  }) {
    requireAgreeAndFamiliarization = true;
  }

  String entityName;
  String instanceName;
  @override
  String id;
  DateTime newStartDate;
  AbstractDictionary purpose;
  @override
  PersonGroup employee;
  DateTime periodEndDate;
  int requestNumber;
  @override
  List<FileDescriptor> files;
  DateTime requestDate;
  Absence vacation;
  DateTime periodStartDate;

  // bool familiarization;
  // bool agree;
  DateTime scheduleEndDate;
  DateTime scheduleStartDate;
  DateTime newEndDate;
  @override
  AbstractDictionary status;
  String purposeText;
  int days;
  double balance;

  factory ChangeAbsenceDaysRequest.fromJson(String str) => ChangeAbsenceDaysRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangeAbsenceDaysRequest.fromMap(Map<String, dynamic> map) {
    // log('-->> $fName, ChangeAbsenceDaysRequest.fromMap ->> ${json.encode(map)}');
    return ChangeAbsenceDaysRequest(
      entityName: map['_entityName'],
      instanceName: map['_instanceName'],
      id: map['id'],
      newStartDate: map['newStartDate'] == null ? null : DateTime.parse(map['newStartDate']),
      purpose: map['purpose'] == null ? null : AbstractDictionary.fromMap(map['purpose']),
      employee: map['employee'] == null ? null : PersonGroup.fromMap(map['employee']),
      periodEndDate: map['periodEndDate'] == null ? null : DateTime.parse(map['periodEndDate']),
      requestNumber: map['requestNumber'],
      files: map['files'] == null ? null : List<FileDescriptor>.from(map['files'].map((x) => FileDescriptor.fromMap(x))),
      requestDate: map['requestDate'] == null ? null : DateTime.parse(map['requestDate']),
      vacation: map['vacation'] == null ? null : Absence.fromMap(map['vacation']),
      periodStartDate: map['periodStartDate'] == null ? null : DateTime.parse(map['periodStartDate']),
      // familiarization: map["familiarization"] == null ? null : map["familiarization"],
      // agree: map["agree"] == null ? null : map["agree"],
      scheduleEndDate: map['scheduleEndDate'] == null ? null : DateTime.parse(map['scheduleEndDate']),
      scheduleStartDate: map['scheduleStartDate'] == null ? null : DateTime.parse(map['scheduleStartDate']),
      newEndDate: map['newEndDate'] == null ? null : DateTime.parse(map['newEndDate']),
      status: map['status'] == null ? null : AbstractDictionary.fromMap(map['status']),
      purposeText: map['purposeText'],
    );
  }

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'newStartDate': newStartDate == null ? null : formatFullRest(newStartDate),
        'purpose': purpose == null ? null : purpose.toMap(),
        'employee': employee == null ? null : employee.toMapId(),
        'periodEndDate': periodEndDate == null ? null : formatFullRest(periodEndDate),
        'requestNumber': requestNumber,
        'files': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap())),
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'vacation': vacation == null ? null : vacation.toMapId(),
        'periodStartDate': periodStartDate == null ? null : formatFullRest(periodStartDate),
        // "familiarization": familiarization == null ? null : familiarization,
        // "agree": agree == null ? null : agree,
        'scheduleEndDate': scheduleEndDate == null ? null : formatFullRest(scheduleEndDate),
        'scheduleStartDate': scheduleStartDate == null ? null : formatFullRest(scheduleStartDate),
        'newEndDate': newEndDate == null ? null : formatFullRest(newEndDate),
        'status': status == null ? null : status.toMap(),
        'purposeText': purposeText,
        'agree': agree,
        'familiarization': familiarization,
        // 'agree': agree,
        // 'familiarization': familiarization,
      };
}
