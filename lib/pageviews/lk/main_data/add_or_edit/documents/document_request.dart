import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/person/person_document.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/documents/document_request.dart';

class PersonDocumentRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  String requestDate;
  int requestNumber;

  // TsadvDicRequestStatus status;
  DicAbsenceType documentType;
  DicAbsenceType issuingAuthority;
  String issuedBy;
  String documentNumber;
  DateTime issueDate;
  DateTime expiredDate;
  PersonDocument editedPersonDocument;

  PersonDocumentRequest({
    this.entityName,
    this.instanceName,
    this.requestDate,
    this.requestNumber,
    // this.status,
    String id,
    List<FileDescriptor> files,
    this.documentNumber,
    this.documentType,
    this.editedPersonDocument,
    this.expiredDate,
    this.issueDate,
    this.issuedBy,
    this.issuingAuthority,
    PersonGroup personGroup,
    AbstractDictionary status,
  }) {
    this.id = id;
    this.files = files;
    employee = personGroup;
    this.status = status;
  }

  factory PersonDocumentRequest.fromJson(String str) => PersonDocumentRequest.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() {
    final String result = json.encode(toMap());
    // log('-->> $fName, PersonDocumentRequest.toJson -->> result: $result');
    return result;
  }

  factory PersonDocumentRequest.fromMap(Map<String, dynamic> json) {
    return PersonDocumentRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      files: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      documentNumber: json['documentNumber']?.toString(),
      documentType: json['documentType'] == null ? null : DicAbsenceType.fromMap(json['documentType'] as Map<String, dynamic>),
      editedPersonDocument: json['editedPersonDocument'] == null ? null : PersonDocument.fromMap(json['editedPersonDocument'] as Map<String, dynamic>),
      expiredDate: json['expiredDate'] == null ? null : DateTime.parse(json['expiredDate'].toString()),
      id: json['id']?.toString(),
      issueDate: json['issueDate'] == null ? null : DateTime.parse(json['issueDate'].toString()),
      issuedBy: json['issuedBy']?.toString(),
      issuingAuthority: json['issuingAuthority'] == null ? null : DicAbsenceType.fromMap(json['issuingAuthority'] as Map<String, dynamic>),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'documentNumber': documentNumber,
      'documentType': documentType?.toMap(),
      'editedPersonDocument': editedPersonDocument?.toMap(),
      'expiredDate': formatFullRestNotMilSec(expiredDate),
      'id': id,
      'issueDate': formatFullRestNotMilSec(issueDate),
      'issuedBy': issuedBy,
      'issuingAuthority': issuingAuthority?.toMap(),
      'personGroup': employee?.toMap(),
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'status': status?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'personDocumentRequest';

  @override
  String get getView => 'portal.my-profile';

  @override
  String get getEntityName => EntityNames.personDocumentRequest;

  @override
  dynamic getFromJson(String string) => PersonDocumentRequest.fromJson(string);
}
