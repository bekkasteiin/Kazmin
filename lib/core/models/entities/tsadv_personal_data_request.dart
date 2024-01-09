/*
"__entityName": "tsadv$PersonalDataRequest"
*/

import 'dart:convert';

import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';

const String fName = 'lib/core/models/entities/tsadv_personal_data_request.dart';

class TsadvPersonalDataRequest {
  String entityName;
  String instanceName;
  List<SysFileDescriptor> attachments;
  String firstName;
  String firstNameLatin;
  String id;
  String lastName;
  String lastNameLatin;
  String middleName;
  String middleNameLatin;
  BasePersonGroupExt personGroup;
  String requestDate;
  int requestNumber;
  TsadvDicRequestStatus status;

  TsadvPersonalDataRequest({
    this.entityName,
    this.instanceName,
    this.attachments,
    this.firstName,
    this.firstNameLatin,
    this.id,
    this.lastName,
    this.lastNameLatin,
    this.middleName,
    this.middleNameLatin,
    this.personGroup,
    this.requestDate,
    this.requestNumber,
    this.status,
  });

  factory TsadvPersonalDataRequest.fromJson(String str) => TsadvPersonalDataRequest.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvPersonalDataRequest.fromMap(Map<String, dynamic> json) {
    return TsadvPersonalDataRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      attachments: (json['attachments'] == null)
          ? <SysFileDescriptor>[]
          : (json['attachments'] as List<dynamic>).map((dynamic i) => SysFileDescriptor.fromMap(i as Map<String, dynamic>)).toList(),
      firstName: json['firstName']?.toString(),
      firstNameLatin: json['firstNameLatin']?.toString(),
      id: json['id']?.toString(),
      lastName: json['lastName']?.toString(),
      lastNameLatin: json['lastNameLatin']?.toString(),
      middleName: json['middleName']?.toString(),
      middleNameLatin: json['middleNameLatin']?.toString(),
      personGroup: json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'firstName': firstName,
      'firstNameLatin': firstNameLatin,
      'id': id,
      'lastName': lastName,
      'lastNameLatin': lastNameLatin,
      'middleName': middleName,
      'middleNameLatin': middleNameLatin,
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'attachments': attachments?.map((SysFileDescriptor e) => e.toMap())?.toList(),
      'personGroup': personGroup?.toMap(),
      'status': status?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
