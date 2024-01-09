import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/hr_requests/ovd/ovd_request.dart';

class OvdRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  DateTime endDate;
  int requestNumber;
  DateTime requestDate;
  DateTime startTime;
  String justification;
  String updatedBy;
  PersonGroup personGroup;
  int days;
  double hours;
  DateTime endTime;
  DateTime startDate;

  OvdRequest({
    this.entityName,
    this.instanceName,
    this.requestDate,
    this.requestNumber,
    this.endDate,
    this.startTime,
    this.justification,
    this.updatedBy,
    this.personGroup,
    this.days,
    this.hours,
    this.endTime,
    this.startDate,
    String id,
    List<FileDescriptor> files,
    AbstractDictionary status,
  }) {
    this.id = id;
    this.files = files;
    this.status = status;
  }

  factory OvdRequest.fromJson(String str) {
    // log('-->> $fName, fromJson ->> str: $str');
    return OvdRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory OvdRequest.fromMap(Map<String, dynamic> map) {
    // log('-->> $fName, fromMap ->> map: $map');
    return OvdRequest(
      entityName: map['_entityName']?.toString(),
      instanceName: map['_instanceName']?.toString(),
      requestDate: map['requestDate'] == null ? null : DateTime.parse(map['requestDate'].toString()),
      requestNumber: map['requestNumber'] == null ? null : int.parse(map['requestNumber'].toString()),
      endDate: map['endDate'] == null ? null : DateTime.parse(map['endDate'].toString()),
      startTime: map['startTime'] == null ? null : DateTime.parse('0000-00-00 ${map['startTime'].toString()}'),
      justification: map['justification']?.toString(),
      updatedBy: map['updatedBy']?.toString(),
      personGroup: map['personGroup'] == null ? null : PersonGroup.fromMap(map['personGroup'] as Map<String, dynamic>),
      days: map['days'] == null ? null : int.parse(map['days'].toString()),
      hours: map['hours'] == null ? null : double.parse(map['hours'].toString()),
      endTime: map['endTime'] == null ? null : DateTime.parse('0000-00-00 ${map['endTime'].toString()}'),
      startDate: map['startDate'] == null ? null : DateTime.parse(map['startDate'].toString()),
      id: map['id']?.toString(),
      files: map['files'] == null ? null : (map['files'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      status: map['status'] == null ? null : AbstractDictionary.fromMap(map['status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'endDate': formatFullRestNotMilSec(endDate),
      'startTime': formatTimeRest(startTime),
      'justification': justification,
      'updatedBy': updatedBy,
      'personGroup': personGroup?.toMap(),
      'days': days,
      'hours': hours,
      'endTime': formatTimeRest(endTime),
      'startDate': formatFullRestNotMilSec(startDate),
      'id': id,
      'files': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'status': status?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getEntityName => EntityNames.ovdRequest;

  @override
  dynamic getFromJson(String string) => OvdRequest.fromJson(string);

  @override
  String get getProcessDefinitionKey => 'absenceRvdRequest';

  @override
  String get getView => 'trainingOnADayOffRequest.edit';

}
