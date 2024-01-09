import 'dart:convert';

import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';

class TsadvPersonDocumentRequest {
  String entityName;
  String instanceName;
  String id;
  String requestDate;
  int requestNumber;
  TsadvDicRequestStatus status;

  TsadvPersonDocumentRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.requestDate,
    this.requestNumber,
    this.status,
  });

  factory TsadvPersonDocumentRequest.fromJson(String str) => TsadvPersonDocumentRequest.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TsadvPersonDocumentRequest.fromMap(Map<String, dynamic> json) {
    return TsadvPersonDocumentRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      id: json['id']?.toString(),
      requestDate: json['requestDate']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'id': id,
      'requestDate': requestDate,
      'requestNumber': requestNumber,
      'status': status?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
