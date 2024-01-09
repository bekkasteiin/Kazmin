import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/tsadv_dic_attitude_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_document_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_rank.dart';
import 'package:kzm/core/models/entities/tsadv_dic_military_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_officer_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';
import 'package:kzm/core/models/entities/tsadv_dic_suitability_to_military.dart';
import 'package:kzm/core/models/entities/tsadv_dic_troops_structure.dart';
import 'package:kzm/core/models/entities/tsadv_military_form.dart';
import 'package:kzm/core/models/person/person.dart';

class MilitaryRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  TsadvMilitaryForm entityData;

  MilitaryRequest({
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

  factory MilitaryRequest.fromJson(String str) {
    return MilitaryRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MilitaryRequest.fromMap(Map<String, dynamic> json) {
    return MilitaryRequest(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      requestNumber: json['requestNumber'] == null ? null : int.parse(json['requestNumber'].toString()),
      requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate'].toString()),
      // status: json['status'] == null ? TsadvDicRequestStatus() : TsadvDicRequestStatus.fromMap(json['status'] as Map<String, dynamic>),
      status: json['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(json['status'] as Map<String, dynamic>),
      id: json['id']?.toString(),
      files: json['attachments'] == null
          ? null
          : (json['attachments'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup'] as Map<String, dynamic>),
      entityData: TsadvMilitaryForm.fromMap(json)
        ..id = ((json['militaryForm'] != null) && (json['militaryForm']['id'] != null)) ? json['militaryForm']['id']?.toString() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'attachments': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'attitude_to_military': entityData?.attitudeToMilitary?.id == null ? null : TsadvDicAttitudeToMilitary(id: entityData.attitudeToMilitary.id).toMap(),
      'date_from': formatFullRestNotMilSec(entityData?.dateFrom),
      'date_to': formatFullRestNotMilSec(entityData?.dateTo),
      'document_number': entityData?.documentNumber,
      'id': id,
      'militaryForm': entityData?.id == null ? null : TsadvMilitaryForm(id: entityData.id).toMap(),
      'military_document_type':
          entityData?.militaryDocumentType?.id == null ? null : TsadvDicMilitaryDocumentType(id: entityData.militaryDocumentType.id).toMap(),
      'military_rank': entityData?.militaryRank?.id == null ? null : TsadvDicMilitaryRank(id: entityData.militaryRank.id).toMap(),
      'military_type': entityData?.militaryType?.id == null ? null : TsadvDicMilitaryType(id: entityData.militaryType.id).toMap(),
      'officer_type': entityData?.officerType?.id == null ? null : TsadvDicOfficerType(id: entityData.officerType.id).toMap(),
      'personGroup': PersonGroup(id: employee?.id).toMap(),
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'specialization': entityData?.specialization,
      'status': TsadvDicRequestStatus(id: status?.id).toMap(),
      'suitability_to_military':
          entityData?.suitabilityToMilitary?.id == null ? null : TsadvDicSuitabilityToMilitary(id: entityData.suitabilityToMilitary.id).toMap(),
      'troops_structure': entityData?.troopsStructure?.id == null ? null : TsadvDicTroopsStructure(id: entityData.troopsStructure.id).toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getProcessDefinitionKey => 'militaryFormRequest';

  @override
  String get getView => 'militaryFormRequest-view';

  @override
  String get getEntityName => EntityNames.militaryFormRequest;

  @override
  dynamic getFromJson(String string) => MilitaryRequest.fromJson(string);
}
