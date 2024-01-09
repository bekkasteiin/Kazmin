import 'dart:convert';
//import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
//import 'package:kzm/core/models/common_item.dart';
//import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';

import '../../../core/models/entities/other/person_profile.dart';

const String fName = 'lib/pageviews/hr_requests/dismissal/dismissal_request.dart';

class DismissalRequest extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'dismissal-request';
  @override
  String get getView => 'dismissalRequestEdit';
  @override
  String get getEntityName => EntityNames.dismissalRequest;
  @override
  dynamic getFromJson(String string) => DismissalRequest.fromJson(string);
  //String get getViewOld => 'absenceRvdRequest.edit';

  DismissalRequest({
    this.entityName,
    this.instanceName,
    this.dateOfDismissal,
    this.id,
    this.personGroup,
    this.reason,
    this.requestDate,
    this.requestNumber,
    this.status,
    this.attachment,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  DateTime dateOfDismissal;
  @override
  @HiveField(3)
  FileDescriptor attachment;
  @override
  @HiveField(4)
  String id;
  @HiveField(4)
  PersonGroup personGroup;
  @HiveField(5)
  String reason;
  @HiveField(6)
  DateTime requestDate;
  @HiveField(7)
  num requestNumber;
  @override
  @HiveField(7)
  AbstractDictionary status;

  PersonProfile personProfile;

  //bool enableFloatingButton=false;

  factory DismissalRequest.fromJson(String str) =>
      DismissalRequest.fromMap(json.decode(str) as Map<String, dynamic>);

  //String toJson() => json.encode(toMap());
  String toJson() {
    //log('-->> $fName, toJson -->> data: ${json.encode(toMap())}');
    return json.encode(toMap());
  }

  factory DismissalRequest.fromMap(Map<String, dynamic> json) => DismissalRequest(
    entityName: json['_entityName']?.toString(),
    instanceName: json['_instanceName']?.toString(),
    dateOfDismissal: json['dateOfDismissal'] == null ? null : DateTime.parse(json['dateOfDismissal'].toString()),
    attachment: json['employeeFile'] == null ? null : FileDescriptor.fromMap(json['employeeFile'] as Map<String,dynamic>),
    id: json['id']?.toString(),
    personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
    reason: json['reasonForDismissal']?.toString(),
    requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
    requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
    status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'dateOfDismissal': dateOfDismissal == null ? null : formatFullRestNotMilSec(dateOfDismissal),
    //'employeeFile': files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap())),
    'employeeFile': attachment == null ? null : attachment.toMap(),
    'id': id ?? '',
    'personGroup': personGroup == null ? null : personGroup.toMapId(),
    'reasonForDismissal': reason,
    'requestDate': requestDate == null ? null : formatFullRestNotMilSec(requestDate),
    'requestNumber': requestNumber,
    'status': status == null ? null : status.toMap(),
    //'familiarization': familiarization
  };
}