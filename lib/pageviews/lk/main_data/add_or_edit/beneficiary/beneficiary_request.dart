import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/tsadv_beneficiary.dart';
import 'package:kzm/core/models/person/person.dart';

class BeneficiaryRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  String firstName;
  String lastName;
  String middleName;
  String firstNameLatin;
  String additionalContact;
  String workLocation;
  String lastNameLatin;
  String postal;
  AbstractDictionary addressKATOCode;
  PersonGroup personGroupChild;
  DateTime birthDate;
  @override
  AbstractDictionary status;

  TsadvBeneficiary entityData;

  BeneficiaryRequest({
    this.firstName,
    this.lastName,
    this.middleName,
    this.workLocation,
    this.firstNameLatin,
    this.birthDate,
    this.lastNameLatin,
    this.addressKATOCode,
    this.entityName,
    this.instanceName,
    this.personGroupChild,
    this.additionalContact,
    this.requestNumber,
    this.requestDate,
    this.status,
    this.entityData,
    this.postal,
    String id,
    List<FileDescriptor> files,
    PersonGroup personGroup,
    PersonGroup personGroupParent,
  }) {
    this.id = id;
    this.files = files;
    employee = personGroup;
    employee = personGroupParent;
  }

  factory BeneficiaryRequest.fromJson(String str) {
    // log('-->> $fName, BeneficiaryRequest.fromJson -->> str: $str');
    return BeneficiaryRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    // log('-->> json -->> ${json.encode(toMap())}');
    return json.encode(toMap());
  }

  factory BeneficiaryRequest.fromMap(Map<String, dynamic> json) {
    return BeneficiaryRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      additionalContact: json['additionalContact']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      entityData: TsadvBeneficiary.fromMap(json)
        ..id = ((json['beneficiary'] != null) && (json['beneficiary']['id'] != null)) ? json['beneficiary']['id']?.toString() : null,
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      middleName: json['middleName']?.toString(),
      lastNameLatin: json['lastNameLatin']?.toString(),
      firstNameLatin: json['firstNameLatin']?.toString(),
      birthDate: json['birthDate'] == null ? null : DateTime.parse(json['birthDate'].toString()),
      addressKATOCode: json['addressKatoCode'] == null ? null : AbstractDictionary.fromMap(json['addressKatoCode'] as Map<String, dynamic>),
      workLocation: json['workLocation']?.toString(),
      postal: json['postal']?.toString(),
      files: json['files'] == null ? null : (json['files'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      personGroupParent: json['personGroupParent'] == null ? null : PersonGroup.fromMap(json['personGroupParent'] as Map<String, dynamic>),
      personGroupChild: json['personGroupChild'] == null ? null : PersonGroup.fromMap(json['personGroupChild'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'additionalContact': entityData?.additionalContact,
      'addressForExpats': entityData?.addressForExpats,
      'addressKatoCode': null,
      'addressType': entityData?.addressType?.toMap(),
      'beneficiary': entityData?.id == null ? null : entityData.toMap(),
      'birthDate': formatFullRestNotMilSec(entityData?.birthDate),
      'block': entityData?.block,
      'building': entityData?.building,
      'country': entityData?.country?.toMap(),
      'files': files.map((FileDescriptor e) => e.toMap()).toList(),
      'firstName': entityData?.firstName,
      'firstNameLatin': entityData?.firstNameLatin,
      'flat': entityData?.flat,
      'id': id,
      'lastName': entityData?.lastName,
      'lastNameLatin': entityData?.lastNameLatin,
      'middleName': entityData?.middleName,
      'personGroup': PersonGroup(id: employee?.id).toMap(),
      'personGroupParent': PersonGroup(id: employee?.id).toMap(),
      'personGroupChild': personGroupChild== null ? null :PersonGroup(id: personGroupChild?.id).toMap(),
      'postal': entityData?.postal,
      'relationshipType': entityData?.relationshipType?.toMap(),
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'status': status?.toMap(),
      'streetName': entityData?.streetName,
      'streetType': entityData?.streetType?.toMap(),
      'workLocation': workLocation,
    }..removeWhere((String key, dynamic value) => value == null);

  }
  @override
  String get getProcessDefinitionKey => 'beneficiaryRequest';

  @override
  String get getView => 'beneficiaryRequest-for-integration';

  @override
  String get getEntityName => EntityNames.beneficiaryRequest;

  @override
  dynamic getFromJson(String string) => BeneficiaryRequest.fromJson(string);
}
