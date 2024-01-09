import 'dart:convert';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';

import 'package:kzm/core/models/courses/course.dart';

class DicCategory {
  DicCategory({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.createTs,
    this.company,
    this.order,
    this.courses,
    this.updatedBy,
    this.isSystemRecord,
    this.langValue,
    this.active,
    this.version,
    this.isDefault,
    this.createdBy,
    this.langValue1,
    this.updateTs,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  DateTime createTs;
  AbstractDictionary company;
  int order;
  List<Course> courses;
  String updatedBy;
  bool isSystemRecord;
  String langValue;
  bool active;
  int version;
  bool isDefault;
  String createdBy;
  String langValue1;
  DateTime updateTs;

  factory DicCategory.fromJson(String str) => DicCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DicCategory.fromMap(Map<String, dynamic> json) => DicCategory(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs']),
        company: json['company'] == null ? null : AbstractDictionary.fromMap(json['company']),
        order: json['order'],
        courses: json['courses'] == null ? null : List<Course>.from(json['courses'].map((x) => Course.fromMap(x))),
        updatedBy: json['updatedBy'],
        isSystemRecord: json['isSystemRecord'],
        langValue: json['langValue'],
        active: json['active'],
        version: json['version'],
        isDefault: json['isDefault'],
        createdBy: json['createdBy'],
        langValue1: json['langValue1'],
        updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'createTs': createTs == null ? null : createTs.toIso8601String(),
        'company': company == null ? null : company.toMap(),
        'order': order,
        'courses': courses == null ? null : List<dynamic>.from(courses.map((Course x) => x.toMap())),
        'updatedBy': updatedBy,
        'isSystemRecord': isSystemRecord,
        'langValue': langValue,
        'active': active,
        'version': version,
        'isDefault': isDefault,
        'createdBy': createdBy,
        'langValue1': langValue1,
        'updateTs': updateTs == null ? null : updateTs.toIso8601String(),
      };
}
