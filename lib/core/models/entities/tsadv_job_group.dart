/*
"_entityName": "tsadv$JobGroup"
*/

import 'dart:convert';

import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/entities/tsadv_job.dart';

class TsadvJobGroup {
  String entityName;
  String instanceName;
  String id;
  String jobNameLocale;
  String jobName;
  String jobNameLang1;
  String jobNameLang2;
  String jobNameLang3;
  List<TsadvJob> list;

  TsadvJobGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.jobNameLocale,
    this.jobName,
    this.jobNameLang1,
    this.jobNameLang2,
    this.jobNameLang3,
    this.list,
  });

  factory TsadvJobGroup.fromJson(String str) {
    return TsadvJobGroup.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvJobGroup.fromMap(Map<String, dynamic> json) {
    return TsadvJobGroup(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      jobNameLocale: (json['jobNameLang${mapLocale()}'] ?? json['jobNameLang1']) as String,
      jobName: json['jobName']?.toString(),
      jobNameLang1: json['jobNameLang1']?.toString(),
      jobNameLang2: json['jobNameLang2']?.toString(),
      jobNameLang3: json['jobNameLang3']?.toString(),
      list: (json['list'] == null)
          ? null
          : (json['list'] as List<dynamic>).map((dynamic i) => TsadvJob.fromMap(i as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'jobName': jobName,
      'jobNameLang1': jobNameLang1,
      'jobNameLang2': jobNameLang2,
      'jobNameLang3': jobNameLang3,
      'list': list?.map((TsadvJob e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
