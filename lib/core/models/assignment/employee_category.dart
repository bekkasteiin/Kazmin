import 'dart:convert';

import 'package:hive/hive.dart';

part 'employee_category.g.dart';

@HiveType(typeId: 5)
class EmployeeCategory {
  EmployeeCategory({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.langValue2,
    this.langValue1,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String langValue3;
  @HiveField(4)
  String langValue2;
  @HiveField(5)
  String langValue1;

  factory EmployeeCategory.fromJson(String str) =>
      EmployeeCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeCategory.fromMap(Map<String, dynamic> json) =>
      EmployeeCategory(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        langValue3: json['langValue3'],
        langValue2: json['langValue2'],
        langValue1: json['langValue1'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'langValue3': langValue3,
        'langValue2': langValue2,
        'langValue1': langValue1,
      };
}
