// import 'dart:convert';
//
// import 'package:hive/hive.dart';
// import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
// import 'package:kzm/core/models/assignment/assignment.dart';
//
// import '../../ui_design.dart';
//
// @HiveType(typeId: 14)
// class VacationSchedule{
//   VacationSchedule({
//     this.entityName,
//     this.id,
//     this.status,
//     this.absenceDays,
//     this.personGroup,
//     this.startDate,
//     this.endDate,
//   });
//
//   @HiveField(0)
//   String entityName;
//   @HiveField(1)
//   String id;
//   @HiveField(2)
//   AbstractDictionary status;
//   @HiveField(3)
//   int absenceDays;
//   @HiveField(4)
//   PersonGroup personGroup;
//   @HiveField(5)
//   DateTime startDate;
//   @HiveField(6)
//   DateTime endDate;
//
//
//   factory VacationSchedule.fromJson(String str) =>
//       VacationSchedule.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//
//   factory VacationSchedule.fromMap(Map<String, dynamic> json) => VacationSchedule(
//     entityName: json["_entityName"] == null ? null : json["_entityName"],
//     id: json["id"] == null ? null : json["id"],
//     personGroup: json["personGroup"] == null
//         ? null
//         : PersonGroup.fromMap(json["personGroup"]),
//     startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
//     endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
//     absenceDays: json["absenceDays"] == null ? null : json["absenceDays"],
//     status: json["status"] == null
//         ? null
//         : AbstractDictionary.fromMap(json["status"]),
//   );
//
//
//   Map<String, dynamic> toMap() => {
//     "_entityName": entityName == null ? null : entityName,
//     "id": id == null ? null : id,
//     "personGroup": personGroup == null ? null : personGroup.toMap(),
//     "startDate": startDate == null
//         ? null
//         : formatFullRest(startDate),
//     "endDate": endDate == null
//         ? null
//         : formatFullRest(endDate),
//     "absenceDays": absenceDays == null ? null : absenceDays,
//     "status": status == null ? null : status.toMap(),
//   };
//
//   Map<String, dynamic> toMapId() => {
//     "id": id == null ? null : id
//   };
//
// }
//
