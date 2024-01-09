// To parse this JSON data, do
//
//     final courseShedules = courseShedulesFromMap(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

class CourseSchedule {
  CourseSchedule({
    this.id,
    this.nameLang1,
    this.nameLang2,
    this.nameLang3,
    this.personGroupId,
    this.fullNameNumberCyrillic,
    this.fullNameNumberLatin,
    this.duration,
    this.startDate,
    this.endDate,
    this.registrationIsOpenUntil,
    this.placesLeft,
    this.addressRu,
    this.addressEn,
    this.status,
    this.statusRu,
    this.statusEn,
    this.instanceName,
  });

  String id;
  String nameLang1;
  String nameLang2;
  String nameLang3;
  String instanceName;
  String personGroupId;
  String fullNameNumberCyrillic;
  String fullNameNumberLatin;
  double duration;
  DateTime startDate;
  DateTime endDate;
  DateTime registrationIsOpenUntil;
  int placesLeft;
  String addressRu;
  String addressEn;
  int status;
  String statusRu;
  String statusEn;

  factory CourseSchedule.fromJson(String str) =>
      CourseSchedule.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory CourseSchedule.fromMap(Map<String, dynamic> json) => CourseSchedule(
        id: json['id'].toString(),
        nameLang1: json['name_lang1'].toString(),
        nameLang2: json['name_lang2'].toString(),
        nameLang3: json['name_lang3'].toString(),
        instanceName: json['_instanceName'].toString(),
        personGroupId: json['person_group_id'].toString(),
        fullNameNumberCyrillic: json['full_name_number_cyrillic']?.toString(),
        fullNameNumberLatin: json['full_name_number_latin'].toString(),
        duration: json['duration'] != null ? double.parse(json['duration'].toString()) : null,
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'].toString())
            : json['startDate'] != null
                ? DateTime.parse(json['startDate'].toString())
                : null,
        endDate: json['end_date'] != null
            ? DateTime.parse(json['end_date'].toString())
            : json['endDate'] != null
                ? DateTime.parse(json['endDate'].toString())
                : null,
        registrationIsOpenUntil: json['registration_is_open_until'] != null
            ? DateFormat('dd.MM.yyyy').parse(json['registration_is_open_until']?.toString())
            : null,
        placesLeft: json['places_left'] != null ? int.parse(json['places_left']?.toString()) : null,
        addressRu: json['address_ru']?.toString(),
        addressEn: json['address_en']?.toString(),
        status: json['status'] != null ? int.parse(json['status'].toString()) : null,
        statusRu: json['status_ru']?.toString(),
        statusEn: json['status_en']?.toString(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name_lang1': nameLang1,
        'name_lang2': nameLang2,
        'name_lang3': nameLang3,
        'person_group_id': personGroupId,
        'full_name_number_cyrillic': fullNameNumberCyrillic,
        'full_name_number_latin': fullNameNumberLatin,
        'duration': duration,
        'start_date':
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'registration_is_open_until':
            "${DateFormat("dd.MM.yyyy").parse(registrationIsOpenUntil.toString())}",
        'places_left': placesLeft,
        'address_ru': addressRu,
        'address_en': addressEn,
        'status': status,
        'status_ru': statusRu,
        'status_en': statusEn,
      };
}

class CourseShedulesResponse {
  CourseShedulesResponse({
    this.type,
    this.value,
  });

  String type;
  String value;

  factory CourseShedulesResponse.fromJson(String str) =>
      CourseShedulesResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory CourseShedulesResponse.fromMap(Map<String, dynamic> json) => CourseShedulesResponse(
        type: json['type'].toString(),
        value: json['value'].toString(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'type': type,
        'value': value,
      };
}
