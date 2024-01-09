import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';

class AbsenceRvdRequest extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'absenceRvdRequest';

  @override
  String get getView => 'absenceRvdRequest.edit';

  @override
  String get getEntityName => EntityNames.absenceRvdRequest;

  @override
  dynamic getFromJson(String string) => AbsenceRvdRequest.fromJson(string);

  AbsenceRvdRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.timeOfFinishing,
    this.timeOfStarting,
    this.purpose,
    this.purposeText,
    this.absencePurpose,
    this.totalHours,
    this.type,
    this.requestNumber,
    this.requestDate,
    this.employee,
    this.vacationDay,
    this.agree,
    this.acquainted,
    this.files,
    this.compensation,
    this.status,
  });

  String entityName;
  String instanceName;
  @override
  String id;
  String purposeText;
  DateTime timeOfFinishing;
  DateTime timeOfStarting;
  Purpose purpose;
  Purpose absencePurpose;
  int totalHours;
  @override
  DicAbsenceType type;
  int requestNumber;
  DateTime requestDate;
  @override
  PersonGroup employee;
  bool vacationDay;
  @override
  bool agree;
  bool acquainted;
  @override
  List<FileDescriptor> files;
  bool compensation;
  @override
  AbstractDictionary status;

  factory AbsenceRvdRequest.fromJson(String str) => AbsenceRvdRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbsenceRvdRequest.fromMap(Map<String, dynamic> json) => AbsenceRvdRequest(
        entityName: json['_entityName'],
        purposeText: json['purposeText'],
        instanceName: json['_instanceName'],
        id: json['id'] ?? '',
        timeOfFinishing: json['timeOfFinishing'] == null ? null : DateTime.parse(json['timeOfFinishing']),
        timeOfStarting: json['timeOfStarting'] == null ? null : DateTime.parse(json['timeOfStarting']),
        purpose: json['purpose'] == null ? null : Purpose.fromMap(json['purpose']),
        absencePurpose: json['absencePurpose'] == null ? null : Purpose.fromMap(json['absencePurpose']),
        totalHours: json['totalHours'],
        type: json['type'] == null ? null : DicAbsenceType.fromMap(json['type']),
        requestNumber: json['requestNumber'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        employee: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        vacationDay: json['vacationDay'] ?? false,
        agree: json['agree'],
        acquainted: json['acquainted'] ?? false,
        files: json['files'] == null ? null : List<FileDescriptor>.from(json['files'].map((x) => FileDescriptor.fromMap(x))),
        compensation: json['compensation'] ?? false,
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'timeOfFinishing': timeOfFinishing == null ? null : formatFullRest(timeOfFinishing),
        'timeOfStarting': timeOfStarting == null ? null : formatFullRest(timeOfStarting),
        'purpose': purpose == null ? null : purpose.toMap(),
        'absencePurpose': absencePurpose == null ? null : absencePurpose.toMap(),
        'totalHours': totalHours,
        'type': type == null ? null : type.toMap(),
        'purposeText': purposeText,
        'requestNumber': requestNumber,
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'personGroup': employee == null ? null : employee.toMapId(),
        'vacationDay': vacationDay ?? false,
        'agree': agree,
        'acquainted': acquainted ?? false,
        'files': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap())),
        'compensation': compensation ?? false,
        'status': status == null ? null : status.toMap(),
      }
        ..removeWhere((String key, dynamic value) => value == null);
}
