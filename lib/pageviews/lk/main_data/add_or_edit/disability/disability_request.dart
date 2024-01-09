import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/tsadv_dic_disability_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';
import 'package:kzm/core/models/entities/tsadv_disability.dart';
import 'package:kzm/core/models/person/person.dart';

class DisabilityRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  TsadvDisability entityData;

  DisabilityRequest({
    this.entityName,
    this.instanceName,
    this.requestNumber,
    this.requestDate,
    // this.status,
    this.entityData,
    String id,
    List<FileDescriptor> files,
    PersonGroup personGroup,
    AbstractDictionary status,
  }) {
    this.id = id;
    this.files = files;
    employee = personGroup;
    this.status = status;
  }

  factory DisabilityRequest.fromJson(String str) {
    return DisabilityRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DisabilityRequest.fromMap(Map<String, dynamic> map) {
    return DisabilityRequest(
      entityName: map['_entityName']?.toString(),
      instanceName: map['_instanceName']?.toString(),
      requestNumber: map['requestNumber'] == null ? null : int.parse(map['requestNumber'].toString()),
      requestDate: map['requestDate'] == null ? null : DateTime.parse(map['requestDate'].toString()),
      // status: map['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(map['status'] as Map<String, dynamic>),
      status: map['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(map['status'] as Map<String, dynamic>),
      id: map['id']?.toString(),
      files: map['attachments'] == null
          ? null
          : (map['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: map['personGroup'] == null ? null : PersonGroup.fromMap(map['personGroup'] as Map<String, dynamic>),
      entityData: TsadvDisability.fromMap(map)
        ..id = ((map['disability'] != null) && (map['disability']['id'] != null)) ? map['disability']['id']?.toString() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'dateFrom': formatFullRestNotMilSec(entityData?.dateFrom),
      'dateTo': formatFullRestNotMilSec(entityData?.dateTo),
      'disability': entityData?.id == null ? null : TsadvDisability(id: entityData.id).toMap(),
      'disabilityType': entityData?.disabilityType?.id == null ? null : TsadvDicDisabilityType(id: entityData.disabilityType.id).toMap(),
      'hasDisability': entityData?.hasDisability,
      'id': id,
      'personGroup': employee?.id,
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'status': TsadvDicRequestStatus(id: status?.id).toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'disabilityRequest';

  @override
  String get getView => 'disabilityRequest.edit';

  @override
  String get getEntityName => EntityNames.disabilityRequest;

  @override
  dynamic getFromJson(String string) => DisabilityRequest.fromJson(string);
}
