import 'dart:convert';

import 'package:kzm/core/models/entities/other/form_params.dart';

class TsadvStartBprocScreen {
  List<dynamic> allowedProcessKeys;
  List<dynamic> fields;
  String openMode;
  List<dynamic> outcomes;
  List<dynamic> outputVariables;
  List<FormParams> formParams;
  String screenId;
  String type;

  TsadvStartBprocScreen({
    this.allowedProcessKeys,
    this.fields,
    this.openMode,
    this.outcomes,
    this.outputVariables,
    this.screenId,
    this.type,
    this.formParams,
  });

  factory TsadvStartBprocScreen.fromJson(String str) {
    return TsadvStartBprocScreen.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvStartBprocScreen.fromMap(Map<String, dynamic> json) {
    return TsadvStartBprocScreen(
      allowedProcessKeys: (json['allowedProcessKeys'] == null)
          ? null
          : (json['allowedProcessKeys'] as List<dynamic>).map((dynamic i) => i).toList(),
      fields: (json['fields'] == null) ? null : (json['fields'] as List<dynamic>).map((dynamic i) => i).toList(),
      outcomes: (json['outcomes'] == null) ? null : (json['outcomes'] as List<dynamic>).map((dynamic i) => i).toList(),
      outputVariables: (json['outputVariables'] == null)
          ? null
          : (json['outputVariables'] as List<dynamic>).map((dynamic i) => i).toList(),
      formParams: (json['formParams'] == null)
          ? null
          : (json['formParams'] as List<dynamic>)
              .map((dynamic i) => FormParams.fromMap(i as Map<String, dynamic>))
              .toList(),
      openMode: json['openMode']?.toString(),
      screenId: json['screenId']?.toString(),
      type: json['type']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openMode': openMode,
      'screenId': screenId,
      'type': type,
      'formParams': formParams?.map((FormParams e) => e.toMap())?.toList(),
      'allowedProcessKeys': allowedProcessKeys?.map((dynamic e) => <String, String>{'data': e.toString()})?.toList(),
      'fields': fields?.map((dynamic e) => <String, String>{'data': e.toString()})?.toList(),
      'outcomes': outcomes?.map((dynamic e) => <String, String>{'data': e.toString()})?.toList(),
      'outputVariables': outputVariables?.map((dynamic e) => <String, String>{'data': e.toString()})?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
