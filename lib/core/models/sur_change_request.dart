import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

class SurChargeRequest extends AbstractBpmRequest {
  @override
  String get getEntityName => 'tsadv_SurChargeRequest';

  @override
  SurChargeRequest getFromJson(String rawJson) => SurChargeRequest.fromMap(json.decode(rawJson));

  @override
  String get getProcessDefinitionKey => 'surChargeRequest';

  @override
  String get getView => 'surchargerequest.view';

  SurChargeRequest({
    String id,
    this.employee,
    this.aidType,
    this.requestNumber,
    this.requestDate,
    this.justification,
    this.status,
    this.aidSum,
    List<FileDescriptor> files,
  }) {
    this.id = id;
    this.files = files;
  }

  @override
  PersonGroup employee;
  AbstractDictionary aidType;
  int requestNumber;
  DateTime requestDate;
  String justification;
  @override
  AbstractDictionary status;
  int aidSum;

  String toJson() => json.encode(toMap());

  factory SurChargeRequest.fromMap(Map<String, dynamic> json) => SurChargeRequest(
      id: json['id'],
      employee: json['employeeName'] == null ? null : PersonGroup.fromMap(json['employeeName']),
      aidType: json['aidType'] == null ? null : AbstractDictionary.fromMap(json['aidType']),
      requestNumber: json['requestNumber'],
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
      justification: json['justification'],
      status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
      aidSum: json['aidSum'] ?? 0,
      files: json['file'] == null ? [] : (json['file'] as List).map((e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),);

  Map<String, dynamic> toMap() => {
        '_entityName': getEntityName,
        'id': id ?? '',
        'employeeName': employee.toMapId(),
        'employee': employee.toMapId(),
        'aidType': aidType.toMap(),
        'requestNumber': requestNumber,
        'requestDate': formatFullRest(requestDate),
        'justification': justification,
        'status': status.toMap(),
        'aidSum': aidSum,
        'file': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap()))
      }
        ..removeWhere((String key, dynamic value) => value == null);
}
