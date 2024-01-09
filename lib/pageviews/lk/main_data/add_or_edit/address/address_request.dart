import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_dic_country.dart';
import 'package:kzm/core/models/entities/tsadv_address.dart';
import 'package:kzm/core/models/entities/tsadv_dic_address_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kato.dart';
import 'package:kzm/core/models/entities/tsadv_dic_street_type.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/address/address_request.dart';

class AddressRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  String addressEnglish;
  String addressForExpats;
  String addressKazakh;
  TsadvDicAddressType addressType;
  String block;
  String building;
  String comment;
  BaseDicCountry country;
  DateTime endDate;
  String flat;
  TsadvDicKato kato;
  String postalCode;
  String requestDate;
  int requestNumber;
  DateTime startDate;

  // TsadvDicRequestStatus status;
  String streetName;
  TsadvDicStreetType streetType;
  TsadvAddress baseAddress;

  AddressRequest({
    this.entityName,
    this.instanceName,
    this.addressEnglish,
    this.addressForExpats,
    this.addressKazakh,
    this.addressType,
    this.block,
    this.building,
    this.comment,
    this.country,
    this.endDate,
    this.flat,
    this.kato,
    this.postalCode,
    this.requestDate,
    this.requestNumber,
    this.startDate,
    // this.status,
    this.streetName,
    this.streetType,
    this.baseAddress,
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

  factory AddressRequest.fromJson(String str) {
    return AddressRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory AddressRequest.fromMap(Map<String, dynamic> json) {
    return AddressRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      addressEnglish: json['addressEnglish']?.toString(),
      addressForExpats: json['addressForExpats']?.toString(),
      addressKazakh: json['addressKazakh']?.toString(),
      addressType: json['addressType'] == null ? null : TsadvDicAddressType.fromMap(json['addressType'] as Map<String, dynamic>),
      block: json['block']?.toString(),
      building: json['building']?.toString(),
      comment: json['comment']?.toString(),
      country: json['country'] == null ? null : BaseDicCountry.fromMap(json['country'] as Map<String, dynamic>),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      flat: json['flat']?.toString(),
      kato: json['kato'] == null ? null : TsadvDicKato.fromMap(json['kato'] as Map<String, dynamic>),
      postalCode: json['postalCode']?.toString(),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      streetName: json['streetName']?.toString(),
      streetType: json['streetType'] == null ? null : TsadvDicStreetType.fromMap(json['streetType'] as Map<String, dynamic>),
      baseAddress: json['baseAddress'] == null ? null : TsadvAddress.fromMap(json['baseAddress'] as Map<String, dynamic>),
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
      'addressEnglish': addressEnglish,
      'addressForExpats': addressForExpats,
      'addressKazakh': addressKazakh,
      'addressType': addressType?.toMap(),
      'block': block,
      'building': building,
      'comment': comment,
      'country': country?.toMap(),
      'endDate': formatFullRestNotMilSec(endDate),
      'flat': flat,
      'kato': kato?.toMap(),
      'postalCode': postalCode,
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'startDate': formatFullRestNotMilSec(startDate),
      'status': status?.toMap(),
      'streetName': streetName,
      'streetType': streetType?.toMap(),
      'baseAddress': baseAddress?.toMap(),
      'id': id,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
    }
      ..removeWhere((String key, dynamic value) => value == null);
  }
  @override
  String get getProcessDefinitionKey => 'addressRequest';

  @override
  String get getView => 'portal.my-profile';

  @override
  String get getEntityName => EntityNames.addressRequest;

  @override
  dynamic getFromJson(String string) => AddressRequest.fromJson(string);
}
