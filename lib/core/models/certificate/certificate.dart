import 'dart:convert';
import 'dart:developer';
// To parse this JSON data, do
//
//     final certificateRequest = certificateRequestFromMap(jsonString);


import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';

class CertificateRequest extends AbstractBpmRequest {
  @override
  String get getEntityName => EntityNames.certificateRequest;

  @override
  dynamic getFromJson(String string) => CertificateRequest.fromJson(string);

  @override
  String get getProcessDefinitionKey => 'certificateRequest';

  @override
  String get getView => 'portal.certificateRequest-edit';

  CertificateRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.personGroup,
    this.language,
    this.numberOfCopy,
    this.requestNumber,
    this.file,
    this.receivingType,
    this.requestDate,
    this.showSalary,
    this.additionalRequirements,
    this.status,
    this.certificateType,
    //this.hrRole,
    this.placeOfDelivery
  });

  String entityName;
  String instanceName;
  @override
  String id;

  PersonGroup personGroup;
  AbstractDictionary language;

  int numberOfCopy;
  int requestNumber;
  FileDescriptor file;
  AbstractDictionary receivingType;
  DateTime requestDate;
  bool showSalary;
  String additionalRequirements;
  @override
  AbstractDictionary status;
  AbstractDictionary certificateType;
  //User hrRole;
  String placeOfDelivery;

  factory CertificateRequest.fromJson(String str) => CertificateRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CertificateRequest.fromMap(Map<String, dynamic> json) {
    //log('-->> $fName, fromMap ->> map: $json');
    return CertificateRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      language:    json['language'] == null ? null : AbstractDictionary.fromMap(json['language'] as Map<String,dynamic>),
      numberOfCopy: json['numberOfCopy'] == null ? null : int.parse(json['numberOfCopy'].toString()),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      file: json['file'] == null ? null : FileDescriptor.fromMap(json['file'] as Map<String,dynamic>),
      receivingType: json['receivingType'] == null ? null : AbstractDictionary.fromMap(json['receivingType'] as Map<String,dynamic>),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      showSalary:  json['showSalary'],
      additionalRequirements: json['additionalRequirements']?.toString(),
      status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      certificateType: json['certificateType'] == null ? null : AbstractDictionary.fromMap(json['certificateType'] as Map<String, dynamic>),
      //hrRole: json['hrRole'] == null ? null : User.fromMap(json['hrRole']),
    );
  }
  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id ?? '',
    'personGroup': personGroup == null ? null : personGroup.toMapId(),
    'language': language == null ? null : language.toMap(),
    'numberOfCopy': numberOfCopy,
    'requestNumber': requestNumber,
    'file': file == null ? null : file.toMap(),
    'receivingType': receivingType == null ? null : receivingType.toMap(),
    'requestDate': requestDate == null
        ? null
        : "${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}",
    'showSalary': showSalary,
    'additionalRequirements' : additionalRequirements,
    'status': status == null ? null : status.toMap(),
    'certificateType': certificateType == null ? null : certificateType.toMap(),
    //'hrRole': hrRole == null ? null : hrRole.toMap(),
    'placeOfDelivery': null
  }
    ..removeWhere((String key, dynamic value) => value == null);
}