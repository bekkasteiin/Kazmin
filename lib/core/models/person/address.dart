// To parse this JSON data, do
//
//     final address = addressFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

class Address {
  Address({
    this.entityName,
    this.instanceName,
    this.id,
    this.country,
    this.endDate,
    this.cityName,
    this.address,
    this.personGroup,
    this.addressType,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  AbstractDictionary country;
  DateTime endDate;
  String cityName;
  String address;
  PersonGroup personGroup;
  AbstractDictionary addressType;
  DateTime startDate;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        country: json['country'] == null ? null : AbstractDictionary.fromMap(json['country']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        cityName: json['cityName'],
        address: json['address'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        addressType: json['addressType'] == null ? null : AbstractDictionary.fromMap(json['addressType']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() =>
      {'_entityName': entityName, '_instanceName': instanceName, 'id': id};
}
