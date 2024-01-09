// To parse this JSON data, do
//
//     final personDocument = personDocumentFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/abstract/abstract_dictionary.dart';

class PersonDocument {
  PersonDocument({
    this.entityName,
    this.instanceName,
    this.id,
    this.documentType,
    this.documentNumber,
    this.expiredDate,
    this.issuedBy,
    this.issueDate,
  });

  String entityName;
  String instanceName;
  String id;
  AbstractDictionary documentType;
  String documentNumber;
  DateTime expiredDate;
  String issuedBy;
  DateTime issueDate;

  factory PersonDocument.fromJson(String str) => PersonDocument.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonDocument.fromMap(Map<String, dynamic> json) => PersonDocument(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        documentType: json['documentType'] == null ? null : AbstractDictionary.fromMap(json['documentType']),
        documentNumber: json['documentNumber'],
        expiredDate: json['expiredDate'] == null ? null : DateTime.parse(json['expiredDate']),
        issuedBy: json['issuedBy'],
        issueDate: json['issueDate'] == null ? null : DateTime.parse(json['issueDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'documentType': documentType == null ? null : documentType.toMap(),
        'documentNumber': documentNumber,
        'expiredDate': expiredDate == null
            ? null
            : "${expiredDate.year.toString().padLeft(4, '0')}-${expiredDate.month.toString().padLeft(2, '0')}-${expiredDate.day.toString().padLeft(2, '0')}",
        'issuedBy': issuedBy,
        'issueDate': issueDate == null
            ? null
            : "${issueDate.year.toString().padLeft(4, '0')}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}",
      }..removeWhere((String key, dynamic value) => value == null);
}
