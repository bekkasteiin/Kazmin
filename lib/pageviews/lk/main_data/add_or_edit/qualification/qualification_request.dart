import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/tsadv_dic_education_document_type.dart';
import 'package:kzm/core/models/entities/tsadv_person_qualification.dart';
import 'package:kzm/core/models/person/person.dart';

class QualificationRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  String requestDate;
  int requestNumber;

  // TsadvDicRequestStatus status;

  String courseName;
  String diploma;
  TsadvDicEducationDocumentType educationDocumentType;
  String educationalInstitutionName;
  DateTime endDate;
  DateTime expiryDate;
  DateTime issuedDate;
  String profession;
  String qualification;
  DateTime startDate;
  TsadvPersonQualification personQualification;

  QualificationRequest({
    this.entityName,
    this.instanceName,
    this.requestDate,
    this.requestNumber,
    // this.status,
    this.courseName,
    this.diploma,
    this.educationDocumentType,
    this.educationalInstitutionName,
    this.endDate,
    this.expiryDate,
    this.issuedDate,
    this.profession,
    this.qualification,
    this.startDate,
    this.personQualification,
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

  factory QualificationRequest.fromJson(String str) {
    return QualificationRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory QualificationRequest.fromMap(Map<String, dynamic> json) {
    return QualificationRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      courseName: json['courseName']?.toString(),
      diploma: json['diploma']?.toString(),
      educationDocumentType:
          json['educationDocumentType'] == null ? null : TsadvDicEducationDocumentType.fromMap(json['educationDocumentType'] as Map<String, dynamic>),
      educationalInstitutionName: json['educationalInstitutionName']?.toString(),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      expiryDate: json['expiryDate'] == null ? null : DateTime.parse(json['expiryDate'].toString()),
      issuedDate: json['issuedDate'] == null ? null : DateTime.parse(json['issuedDate'].toString()),
      profession: json['profession']?.toString(),
      qualification: json['qualification']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      personQualification: json['personQualification'] == null ? null : TsadvPersonQualification.fromMap(json['personQualification'] as Map<String, dynamic>),
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
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'status': status?.toMap(),
      'courseName': courseName,
      'diploma': diploma,
      'educationDocumentType': educationDocumentType?.toMap(),
      'educationalInstitutionName': educationalInstitutionName,
      'endDate': formatFullRestNotMilSec(endDate),
      'expiryDate': formatFullRestNotMilSec(expiryDate),
      'issuedDate': formatFullRestNotMilSec(issuedDate),
      'profession': profession,
      'qualification': qualification,
      'startDate': formatFullRestNotMilSec(startDate),
      'personQualification': personQualification?.toMap(),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
    }
      ..removeWhere((String key, dynamic value) => value == null);
  }
  @override
  String get getProcessDefinitionKey => 'personQualificationRequest';

  @override
  String get getView => 'personQualificationRequest.edit';

  @override
  String get getEntityName => EntityNames.qualificationRequest;

  @override
  dynamic getFromJson(String string) => QualificationRequest.fromJson(string);
}
