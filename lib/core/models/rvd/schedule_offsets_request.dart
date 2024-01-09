import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';

class ScheduleOffsetsRequest extends AbstractBpmRequest {
  @override
  String get getProcessDefinitionKey => 'scheduleOffsetsRequest';

  @override
  String get getView => 'scheduleOffsetsRequest-for-my-team';

  @override
  String get getEntityName => EntityNames.scheduleOffsetsRequest;

  @override
  ScheduleOffsetsRequest getFromJson(String string) => ScheduleOffsetsRequest.fromJson(string);

  ScheduleOffsetsRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.purpose,
    this.purposeText,
    this.currentSchedule,
    this.newSchedule,
    this.dateOfNewSchedule,
    this.dateOfStartNewSchedule,
    this.requestNumber,
    this.requestDate,
    this.personGroup,
    this.detailsOfActualWork,
    this.comment,
    this.isAgree,
    this.earningPolicy,
    this.acquainted,
    this.status,
  });

  String entityName;
  String instanceName;
  @override
  String id;
  String purposeText;
  String detailsOfActualWork;
  String comment;
  Purpose purpose;
  bool isAgree;
  bool acquainted;
  CurrentSchedule currentSchedule;
  CurrentSchedule newSchedule;
  DateTime dateOfNewSchedule;
  int requestNumber;
  DateTime requestDate;
  DateTime dateOfStartNewSchedule;
  PersonGroup personGroup;
  @override
  AbstractDictionary status;
  Policy earningPolicy;

  factory ScheduleOffsetsRequest.fromJson(String str) => ScheduleOffsetsRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleOffsetsRequest.fromMap(Map<String, dynamic> json) => ScheduleOffsetsRequest(
        entityName: json['_entityName'],
        purposeText: json['purposeText'],
        detailsOfActualWork: json['detailsOfActualWork'],
        comment: json['comment'],
        instanceName: json['_instanceName'],
        id: json['id'] ?? '',
        purpose: json['purpose'] == null ? null : Purpose.fromMap(json['purpose']),
        currentSchedule: json['currentSchedule'] == null ? null : CurrentSchedule.fromMap(json['currentSchedule']),
        newSchedule: json['newSchedule'] == null ? null : CurrentSchedule.fromMap(json['newSchedule']),
        earningPolicy: json['earningPolicy'] == null ? null : Policy.fromMap(json['earningPolicy']),
        dateOfNewSchedule: json['dateOfNewSchedule'] == null ? null : DateTime.parse(json['dateOfNewSchedule']),
        isAgree: json['agree'] ?? false,
        acquainted: json['acquainted'] ?? false,
        requestNumber: json['requestNumber'],
        requestDate: json['requestDate'] == null ? null : DateTime.parse(json['requestDate']),
        dateOfStartNewSchedule: json['dateOfStartNewSchedule'] == null ? null : DateTime.parse(json['dateOfStartNewSchedule']),
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        status: json['status'] == null ? null : AbstractDictionary.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'purpose': purpose == null ? null : purpose.toMap(),
        'currentSchedule': currentSchedule == null ? null : currentSchedule.toMap(),
        'newSchedule': newSchedule == null ? null : newSchedule.toMap(),
        'earningPolicy': earningPolicy == null ? null : earningPolicy.toMap(),
        'dateOfNewSchedule': dateOfNewSchedule == null ? null : formatFullRest(dateOfNewSchedule),
        'requestNumber': requestNumber,
        'requestDate': requestDate == null ? null : formatFullRest(requestDate),
        'dateOfStartNewSchedule': dateOfStartNewSchedule == null ? null : formatFullRest(dateOfStartNewSchedule),
        'agree': isAgree ?? false,
        'acquainted': isAgree ?? false,
        'personGroup': personGroup == null ? null : personGroup.toMapId(),
        'status': status == null ? null : status.toMap(),
        'purposeText': purposeText,
        'detailsOfActualWork': detailsOfActualWork,
        'comment': comment,
      }
        ..removeWhere((String key, dynamic value) => value == null);
}

class CurrentSchedule {
  CurrentSchedule({
    this.entityName,
    this.instanceName,
    this.id,
    this.scheduleName,
    this.endDate,
    this.scheduleType,
    this.legacyId,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  String scheduleName;
  DateTime endDate;
  String scheduleType;
  String legacyId;
  DateTime startDate;

  factory CurrentSchedule.fromMap(Map<String, dynamic> json) => CurrentSchedule(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        scheduleName: json['scheduleName'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        scheduleType: json['scheduleType'],
        legacyId: json['legacyId'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'scheduleName': scheduleName,
        'endDate': endDate == null ? null : formatFullRest(endDate),
        'scheduleType': scheduleType,
        'legacyId': legacyId,
        'startDate': startDate == null ? null : formatFullRest(startDate),
      };
}

class Policy {
  Policy({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
    this.assignmentNumber,
  });

  String entityName;
  String instanceName;
  String id;
  String langValue1;
  String assignmentNumber;

  factory Policy.fromMap(Map<String, dynamic> json) => Policy(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        langValue1: json['langValue1'],
        assignmentNumber: json['assignmentNumber'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'langValue1': langValue1,
        'assignmentNumber': assignmentNumber,
      };
}

class Purpose {
  Purpose({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.purposeType,
    this.absenceType,
    this.langValue3,
    this.langValue1,
    this.langValue2,
  });

  String entityName;
  String instanceName;
  String id;
  Purpose purposeType;
  AbsencePurpose absenceType;
  String code;
  String langValue3;
  String langValue1;
  String langValue2;

  factory Purpose.fromMap(Map<String, dynamic> json) => Purpose(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        langValue3: json['langValue3'],
        langValue1: json['langValue1'],
        langValue2: json['langValue2'],
        purposeType: json['absencePurpose'] == null ? null : Purpose.fromMap(json['absencePurpose']),
        absenceType: json['absenceType'] == null ? null : AbsencePurpose.fromMap(json['absenceType']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'langValue3': langValue3,
        'langValue1': langValue1,
        'langValue2': langValue2,
        'absencePurpose': purposeType == null ? null : purposeType.toMap(),
        'absenceType': absenceType == null ? null : absenceType.toMap(),
      };
}

class AbsencePurpose {
  AbsencePurpose({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.langValue1,
    this.langValue2,
  });

  String entityName;
  String instanceName;
  String id;
  String langValue3;
  String langValue1;
  String langValue2;

  factory AbsencePurpose.fromMap(Map<String, dynamic> json) => AbsencePurpose(
      entityName: json['_entityName'],
      instanceName: json['_instanceName'],
      id: json['id'],
      langValue3: json['langValue3'],
      langValue1: json['langValue1'],
      langValue2: json['langValue2'],);

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'langValue3': langValue3,
        'langValue1': langValue1,
        'langValue2': langValue2
      };
}
