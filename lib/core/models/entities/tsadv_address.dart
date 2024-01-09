import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_dic_country.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/entities/tsadv_dic_address_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kato.dart';
import 'package:kzm/core/models/entities/tsadv_dic_street_type.dart';

class TsadvAddress {
  String entityName;
  String instanceName;
  String addressEnglish;
  String addressForExpats;
  String addressKazakh;
  String block;
  String building;
  DateTime endDate;
  String flat;
  String id;
  String legacyId;
  String postalCode;
  DateTime startDate;
  String streetName;
  String comment;
  BaseDicCountry country;
  List<SysFileDescriptor> attachments;
  TsadvDicStreetType streetType;
  TsadvDicKato kato;
  BasePersonGroupExt personGroup;
  TsadvDicAddressType addressType;

  TsadvAddress({
    this.entityName,
    this.instanceName,
    this.addressEnglish,
    this.addressForExpats,
    this.addressKazakh,
    this.block,
    this.building,
    this.endDate,
    this.flat,
    this.id,
    this.legacyId,
    this.postalCode,
    this.startDate,
    this.streetName,
    this.comment,
    this.country,
    this.attachments,
    this.streetType,
    this.kato,
    this.personGroup,
    this.addressType,
  });

  static String get entity => 'tsadv\$Address';

  static String get view => 'portal.my-profile';

  static String get property => 'personGroup.id';

  factory TsadvAddress.fromJson(String str) {
    return TsadvAddress.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvAddress.fromMap(Map<String, dynamic> json) {
    return TsadvAddress(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      addressEnglish: json['addressEnglish']?.toString(),
      addressForExpats: json['addressForExpats']?.toString(),
      addressKazakh: json['addressKazakh']?.toString(),
      block: json['block']?.toString(),
      building: json['building']?.toString(),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'].toString()),
      flat: json['flat']?.toString(),
      id: json['id']?.toString(),
      legacyId: json['legacyId']?.toString(),
      postalCode: json['postalCode']?.toString(),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'].toString()),
      streetName: json['streetName']?.toString(),
      comment: json['comment']?.toString(),
      country: json['country'] == null ? null : BaseDicCountry.fromMap(json['country'] as Map<String, dynamic>),
      attachments: (json['attachments'] == null)
          ? <SysFileDescriptor>[]
          : (json['attachments'] as List<dynamic>).map((dynamic i) => SysFileDescriptor.fromMap(i as Map<String, dynamic>)).toList(),
      streetType: json['streetType'] == null ? null : TsadvDicStreetType.fromMap(json['streetType'] as Map<String, dynamic>),
      kato: json['kato'] == null ? null : TsadvDicKato.fromMap(json['kato'] as Map<String, dynamic>),
      personGroup: json['personGroup'] == null ? null : BasePersonGroupExt.fromMap(json['personGroup'] as Map<String, dynamic>),
      addressType: json['addressType'] == null ? null : TsadvDicAddressType.fromMap(json['addressType'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'addressEnglish': addressEnglish,
      'addressForExpats': addressForExpats,
      'addressKazakh': addressKazakh,
      'block': block,
      'building': building,
      'endDate': formatFullRestNotMilSec(endDate),
      'flat': flat,
      'id': id,
      'legacyId': legacyId,
      'postalCode': postalCode,
      'startDate': formatFullRestNotMilSec(startDate),
      'streetName': streetName,
      'comment': comment,
      'country': country?.toMap(),
      'attachments': attachments?.map((SysFileDescriptor e) => e.toMap())?.toList(),
      'streetType': streetType?.toMap(),
      'kato': kato?.toMap(),
      'personGroup': personGroup?.toMap(),
      'addressType': addressType?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
