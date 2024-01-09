import 'dart:convert';
import 'dart:developer';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_request.dart';

class PersonOtherInfoRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  BasePersonExt entityData;

  PersonOtherInfoRequest({
    this.entityName,
    this.instanceName,
    this.requestNumber,
    this.requestDate,
    // this.status,
    this.entityData,
    String id,
    List<FileDescriptor> files,
    PersonGroup personGroup,
    AbstractDictionary status,
  }) {
    this.id = id;
    this.files = files;
    employee = personGroup;
    this.status = status;
  }

  factory PersonOtherInfoRequest.fromJson(String str) {
    return PersonOtherInfoRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    log('-->> $fName, toJson -->> data: ${json.encode(toMap())}');
    return json.encode(toMap());
  }

  factory PersonOtherInfoRequest.fromMap(Map<String, dynamic> json) {
    return PersonOtherInfoRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      id: json['id']?.toString(),
      files: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      entityData: BasePersonExt.fromMap(json)
        ..id = ((json['militaryForm'] != null) && (json['militaryForm']['id'] != null)) ? json['militaryForm']['id']?.toString() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'id': id ??'',
      'personGroup': PersonGroup(id: employee?.id).toMap(),
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'status': TsadvDicRequestStatus(id: status?.id).toMap(),
      'childUnder18WithoutFatherOrMother': entityData?.childUnder18WithoutFatherOrMother,
      'childUnder14WithoutFatherOrMother': entityData?.childUnder14WithoutFatherOrMother,
    };
  }

  @override
  String get getProcessDefinitionKey => 'personOtherInfoRequest';

  @override
  String get getView => 'personOtherInfoRequest.edit';

  @override
  String get getEntityName => EntityNames.personOtherInfoRequest;

  @override
  dynamic getFromJson(String string) => PersonOtherInfoRequest.fromJson(string);
}
