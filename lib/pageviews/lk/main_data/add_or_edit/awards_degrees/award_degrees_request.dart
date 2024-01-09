import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kind_of_award.dart';
import 'package:kzm/core/models/entities/tsadv_dic_promotion_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';
import 'package:kzm/core/models/entities/tsadv_person_awards_degrees.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/contact/award_degrees_request.dart';

class AwardDegreesRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  int requestNumber;
  DateTime requestDate;
  // TsadvDicRequestStatus status;

  TsadvPersonAwardsDegrees entityData;

  AwardDegreesRequest({
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

  factory AwardDegreesRequest.fromJson(String str) {
    // log('-->> $fName, AwardDegreesRequest.fromJson -->> v: $str');
    return AwardDegreesRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory AwardDegreesRequest.fromMap(Map<String, dynamic> map) {
    // log('-->> $fName, AwardDegreesRequest.fromMap -->> json: ${json.encode(map)}');
    return AwardDegreesRequest(
      entityName: map['_entityName']?.toString(),
      instanceName: map['_instanceName']?.toString(),
      requestNumber: map['requestNumber'] == null ? null : int.parse(map['requestNumber'].toString()),
      requestDate: map['requestDate'] == null ? null : DateTime.parse(map['requestDate'].toString()),
      status: map['status'] == null ? AbstractDictionary() : AbstractDictionary.fromMap(map['status'] as Map<String, dynamic>),
      id: map['id']?.toString(),
      files: map['file'] == null ? null : (map['file'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      personGroup: map['employee'] == null ? null : PersonGroup.fromMap(map['employee'] as Map<String, dynamic>),
      entityData: TsadvPersonAwardsDegrees.fromMap(map),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'requestNumber': requestNumber,
      'requestDate': formatFullRestNotMilSec(requestDate),
      'status': TsadvDicRequestStatus(id: status?.id).toMap(),
      'id': id,
      'file': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.id,
      'description': entityData?.description,
      'employee': BasePersonGroupExt(id: employee?.id).toMap(),
      'endDate': formatFullRestNotMilSec(entityData?.endDate),
      'kind': TsadvDicKindOfAward(id: entityData?.kind?.id).toMap(),
      'startDate': formatFullRestNotMilSec(entityData?.startDate),
      'type': TsadvDicPromotionType(id: entityData?.type?.id).toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }
  @override
  String get getProcessDefinitionKey => 'personAwardsDegreesRequest';

  @override
  String get getView => 'personAwardsDegrees.edit';

  @override
  String get getEntityName => EntityNames.personAwardsDegreesRequest;

  @override
  dynamic getFromJson(String string) => AwardDegreesRequest.fromJson(string);
}
