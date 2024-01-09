import 'dart:convert';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Medal {
  Medal({
    this.entityName,
    this.instanceName,
    this.id,
    this.langName3,
    this.langName1,
    this.langName2,
    this.expiredYears,
    this.icon,
    this.sort,
    this.type,
    this.defaultMedal,
  });

  String entityName;
  String instanceName;
  String id;
  String langName3;
  String langName1;
  String langName2;
  int expiredYears;
  Icon icon;
  int sort;
  String type;
  bool defaultMedal;

  String getLangText(BuildContext context) {
    var user = Provider.of<AppSettingsModel>(context, listen: false);
    if (user.localeCode == 'kk' && langName2 != null && langName2.isNotEmpty) {
      return langName2;
    }
    if (user.localeCode == 'ru' && langName1 != null && langName1.isNotEmpty) {
      return langName1;
    }
    if (user.localeCode == 'en' && langName3 != null && langName3.isNotEmpty) {
      return langName3;
    }
    return instanceName;
  }

  factory Medal.fromJson(String str) => Medal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Medal.fromMap(Map<String, dynamic> json) => Medal(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    langName3: json["langName3"] == null ? null : json["langName3"],
    langName1: json["langName1"] == null ? null : json["langName1"],
    langName2: json["langName2"] == null ? null : json["langName2"],
    expiredYears: json["expiredYears"] == null ? null : json["expiredYears"],
    icon: json["icon"] == null ? null : Icon.fromMap(json["icon"]),
    sort: json["sort"] == null ? null : json["sort"],
    type: json["type"] == null ? null :  json["type"],
    defaultMedal: json["defaultMedal"] == null ? null : json["defaultMedal"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "langName3": langName3 == null ? null : langName3,
    "langName1": langName1 == null ? null : langName1,
    "langName2": langName2 == null ? null : langName2,
    "expiredYears": expiredYears == null ? null : expiredYears,
    "icon": icon == null ? null : icon.toMap(),
    "sort": sort == null ? null : sort,
    "type": type == null ? null : type,
    "defaultMedal": defaultMedal == null ? null : defaultMedal,
  };
}

class Icon {
  Icon({
    this.entityName,
    this.instanceName,
    this.id,
    this.extension,
    this.name,
    this.createDate,
  });

  String entityName;
  String instanceName;
  String id;
  String extension;
  String name;
  DateTime createDate;

  factory Icon.fromJson(String str) => Icon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Icon.fromMap(Map<String, dynamic> json) => Icon(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    extension: json["extension"] == null ? null : json["extension"],
    name: json["name"] == null ? null : json["name"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "extension": extension == null ? null : extension,
    "name": name == null ? null : name,
    "createDate": createDate == null ? null : createDate.toIso8601String(),
  };
}

