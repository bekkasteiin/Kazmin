import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';

class TsadvBeneficiary {
  String entityName;
  String instanceName;
  String additionalContact;
  String addressForExpats;
  BasePersonGroupExt personGroupChild;
  AbstractDictionary addressKATOCode;
  AbstractDictionary addressType;
  String beneficiaryAddress;
  String beneficiaryJob;
  DateTime birthDate;
  String block;
  String building;
  AbstractDictionary country;
  String firstName;
  String firstNameLatin;
  String flat;
  String id;
  String lastName;
  String lastNameLatin;
  String middleName;
  String postal;
  AbstractDictionary relationshipType;
  String streetName;
  AbstractDictionary streetType;
  String workLocation;

  TsadvBeneficiary({
    this.entityName,
    this.instanceName,
    this.additionalContact,
    this.addressForExpats,
    this.addressKATOCode,
    this.addressType,
    this.beneficiaryAddress,
    this.beneficiaryJob,
    this.birthDate,
    this.block,
    this.building,
    this.country,
    this.firstName,
    this.firstNameLatin,
    this.flat,
    this.id,
    this.lastName,
    this.lastNameLatin,
    this.middleName,
    this.postal,
    this.relationshipType,
    this.streetName,
    this.streetType,
    this.workLocation,
    this.personGroupChild
  });

  static String get entity => 'tsadv\$Beneficiary';

  static String get view => 'beneficiaryView';

  static String get property => 'personGroupParent.id';

  factory TsadvBeneficiary.fromJson(String str) {
    return TsadvBeneficiary.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory TsadvBeneficiary.fromMap(Map<String, dynamic> json) {
    return TsadvBeneficiary(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      additionalContact: json['additionalContact']?.toString(),
      addressForExpats: json['addressForExpats']?.toString(),
      addressKATOCode: json['addressKATOCode'] == null ? null : AbstractDictionary.fromMap(json['addressKATOCode'] as Map<String, dynamic>),
      addressType: json['addressType'] == null ? null : AbstractDictionary.fromMap(json['addressType'] as Map<String, dynamic>),
      personGroupChild: json['personGroupChild'] == null ? null : BasePersonGroupExt.fromMap(json['personGroupChild'] as Map<String, dynamic>),
      beneficiaryAddress: json['beneficiaryAddress']?.toString(),
      beneficiaryJob: json['beneficiaryJob']?.toString(),
      birthDate: json['birthDate'] == null ? null : DateTime.parse(json['birthDate'].toString()),
      block: json['block']?.toString(),
      building: json['building']?.toString(),
      country: json['country'] == null ? null : AbstractDictionary.fromMap(json['country'] as Map<String, dynamic>),
      firstName: json['firstName']?.toString(),
      firstNameLatin: json['firstNameLatin']?.toString(),
      flat: json['flat']?.toString(),
      id: json['id']?.toString(),
      lastName: json['lastName']?.toString(),
      lastNameLatin: json['lastNameLatin']?.toString(),
      middleName: json['middleName']?.toString(),
      postal: json['postalCode']?.toString(),
      relationshipType: json['relationshipType'] == null ? null : AbstractDictionary.fromMap(json['relationshipType'] as Map<String, dynamic>),
      streetName: json['streetName']?.toString(),
      streetType: json['streetType'] == null ? null : AbstractDictionary.fromMap(json['streetType'] as Map<String, dynamic>),
      workLocation: json['workLocation']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'additionalContact': additionalContact,
      'addressForExpats': addressForExpats,
      'addressKATOCode': addressKATOCode?.toMap(),
      'addressType': addressType?.toMap(),
      'personGroupChild': personGroupChild?.toMap(),
      'beneficiaryAddress': beneficiaryAddress,
      'beneficiaryJob': beneficiaryJob,
      'birthDate': formatFullRestNotMilSec(birthDate),
      'block': block,
      'building': building,
      'country': country?.toMap(),
      'firstName': firstName,
      'firstNameLatin': firstNameLatin,
      'flat': flat,
      'id': id,
      'lastName': lastName,
      'lastNameLatin': lastNameLatin,
      'middleName': middleName,
      'postalCode': postal,
      'relationshipType': relationshipType.toMap(),
      'streetName': streetName,
      'streetType': streetType.toMap(),
      'workLocation': workLocation,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
