// To parse this JSON data, do
//
//     final trainingCalendar = trainingCalendarFromMap(jsonString);

import 'dart:convert';
import 'dart:developer';


//import 'package:kzm/core/models/course_schedule.dart';
//import 'package:kzm/core/models/courses/course.dart';

class TrainingCalendar {
  TrainingCalendar({
    this.entityName,
    this.instanceName,
    this.id,
    this.courseSchedule,
    this.status,
    this.address,
  });

  String entityName;
  String instanceName;
  String id;
  CalendarCourseSchedule courseSchedule;
  String status;
  String address;

  factory TrainingCalendar.fromJson(String str) =>
      TrainingCalendar.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory TrainingCalendar.fromMap(Map<String, dynamic> json) {
    log('[json]: $json');

    return TrainingCalendar(
      entityName: json['_entityName'].toString(),
      instanceName: json['_instanceName'].toString(),
      id: json['id'].toString(),
      courseSchedule: CalendarCourseSchedule.fromMap(
        json['courseSchedule'] as Map<String, dynamic>,
      ),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'courseSchedule': courseSchedule.toMap(),
        'status': status,
      };
}

class CalendarCourseSchedule {
  CalendarCourseSchedule({
    this.id,
    this.instanceName,
    this.legacyId,
    this.name,
    this.startDate,
    this.endDate,
    this.registrationIsOpenUntil,
    this.duration,
    this.address,
    this.maxNumberOfPeople,
    this.trainer,
  });

  String id;
  String instanceName;
  String legacyId;
  String name;
  DateTime startDate;
  DateTime endDate;
  DateTime registrationIsOpenUntil;
  double duration;
  String address;
  double maxNumberOfPeople;
  Trainer trainer;

  factory CalendarCourseSchedule.fromJson(String str) {
//log('Json: $str');
    return CalendarCourseSchedule.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory CalendarCourseSchedule.fromMap(Map<String, dynamic> json) => CalendarCourseSchedule(
        id: json['id'].toString(),
        instanceName: json['_instanceName'].toString(),
        legacyId: json['legacyId'].toString(),
        name: json['name'].toString(),
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'].toString())
            : json['startDate'] != null
                ? DateTime.parse(json['startDate'].toString())
                : null,
        endDate: json['end_date'] != null
            ? DateTime.parse(json['end_date'].toString())
            : json['endDate'] != null
                ? DateTime.parse(json['endDate'].toString())
                : null,
        registrationIsOpenUntil: json['registration_is_open_until'] != null
            ? DateTime.parse(json['registration_is_open_until'].toString())
            : null,
        duration: json['duration'] != null ? double.parse(json['duration'].toString()) : null,
        address: json['address']?.toString(),
        maxNumberOfPeople: json['maxNumberOfPeople'] != null
            ? double.parse(json['maxNumberOfPeople'].toString())
            : null,
        trainer: json['trainer'] == null
            ? null
            : Trainer.fromMap(json['trainer'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        '_instanceName': instanceName,
        'legacyId': legacyId,
        'name': name,
        'start_date':
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'end_date':
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'registration_is_open_until':
            "${registrationIsOpenUntil.year.toString().padLeft(4, '0')}-${registrationIsOpenUntil.month.toString().padLeft(2, '0')}-${registrationIsOpenUntil.day.toString().padLeft(2, '0')}",
        'duration': duration,
        'address': address,
        'maxNumberOfPeople': maxNumberOfPeople,
        'trainer': trainer.toMap(),
      };
}

class Trainer {
  Trainer({
    this.id,
    this.employee,
  });

  String id;
  Employee employee;

  factory Trainer.fromJson(String str) {
//log('Json: $str');
    return Trainer.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Trainer.fromMap(Map<String, dynamic> json) => Trainer(
        id: json['id'].toString(),
        employee: json['employee'] == null
            ? null
            : Employee.fromMap(
                json['employee'] as Map<String, dynamic>,
              ),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'employee': employee.toMap(),
      };
}

class Employee {
  Employee({
    this.id,
    this.fullName,
  });

  String id;
  String fullName;

  factory Employee.fromJson(String str) {
//log('Json: $str');
    return Employee.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json['id']?.toString(),
        fullName: json['fullName']?.toString(),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
      };
}
