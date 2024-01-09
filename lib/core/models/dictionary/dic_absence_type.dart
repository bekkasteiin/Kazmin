// To parse this JSON data, do
//
//     final dicAbsenceType = dicAbsenceTypeFromMap(jsonString);

import 'dart:convert';


const String fName = 'lib/core/models/dictionary/dic_absence_type.dart';

class DicAbsenceType {
  DicAbsenceType({
    this.entityName,
    this.instanceName,
    this.id,
    this.minDay,
    this.availableForTimecard,
    this.maxDay,
    this.useInBalance,
    this.order,
    this.isRequiredOrderNumber,
    this.isSystemRecord,
    this.isOriginalSheet,
    this.active,
    this.version,
    this.isCheckWork,
    this.cancelParentAbsence,
    this.isDefault,
    this.availableForLeavingVacation,
    this.useInSelfService,
    this.ignoreHolidays,
    this.availableForChangeDate,
    this.code,
    this.isWorkingDay,
    this.displayAbsence,
    this.legacyId,
    this.langValue3,
    this.langValue,
    this.isJustRequired,
    this.elmaTransfer,
    this.availableToManager,
    this.availableForRecallAbsence,
    this.langValue2,
    this.langValue1,
    this.isVacationDate,
    this.isOnlyWorkingDay,
    this.includeCalcGzp,
    this.endDate,
    this.startDate,
    this.daysAdvance,
    this.isSelected,
    this.numDaysCalendarYear,
    this.isEcologicalAbsence,
    this.workOnWeekend,
    this.isFileRequired,
    this.daysBeforeAbsence,
    this.temporaryTransfer,
    this.overtimeWork,
    this.foreigner,
  });

  String entityName;
  String instanceName;
  String id;
  int minDay;
  bool availableForTimecard;
  int maxDay;
  bool useInBalance;
  int order;
  bool isRequiredOrderNumber;
  bool isSystemRecord;
  bool isOriginalSheet;
  bool active;
  int version;
  bool isCheckWork;
  bool cancelParentAbsence;
  bool isDefault;
  bool availableForLeavingVacation;
  bool useInSelfService;
  bool ignoreHolidays;
  bool availableForChangeDate;
  String code;
  bool isWorkingDay;
  bool displayAbsence;
  String legacyId;
  String langValue3;
  String langValue;
  bool isJustRequired;
  bool elmaTransfer;
  bool availableToManager;
  bool availableForRecallAbsence;
  String langValue2;
  String langValue1;
  bool isVacationDate;
  bool isOnlyWorkingDay;
  bool includeCalcGzp;
  bool isSelected = false;
  DateTime endDate;
  DateTime startDate;
  int daysAdvance;
  int daysBeforeAbsence;
  int numDaysCalendarYear;
  bool isEcologicalAbsence;
  bool workOnWeekend;
  bool isFileRequired;
  bool temporaryTransfer;
  bool overtimeWork;
  bool foreigner;

  factory DicAbsenceType.fromJson(String str) {
    return str == null ? null : DicAbsenceType.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  factory DicAbsenceType.fromMap(Map<String, dynamic> json) => DicAbsenceType(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        minDay: json['minDay'],
        availableForTimecard: json['availableForTimecard'],
        maxDay: json['maxDay'],
        useInBalance: json['useInBalance'],
        order: json['order'],
        isRequiredOrderNumber: json['isRequiredOrderNumber'],
        isSystemRecord: json['isSystemRecord'],
        isEcologicalAbsence: json['isEcologicalAbsence'] ?? false,
        workOnWeekend: json['workOnWeekend'],
        temporaryTransfer: json['temporaryTransfer'],
        overtimeWork: json['overtimeWork'],
        foreigner: json['foreigner'],
        isOriginalSheet: json['isOriginalSheet'] ?? false,
        active: json['active'],
        version: json['version'],
        isCheckWork: json['isCheckWork'] ?? false,
        cancelParentAbsence: json['cancelParentAbsence'],
        isDefault: json['isDefault'],
        availableForLeavingVacation: json['availableForLeavingVacation'],
        useInSelfService: json['useInSelfService'],
        ignoreHolidays: json['ignoreHolidays'],
        availableForChangeDate: json['availableForChangeDate'],
        code: json['code'],
        isWorkingDay: json['isWorkingDay'],
        displayAbsence: json['displayAbsence'],
        legacyId: json['legacyId'],
        langValue3: json['langValue3'],
        langValue: json['langValue'],
        isJustRequired: json['isJustRequired'],
        elmaTransfer: json['elmaTransfer'],
        availableToManager: json['availableToManager'],
        availableForRecallAbsence: json['availableForRecallAbsence'],
        langValue2: json['langValue2'],
        daysAdvance: json['daysAdvance'],
        numDaysCalendarYear: json['numDaysCalendarYear'],
        langValue1: json['langValue1'],
        isVacationDate: json['isVacationDate'] ?? false,
        isFileRequired: json['isFileRequired'] ?? false,
        isOnlyWorkingDay: json['isOnlyWorkingDay'] ?? false,
        includeCalcGzp: json['includeCalcGzp'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        daysBeforeAbsence: json['daysBeforeAbsence'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'minDay': minDay,
        'availableForTimecard': availableForTimecard,
        'maxDay': maxDay,
        'useInBalance': useInBalance,
        'order': order,
        'isRequiredOrderNumber': isRequiredOrderNumber,
        'isSystemRecord': isSystemRecord,
        'isOriginalSheet': isOriginalSheet,
        'active': active,
        'version': version,
        'isCheckWork': isCheckWork,
        'isEcologicalAbsence': isEcologicalAbsence,
        'workOnWeekend': workOnWeekend,
        'overtimeWork': overtimeWork,
        'foreigner': foreigner,
        'temporaryTransfer': temporaryTransfer,
        'cancelParentAbsence': cancelParentAbsence,
        'isDefault': isDefault,
        'availableForLeavingVacation': availableForLeavingVacation,
        'useInSelfService': useInSelfService,
        'ignoreHolidays': ignoreHolidays,
        'availableForChangeDate': availableForChangeDate,
        'code': code,
        'isWorkingDay': isWorkingDay,
        'displayAbsence': displayAbsence,
        'legacyId': legacyId,
        'langValue3': langValue3,
        'langValue': langValue,
        'isJustRequired': isJustRequired,
        'elmaTransfer': elmaTransfer,
        'availableToManager': availableToManager,
        'availableForRecallAbsence': availableForRecallAbsence,
        'langValue2': langValue2,
        'daysAdvance': daysAdvance,
        'numDaysCalendarYear': numDaysCalendarYear,
        'langValue1': langValue1,
        'isVacationDate': isVacationDate,
        'isFileRequired': isFileRequired,
        'isOnlyWorkingDay': isOnlyWorkingDay,
        'includeCalcGzp': includeCalcGzp,
        'daysBeforeAbsence': daysBeforeAbsence,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      }..removeWhere((String key, dynamic value) => value == null);

  Map<String, dynamic> toMapId() => {'id': id};
}
