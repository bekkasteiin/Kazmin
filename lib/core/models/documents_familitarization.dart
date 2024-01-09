import 'dart:convert';

import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_dic_company.dart';

class GetDocumentListResponse {
  GetDocumentListResponse({
    this.entityName,
    this.instanceName,
    this.id,
    this.acknowledgement,
    this.version,
    this.documentFamiliarization,
    this.createTs,
  });

  String entityName;
  String instanceName;
  String id;
  bool acknowledgement;
  int version;
  DocumentsFamiliarization documentFamiliarization;
  DateTime createTs;


  factory GetDocumentListResponse.fromJson(String str) => GetDocumentListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDocumentListResponse.fromMap(Map<String, dynamic> json) => GetDocumentListResponse(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    acknowledgement: json['acknowledgement'],
    version: json['version'],
    documentFamiliarization: json['documentFamiliarization'] != null ?  DocumentsFamiliarization.fromMap(json['documentFamiliarization']) : null,

  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'acknowledgement': acknowledgement,
    'version': version,
    'documentFamiliarization': documentFamiliarization.toMap(),
  };
}

class DocumentsFamiliarization {
  DocumentsFamiliarization({
    this.entityName,
    this.instanceName,
    this.id,
    this.descriptionEn,
    this.organizationBin,
    this.nameKz,
    this.description,
    this.nameEn,
    this.type,
    this.dateFrom,
    this.descriptionKz,
    this.file,
    this.name,
    this.dateTo,
    this.company,
    this.known,
    this.acknowledgement = false,
  });

  String entityName;
  String instanceName;
  String id;
  String descriptionEn;
  String organizationBin;
  String nameKz;
  String description;
  String nameEn;
  AbstractDictionary type;
  DateTime dateFrom;
  String descriptionKz;
  FileDescriptor file;
  String name;
  DateTime dateTo;
  BaseDicCompany company;
  bool known;
  bool acknowledgement;

  factory DocumentsFamiliarization.fromJson(String str) =>
      DocumentsFamiliarization.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentsFamiliarization.fromMap(Map<String, dynamic> json) =>
      DocumentsFamiliarization(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        descriptionEn:
            json['descriptionEn'],
        organizationBin: json['organizationBin'],
        nameKz: json['nameKz'],
        description: json['description'],
        nameEn: json['nameEn'],
        type: json['type'] == null
            ? null
            : AbstractDictionary.fromMap(json['type']),
        dateFrom:
            json['dateFrom'] == null ? null : DateTime.parse(json['dateFrom']),
        descriptionKz:
            json['descriptionKz'],
        file:
            json['file'] == null ? null : FileDescriptor.fromMap(json['file']),
        name: json['name'],
        dateTo: json['dateTo'] == null ? null : DateTime.parse(json['dateTo']),
        company: json['company'] == null
            ? null
            : BaseDicCompany.fromMap(json['company']),
        known: false,
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        'id': id,
      };
}
