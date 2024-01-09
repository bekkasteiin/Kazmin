import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_dic_education_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_form_study.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/education/contact_request.dart';

class EducationRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  String diplomaNumber;
  BaseDicEducationType educationType;
  int endYear;
  String faculty;
  bool foreignEducation;
  TsadvDicFormStudy formStudy;
  String qualification;
  String school;
  String specialization;
  int startYear;

  EducationRequest({
    this.entityName,
    this.instanceName,
    this.requestNumber,
    this.requestDate,
    this.diplomaNumber,
    this.educationType,
    this.endYear,
    this.faculty,
    this.foreignEducation,
    this.formStudy,
    this.qualification,
    this.school,
    this.specialization,
    this.startYear,
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

  factory EducationRequest.fromJson(String str) {
    return EducationRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory EducationRequest.fromMap(Map<String, dynamic> json) {
    return EducationRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      diplomaNumber: json['diplomaNumber']?.toString(),
      educationType: json['educationType'] == null ? null : BaseDicEducationType.fromMap(json['educationType'] as Map<String, dynamic>),
      endYear: json['endYear'] == null ? null : int.parse(json['endYear'].toString()),
      faculty: json['faculty']?.toString(),
      foreignEducation: json['foreignEducation'] == null ? null : json['foreignEducation'] as bool,
      formStudy: json['formStudy'] == null ? null : TsadvDicFormStudy.fromMap(json['formStudy'] as Map<String, dynamic>),
      qualification: json['qualification']?.toString(),
      school: json['school']?.toString(),
      specialization: json['specialization']?.toString(),
      startYear: json['startYear'] == null ? null : int.parse(json['startYear'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
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
      'diplomaNumber': diplomaNumber,
      'educationType': educationType?.toMap(),
      'endYear': endYear,
      'faculty': faculty,
      'foreignEducation': foreignEducation,
      'formStudy': formStudy?.toMap(),
      'qualification': qualification,
      'school': school,
      'specialization': specialization,
      'startYear': startYear,
      'status': status?.toMap(),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'personEducationRequest';

  @override
  String get getView => 'personEducation.full';

  @override
  String get getEntityName => EntityNames.educationRequest;

  @override
  dynamic getFromJson(String string) => EducationRequest.fromJson(string);
}
