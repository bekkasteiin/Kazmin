import 'dart:convert';

import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';

const String fName = 'lib/pageviews/hr_requests/rvd/absence_new_rvd_request.dart';

class AbsenceNewRvdRequest extends AbstractBpmRequest {
  String entityName;
  String instanceName;
  DateTime requestDate;
  int requestNumber;
  @override
  AbstractDictionary status;

  bool acquainted;
  @override
  bool agree;
  bool compensation;
  bool vacationDay;
  bool remote;
  DateTime timeOfFinishing;
  DateTime timeOfStarting;
  KzmCommonItem shiftCode;
  KzmCommonItem overrideAllHoursByDay;
  DicAbsenceType absenceType;
  AbstractDictionary purpose;
  AbstractDictionary shift;
  @override
  PersonGroup employee;
  String purposeText;

  AbsenceNewRvdRequest({
    this.entityName,
    this.instanceName,
    this.requestDate,
    this.requestNumber,
    this.status,
    this.acquainted = false,
    this.agree,
    this.compensation = true,
    this.purpose,
    this.shift,
    this.timeOfFinishing,
    this.timeOfStarting,
    this.absenceType,
    this.vacationDay = false,
    this.remote = false,
    this.employee,
    this.shiftCode,
    this.overrideAllHoursByDay,
    this.purposeText,
    String id,
    List<FileDescriptor> files,
  }) {
    this.id = id;
    this.files = files;
  }

  factory AbsenceNewRvdRequest.fromJson(String str) {
    // log('-->> $fName fromJson -->> str');
    return AbsenceNewRvdRequest.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    // log('-->> $fName toJson -->> ${json.encode(toMap())}');
    return json.encode(toMap());
  }

  factory AbsenceNewRvdRequest.fromMap(Map<String, dynamic> map) {
    // log('-->> $fName fromMap -->> ${json.encode(map)}');
    return AbsenceNewRvdRequest(
      entityName: map['_entityName']?.toString(),
      instanceName: map['_instanceName']?.toString(),
      requestDate: map['requestDate'] == null ? null : DateTime.parse(map['requestDate'].toString()),
      requestNumber: map['requestNumber'] == null ? null : int.parse(map['requestNumber'].toString()),
      status: map['status'] == null ? null : AbstractDictionary.fromMap(map['status'] as Map<String, dynamic>),
      acquainted: map['acquainted'] == null ? null : map['acquainted'] as bool,
      agree: map['agree'] == null ? null : map['agree'] as bool,
      compensation: map['compensation'] == null ? null : map['compensation'] as bool,
      purpose: map['purpose'] == null ? null : AbstractDictionary.fromMap(map['purpose'] as Map<String, dynamic>),
      shift: map['shift'] == null ? null : AbstractDictionary.fromMap(map['shift'] as Map<String, dynamic>),
      timeOfFinishing: map['timeOfFinishing'] == null ? null : DateTime.parse(map['timeOfFinishing'].toString()),
      timeOfStarting: map['timeOfStarting'] == null ? null : DateTime.parse(map['timeOfStarting'].toString()),
      absenceType: map['type'] == null ? null : DicAbsenceType.fromMap(map['type'] as Map<String, dynamic>),
      shiftCode: map['shiftCode'] == null ? null : kzmShiftCodes.where((KzmCommonItem e) => e.id == map['shiftCode'].toString()).first,
      overrideAllHoursByDay: map['overrideAllHoursByDay'] == null
          ? null
          : kzmOverrideAllHoursByDay.where((KzmCommonItem e) => e.id == map['overrideAllHoursByDay'].toString()).first,
      purposeText: map['purposeText']?.toString(),
      vacationDay: map['vacationDay'] == null ? null : map['vacationDay'] as bool,
      remote: map['remote'] == null ? null : map['remote'] as bool,
      id: map['id']?.toString(),
      files: map['files'] == null ? null : (map['files'] as List<dynamic>).map((dynamic e) => FileDescriptor.fromMap(e as Map<String, dynamic>)).toList(),
      employee: map['personGroup'] == null ? null : PersonGroup.fromMap(map['personGroup'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'requestDate': formatFullRestNotMilSec(requestDate),
      'requestNumber': requestNumber,
      'status': status?.toMap(),
      'acquainted': acquainted,
      'agree': agree,
      'compensation': compensation,
      'purpose': purpose?.toMap(),
      'shift': shift?.toMap(),
      'timeOfFinishing': formatFullRest(timeOfFinishing),
      'timeOfStarting': formatFullRest(timeOfStarting),
      'type': (absenceType == null) ? null : DicAbsenceType(id: absenceType.id).toMap(),
      'vacationDay': vacationDay,
      'remote': remote,
      'overrideAllHoursByDay': overrideAllHoursByDay?.id,
      'shiftCode': shiftCode?.id,
      'purposeText': purposeText,
      'id': id,
      'files': files?.map((FileDescriptor e) => e.toMap())?.toList(),
      'personGroup': employee?.toMap(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  @override
  String get getEntityName => EntityNames.absenceRvdRequest;

  String get getEntityNameOld => EntityNames.absenceRvdRequestOld;

  @override
  dynamic getFromJson(String string) => AbsenceNewRvdRequest.fromJson(string);

  @override
  String get getProcessDefinitionKey => 'absenceRvdRequest';

  @override
  String get getView => 'absenceRvdRequestKzm.edit';

  String get getViewOld => 'absenceRvdRequest.edit';
}
