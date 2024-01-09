// To parse this JSON data, do
//
//     final collAgreementPaymentRequest = collAgreementPaymentRequestFromJson(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/person/person.dart';

class CollAgreementPaymentRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  String id;
  AbstractDictionary relationType;
  String updatedBy;
  List<FileDescriptor> files;
  PersonGroup employee;
  double paymentAmount;
  AbstractDictionary paymentType;
  int requestNumber;
  Beneficiary beneficiary;
  DateTime requestDate;
  DateTime updateTs;
  AbstractDictionary status;

  CollAgreementPaymentRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.relationType,
    this.updatedBy,
    this.files,
    this.employee,
    this.paymentAmount,
    this.paymentType,
    this.requestNumber,
    this.beneficiary,
    this.requestDate,
    this.updateTs,
    this.status,
  });

  factory CollAgreementPaymentRequest.fromJson(String str) =>
      CollAgreementPaymentRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CollAgreementPaymentRequest.fromMap(Map<String, dynamic> json) =>
      CollAgreementPaymentRequest(
        entityName: json["_entityName"] == null? null : json["_entityName"].toString(),
        instanceName: json['_instanceName'] == null? null : json['_instanceName'].toString(),
        id: json['id'] == null? null : json['id'].toString(),
        relationType: json["relationType"] == null ? null : AbstractDictionary.fromMap(json["relationType"]),
        updatedBy: json['updatedBy'] == null? null : json['updatedBy'].toString(),
        files: json['attachments'] == null
            ? null
            : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
        employee: json["personGroup"] == null? null : PersonGroup.fromMap(json["personGroup"]),
        paymentAmount: json["paymentAmount"] == null ? null :json["paymentAmount"],
        paymentType: json["paymentType"] == null ? null :AbstractDictionary.fromMap(json["paymentType"]),
        requestNumber: json["requestNumber"] == null ? null :json["requestNumber"],
        beneficiary: json["beneficiary"] == null ? null : Beneficiary.fromMap(json["beneficiary"]),
        requestDate: json["requestDate"] == null ? null : DateTime.parse(json["requestDate"]),
        updateTs: json["updateTs"] == null ? null :DateTime.parse(json["updateTs"]),
        status: json["status"] == null ?null :AbstractDictionary.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? '' : id,
        "relationType": relationType == null ? null : relationType.toMap(),
        "updatedBy": updatedBy ==  null ? null :updatedBy,
        "attachments": files == null ? null : List<dynamic>.from(files.map((FileDescriptor x) => x.toMap())),
        "personGroup": employee  ==  null ? null : employee.toMapId(),
        "paymentAmount": paymentAmount  ==  null ? null :paymentAmount.toInt(),
        "paymentType": paymentType  ==  null ? null :paymentType.toMap(),
        "requestNumber": requestNumber  ==  null ? null :requestNumber,
        "beneficiary": beneficiary  ==  null ? null :beneficiary.toMapId(),
        "requestDate":
        requestDate  ==  null ? null : formatFullRestNotMilSec(requestDate),
        "updateTs": updateTs  ==  null ? null :formatFullRest(updateTs),
        "status": status  ==  null ? null :status.toMap(),
      };

  @override
  String get getEntityName => 'kzm_CollAgreementPaymentRequest';

  @override
  CollAgreementPaymentRequest getFromJson(String rawJson) =>
      CollAgreementPaymentRequest.fromMap(json.decode(rawJson));

  @override
  String get getProcessDefinitionKey => 'collAgreementPaymentRequest';

  @override
  String get getView => 'collAgreementPaymentRequest.edit';
}

class Beneficiary {
  String entityName;
  String instanceName;
  String id;
  PersonGroup personGroupChild;
  AbstractDictionary relationshipType;
  PersonGroup personGroupParent;

  Beneficiary({
    this.entityName,
    this.instanceName,
    this.id,
    this.personGroupChild,
    this.relationshipType,
    this.personGroupParent,
  });

  factory Beneficiary.fromMap(Map<String, dynamic> json) => Beneficiary(
        entityName: json["_entityName"],
        instanceName: json["_instanceName"],
        id: json["id"],
        personGroupChild: PersonGroup.fromMap(json["personGroupChild"]),
        relationshipType: AbstractDictionary.fromMap(json["relationshipType"]),
        personGroupParent: PersonGroup.fromMap(json["personGroupParent"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "_instanceName": instanceName,
        "id": id,
        "personGroupChild": personGroupChild.toMapId(),
        "relationshipType": relationshipType.toMap(),
        "personGroupParent": personGroupParent.toMapId(),
      };
  Map<String, dynamic> toMapId() => {'id': id};
}
