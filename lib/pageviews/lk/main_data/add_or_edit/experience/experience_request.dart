import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/person/person_profile.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/education/contact_request.dart';

class ExperienceRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;
  PersonProfile personProfile;

  String company;
  String location;
  DateTime endMonth;
  String job;
  String personExperience;
  DateTime startMonth;

  ExperienceRequest({
    this.entityName,
    this.instanceName,
    this.requestNumber,
    this.requestDate,
    // this.status,
    this.company,
    this.location,
    this.endMonth,
    this.job,
    this.personExperience,
    this.startMonth,
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

  factory ExperienceRequest.fromJson(String str) {
    return ExperienceRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ExperienceRequest.fromMap(Map<String, dynamic> json) {
    return ExperienceRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      company: json['company']?.toString(),
      location: json['location']?.toString(),
      endMonth: json['endMonth'] == null ? null : DateTime.parse(json['endMonth'].toString()),
      job: json['job']?.toString(),
      personExperience: json['personExperience']?.toString(),
      startMonth: json['startMonth'] == null ? null : DateTime.parse(json['startMonth'].toString()),
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
      'requestNumber': requestNumber,
      'requestDate': requestDate?.toString(),
      'status': status?.toMap(),
      'company': company,
      'location': location,
      'endMonth': formatFullRestNotMilSec(endMonth),
      'job': job,
      'personExperience': personExperience,
      'startMonth': formatFullRestNotMilSec(startMonth),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);

  }
  @override
  String get getProcessDefinitionKey => 'personExperienceRequest';

  @override
  String get getView => 'personExperience.full';

  @override
  String get getEntityName => EntityNames.experienceRequest;

  @override
  dynamic getFromJson(String string) => ExperienceRequest.fromJson(string);
}
