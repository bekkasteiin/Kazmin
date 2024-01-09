import 'dart:convert';

import 'package:kzm/core/models/entities/report_report_template.dart';

class TsadvTsadvReport {
  String entityName;
  String instanceName;
  String id;
  String name;
  List<ReportReportTemplate> templates;

  TsadvTsadvReport({
    this.entityName,
    this.instanceName,
    this.id,
    this.name,
    this.templates,
  });

  static String get entity => 'tsadv_TsadvReport';

  static String get view => 'report.withTemplates';

  static String get property => null;

  factory TsadvTsadvReport.fromJson(String str) {
    return TsadvTsadvReport.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvTsadvReport.fromMap(Map<String, dynamic> json) {
    return TsadvTsadvReport(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      templates: (json['templates'] == null)
          ? <ReportReportTemplate>[]
          : (json['templates'] as List<dynamic>).map((dynamic i) => ReportReportTemplate.fromMap(i as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'name': name,
      'templates': templates?.map((ReportReportTemplate e) => e.toMap())?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
