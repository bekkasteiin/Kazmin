import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/tsadv_dic_phone_type.dart';
import 'package:kzm/core/models/entities/tsadv_person_contact.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/contact/contact_request.dart';

class PersonContactRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  String contactValue;
  DateTime startDate;
  DateTime endDate;
  TsadvDicPhoneType phoneType;
  TsadvPersonContact personContact;

  PersonContactRequest({
    this.entityName,
    this.instanceName,
    this.requestNumber,
    this.requestDate,
    // this.status,
    this.contactValue,
    this.startDate,
    this.endDate,
    this.phoneType,
    this.personContact,
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

  factory PersonContactRequest.fromJson(String str) {
    // log('-->> $fName, PersonContactRequest.fromJson -->> str: $str');
    return PersonContactRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    // log('-->> $fName toJson -->> data: ${json.encode(toMap())}');
    return json.encode(toMap());
  }

  factory PersonContactRequest.fromMap(Map<String, dynamic> json) {
    return PersonContactRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      id: json['id']?.toString(),
      files: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      contactValue: json['contactValue']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      phoneType: json['type'] == null ? null : TsadvDicPhoneType.fromMap(json['type'] as Map<String, dynamic>),
      personContact: json['personContact'] == null ? null : TsadvPersonContact.fromMap(json['personContact'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'requestNumber': requestNumber,
      'requestDate': requestDate?.toString(),
      'status': status?.toMap(),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
      'contactValue': contactValue,
      'endDate': formatFullRestNotMilSec(endDate),
      'startDate': formatFullRestNotMilSec(startDate),
      'type': phoneType?.toMap(),
      'personContact': personContact?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'personContactRequest';

  @override
  String get getView => 'portal.my-profile';

  @override
  String get getEntityName => EntityNames.personContactRequest;

  @override
  dynamic getFromJson(String string) => PersonContactRequest.fromJson(string);
}
