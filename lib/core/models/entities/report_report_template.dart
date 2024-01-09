import 'dart:convert';

class ReportReportTemplate {
  String entityName;
  String instanceName;
  bool alterable;
  String code;
  bool custom;
  String customDefinition;
  String id;
  String name;
  String outputNamePattern;

  ReportReportTemplate({
    this.entityName,
    this.instanceName,
    this.alterable,
    this.code,
    this.custom,
    this.customDefinition,
    this.id,
    this.name,
    this.outputNamePattern,
  });

  static String get entity => 'report\$ReportTemplate';

  static String get view => null;

  static String get property => null;

  factory ReportReportTemplate.fromJson(String str) {
    return ReportReportTemplate.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory ReportReportTemplate.fromMap(Map<String, dynamic> json) {
    return ReportReportTemplate(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      alterable: json['alterable'] == null ? null : json['alterable'] as bool,
      code: json['code']?.toString(),
      custom: json['custom'] == null ? null : json['custom'] as bool,
      customDefinition: json['customDefinition']?.toString(),
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      outputNamePattern: json['outputNamePattern']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'alterable': alterable,
      'code': code,
      'custom': custom,
      'customDefinition': customDefinition,
      'id': id,
      'name': name,
      'outputNamePattern': outputNamePattern,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
