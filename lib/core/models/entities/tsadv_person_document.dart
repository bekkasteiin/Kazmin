/*
"_entityName": "tsadv$PersonDocument"
 */

import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_dicIssuing_authority.dart';
import 'package:kzm/core/models/entities/tsadv_dic_document_type.dart';

class TsadvPersonDocument {
  String entityName;
  String instanceName;
  String id;
  String endDate;
  String documentNumber;
  String expiredDate;
  String issuedBy;
  String legacyId;
  String issueDate;
  String startDate;
  TsadvDicDocumentType documentType;
  TsadvDicIssuingAuthority issuingAuthority;

  TsadvPersonDocument({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.documentNumber,
    this.expiredDate,
    this.issuedBy,
    this.legacyId,
    this.issueDate,
    this.startDate,
    this.documentType,
    this.issuingAuthority,
  });

  static String get entity => 'tsadv\$PersonDocument';

  static String get view => 'portal.my-profile';

  static String get property => 'personGroup.id';

  factory TsadvPersonDocument.fromJson(String str) => TsadvPersonDocument.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvPersonDocument.fromMap(Map<String, dynamic> json) => TsadvPersonDocument(
        entityName: json['_entityName']?.toString(),
        instanceName: json['_instanceName']?.toString(),
        id: json['id']?.toString(),
        endDate: json['endDate']?.toString(),
        documentNumber: json['documentNumber']?.toString(),
        expiredDate: json['expiredDate']?.toString(),
        issuedBy: json['issuedBy']?.toString(),
        legacyId: json['legacyId']?.toString(),
        issueDate: json['issueDate']?.toString(),
        startDate: json['startDate']?.toString(),
        documentType: json['documentType'] == null ? null : TsadvDicDocumentType.fromMap(json['documentType'] as Map<String, dynamic>),
        issuingAuthority: json['issuingAuthority'] == null ? null : TsadvDicIssuingAuthority.fromMap(json['issuingAuthority'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'endDate': endDate,
        'documentNumber': documentNumber,
        'expiredDate': expiredDate,
        'issuedBy': issuedBy,
        'legacyId': legacyId,
        'issueDate': issueDate,
        'startDate': startDate,
        'documentType': documentType?.toMap(),
        'issuingAuthority': issuingAuthority?.toMap(),
      }..removeWhere((String key, dynamic value) => value == null);
}
