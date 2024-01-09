import 'dart:convert';

import 'package:hive/hive.dart';

part 'job_group.g.dart';

@HiveType(typeId: 9)
class JobGroup {
  JobGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.jobNameLang1,
    this.job,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String jobNameLang1;
  @HiveField(4)
  JobGroup job;

  factory JobGroup.fromJson(String str) => JobGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobGroup.fromMap(Map<String, dynamic> json) => JobGroup(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        jobNameLang1:
            json['jobNameLang1'],
        job: json['job'] == null ? null : JobGroup.fromMap(json['job']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'jobNameLang1': jobNameLang1,
        'job': job == null ? null : job.toMap(),
      };
}
