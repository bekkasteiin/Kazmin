/*
"_entityName": "tsadv$Job"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';

class TsadvJob {
  String entityName;
  String instanceName;
  String endDate;
  String id;
  String jobNameLocale;
  String jobName;
  String jobNameLang1;
  String jobNameLang2;
  String jobNameLang3;
  String startDate;

  TsadvJob({
    this.entityName,
    this.instanceName,
    this.endDate,
    this.id,
    this.jobNameLocale,
    this.jobName,
    this.jobNameLang1,
    this.jobNameLang2,
    this.jobNameLang3,
    this.startDate,
  });

  factory TsadvJob.fromJson(String str) {
    return TsadvJob.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvJob.fromMap(Map<String, dynamic> json) {
    return TsadvJob(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      endDate: json['endDate']?.toString(),
      id: json['id']?.toString(),
      jobNameLocale: (json['jobNameLang${mapLocale()}'] ?? json['jobNameLang1']) as String,
      jobName: json['jobName']?.toString(),
      jobNameLang1: json['jobNameLang1']?.toString(),
      jobNameLang2: json['jobNameLang2']?.toString(),
      jobNameLang3: json['jobNameLang3']?.toString(),
      startDate: json['startDate']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'endDate': endDate,
      'id': id,
      'jobName': jobName,
      'jobNameLang1': jobNameLang1,
      'jobNameLang2': jobNameLang2,
      'jobNameLang3': jobNameLang3,
      'startDate': startDate,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
