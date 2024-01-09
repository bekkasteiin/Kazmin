import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/other/person_profile.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request.dart';

class PersonalDataRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  String firstName;
  String firstNameLatin;
  String lastName;
  String lastNameLatin;
  String middleName;
  String middleNameLatin;
  String requestDate;
  int requestNumber;
  // TsadvDicRequestStatus status;
  BasePersonExt personExt;
  PersonProfile profile;
  AbstractDictionary maritalStatus;

  PersonalDataRequest({
    this.entityName,
    this.instanceName,
    this.firstName,
    this.firstNameLatin,
    this.lastName,
    this.lastNameLatin,
    this.middleName,
    this.middleNameLatin,
    this.requestDate,
    this.requestNumber,
    this.maritalStatus,
    // this.status,
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

  factory PersonalDataRequest.fromJson(String str) {
    return PersonalDataRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    final String _tmp = json.encode(toMap());
    // log('-->> $fName, toJson -->> $_tmp');
    return _tmp;
  }

  factory PersonalDataRequest.fromMap(Map<String, dynamic> json) {
    return PersonalDataRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      firstName: json['firstName']?.toString(),
      firstNameLatin: json['firstNameLatin']?.toString(),
      lastName: json['lastName']?.toString(),
      lastNameLatin: json['lastNameLatin']?.toString(),
      middleName: json['middleName']?.toString(),
      middleNameLatin: json['middleNameLatin']?.toString(),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      maritalStatus: json['maritalStatus'] == null ? null: AbstractDictionary.fromMap(json['maritalStatus'] as Map<String, dynamic>),
      id: json['id']?.toString(),
      files: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'firstName': firstName,
      'firstNameLatin': firstNameLatin,
      'lastName': lastName,
      'lastNameLatin': lastNameLatin,
      'middleName': middleName,
      'middleNameLatin': middleNameLatin,
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'status': status?.toMap(),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
      'maritalStatus': maritalStatus?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'personalDataRequest';

  @override
  String get getView => 'personalDataRequest-edit';

  @override
  String get getEntityName => EntityNames.personalDataRequest;

  @override
  dynamic getFromJson(String string) => PersonalDataRequest.fromJson(string);
}
