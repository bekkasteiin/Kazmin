import 'dart:convert';

class TsadvLearningFeedbackTemplate {
  String entityName;
  String instanceName;
  bool active;
  String description;
  bool employee;
  String endDate;
  String id;
  bool manager;
  String name;
  String startDate;
  bool trainer;
  String usageType;
  int version;

  TsadvLearningFeedbackTemplate({
    this.entityName,
    this.instanceName,
    this.active,
    this.description,
    this.employee,
    this.endDate,
    this.id,
    this.manager,
    this.name,
    this.startDate,
    this.trainer,
    this.usageType,
    this.version,
  });

  factory TsadvLearningFeedbackTemplate.fromMap(Map<String, dynamic> json) {
    return TsadvLearningFeedbackTemplate(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      active: json['active'] == null ? null : json['active'] as bool,
      description: json['description']?.toString(),
      employee: json['employee'] == null ? null : json['employee'] as bool,
      endDate: json['endDate']?.toString(),
      id: json['id']?.toString(),
      manager: json['manager'] == null ? null : json['manager'] as bool,
      name: json['name']?.toString(),
      startDate: json['startDate']?.toString(),
      trainer: json['trainer'] == null ? null : json['trainer'] as bool,
      usageType: json['usageType']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  factory TsadvLearningFeedbackTemplate.fromJson(String str) {
    return TsadvLearningFeedbackTemplate.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'active': active,
      'description': description,
      'employee': employee,
      'endDate': endDate,
      'id': id,
      'manager': manager,
      'name': name,
      'startDate': startDate,
      'trainer': trainer,
      'usageType': usageType,
      'version': version,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
