// To parse this JSON data, do
//
//     final formData = formDataFromMap(jsonString);

import 'dart:convert';


class BpmFormData {
  BpmFormData({
    this.type,
    this.screenId,
    this.openMode,
    this.allowedProcessKeys,
    this.fields,
    this.outcomes,
    this.formParams,
    this.outputVariables,
  });

  String type;
  String screenId;
  String openMode;
  List<dynamic> allowedProcessKeys;
  List<dynamic> fields;
  List<Outcome> outcomes;
  List<dynamic> formParams;
  List<dynamic> outputVariables;

  factory BpmFormData.fromJson(String str) => BpmFormData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BpmFormData.fromMap(Map<String, dynamic> json) {
    // log('-->> BpmFormData.fromMap -->> json: $json');
    return BpmFormData(
      type: json['type'],
      screenId: json['screenId'],
      openMode: json['openMode'],
      allowedProcessKeys: json['allowedProcessKeys'] == null ? null : List<dynamic>.from(json['allowedProcessKeys'].map((x) => x)),
      fields: json['fields'] == null ? null : List<dynamic>.from(json['fields'].map((x) => x)),
      outcomes: json['outcomes'] == null ? null : List<Outcome>.from(json['outcomes'].map((x) => Outcome.fromMap(x))),
      formParams: json['formParams'] == null ? null : List<dynamic>.from(json['formParams'].map((x) => x)),
      outputVariables: json['outputVariables'] == null ? null : List<dynamic>.from(json['outputVariables'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() => {
        'type': type,
        'screenId': screenId,
        'openMode': openMode,
        'allowedProcessKeys': allowedProcessKeys == null ? null : List<dynamic>.from(allowedProcessKeys.map((x) => x)),
        'fields': fields == null ? null : List<dynamic>.from(fields.map((x) => x)),
        'outcomes': outcomes == null ? null : List<dynamic>.from(outcomes.map((Outcome x) => x.toMap())),
        'formParams': formParams == null ? null : List<dynamic>.from(formParams.map((x) => x)),
        'outputVariables': outputVariables == null ? null : List<dynamic>.from(outputVariables.map((x) => x)),
      };
}

class Outcome {
  Outcome({
    this.id,
    this.outcomeParams,
    this.outputVariables,
  });

  String id;
  List<dynamic> outcomeParams;
  List<dynamic> outputVariables;

  factory Outcome.fromJson(String str) => Outcome.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Outcome.fromMap(Map<String, dynamic> json) => Outcome(
        id: json['id'],
        outcomeParams: json['outcomeParams'] == null ? null : List<dynamic>.from(json['outcomeParams'].map((x) => x)),
        outputVariables: json['outputVariables'] == null ? null : List<dynamic>.from(json['outputVariables'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'outcomeParams': outcomeParams == null ? null : List<dynamic>.from(outcomeParams.map((x) => x)),
        'outputVariables': outputVariables == null ? null : List<dynamic>.from(outputVariables.map((x) => x)),
      };
}
