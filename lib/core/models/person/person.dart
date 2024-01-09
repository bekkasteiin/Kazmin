import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/assignment/assignment_element.dart';
import 'package:kzm/core/models/person/address.dart';
import 'package:kzm/core/models/person/person_document.dart';

part 'person.g.dart';

class PersonGroup {
  PersonGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.personFioWithEmployeeNumber,
    this.createTs,
    this.fioWithEmployeeNumber,
    this.list,
    this.version,
    this.personFirstLastNameLatin,
    this.person,
    this.personLatinFioWithEmployeeNumber,
    this.firstLastName,
    this.fullName,
    this.createdBy,
    this.updateTs,
    this.assignments,
    this.addresses,
    this.personDocuments,
  });

  String entityName;
  String instanceName;
  String id;
  String personFioWithEmployeeNumber;
  DateTime createTs;
  String fioWithEmployeeNumber;
  List<Person> list;
  List<AssignmentElement> assignments;
  int version;
  String personFirstLastNameLatin;
  Person person;
  String personLatinFioWithEmployeeNumber;
  String firstLastName;
  String fullName;
  String createdBy;
  DateTime updateTs;
  List<Address> addresses;
  List<PersonDocument> personDocuments;

  AssignmentElement get currentAssignment {
    return assignments.where((AssignmentElement element) {
      final DateTime dateTime = DateTime.now();
      return dateTime.isBefore(element.endDate) && element.primaryFlag && dateTime.isAfter(element.startDate);
    }).first;
  }

  factory PersonGroup.fromJson(String str) => PersonGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonGroup.fromMap(Map<String, dynamic> json) => PersonGroup(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        personFioWithEmployeeNumber: json['personFioWithEmployeeNumber'],
        createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs']),
        fioWithEmployeeNumber: json['fioWithEmployeeNumber'],
        // list: json["list"] == null ? null : List<Person>.from(json["list"].map((x) => Person.fromMap(x))),
        list: json['list'] == null ? null : (json['list'] as List<dynamic>).map((dynamic e) => Person.fromMap(e as Map<String, dynamic>)).toList(),
        addresses: json['addresses'] == null ? null : List<Address>.from(json['addresses'].map((x) => Address.fromMap(x))),
        personDocuments: json['personDocuments'] == null ? null : List<PersonDocument>.from(json['personDocuments'].map((x) => PersonDocument.fromMap(x))),
        assignments: json['assignments'] == null ? null : List<AssignmentElement>.from(json['assignments'].map((x) => AssignmentElement.fromMap(x))),
        version: json['version'],
        personFirstLastNameLatin: json['personFirstLastNameLatin'],
        person: json['person'] == null ? null : Person.fromMap(json['person']),
        personLatinFioWithEmployeeNumber: json['personLatinFioWithEmployeeNumber'],
        firstLastName: json['firstLastName'],
        fullName: json['fullName'],
        createdBy: json['createdBy'],
        updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'personFioWithEmployeeNumber': personFioWithEmployeeNumber,
        'createTs': createTs == null ? null : formatFullRest(createTs),
        'fioWithEmployeeNumber': fioWithEmployeeNumber,
        // "list": list == null ? null : List<Person>.from(list.map((x) => x.toMap())),
        'list': list?.map((Person e) => e.toMap())?.toList(),
        'assignments': assignments == null ? null : List<AssignmentElement>.from(assignments.map((AssignmentElement x) => x.toMap())),
        'version': version,
        'personFirstLastNameLatin': personFirstLastNameLatin,
        'person': person == null ? null : person.toMap(),
        'personLatinFioWithEmployeeNumber': personLatinFioWithEmployeeNumber,
        'firstLastName': firstLastName,
        'fullName': fullName,
        'createdBy': createdBy,
        'updateTs': updateTs == null ? null : formatFullRest(updateTs),
      }..removeWhere((String key, dynamic value) => value == null);

  Map<String, dynamic> toMapId() => {'id': id};
}

@HiveType(typeId: 16)
class Person {
  Person({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.fistLastNameLatin,
    this.employeeNumber,
    this.createTs,
    this.group,
    this.fioWithEmployeeNumber,
    this.version,
    this.fullNameLatin,
    this.fullNameCyrillic,
    this.firstName,
    this.fullNameNumberCyrillic,
    this.shortName,
    this.startDate,
    this.lastNameLatin,
    this.lastName,
    this.firstNameLatin,
    this.firstLastName,
    this.hireDate,
    this.fullName,
    this.dateOfBirth,
    this.createdBy,
    this.fioWithEmployeeNumberWithSortSupported,
    this.updateTs,
    this.nationalIdentifier,
    this.middleName,
    this.image,
    this.sex,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  String fistLastNameLatin;
  @HiveField(5)
  String employeeNumber;
  @HiveField(6)
  DateTime createTs;
  @HiveField(7)
  GroupElement group;
  @HiveField(8)
  String fioWithEmployeeNumber;
  @HiveField(9)
  int version;
  @HiveField(10)
  String nationalIdentifier;
  @HiveField(11)
  String fullNameLatin;
  @HiveField(12)
  String fullNameCyrillic;
  @HiveField(13)
  String firstName;
  @HiveField(14)
  String middleName;
  @HiveField(29)
  AbstractDictionary sex;
  @HiveField(15)
  String fullNameNumberCyrillic;
  @HiveField(16)
  String shortName;
  @HiveField(17)
  DateTime startDate;
  @HiveField(18)
  String lastNameLatin;
  @HiveField(19)
  String lastName;
  @HiveField(20)
  String firstNameLatin;
  @HiveField(21)
  String firstLastName;
  @HiveField(22)
  DateTime hireDate;
  @HiveField(23)
  String fullName;
  @HiveField(24)
  DateTime dateOfBirth;
  @HiveField(25)
  String createdBy;
  @HiveField(26)
  String fioWithEmployeeNumberWithSortSupported;
  @HiveField(27)
  DateTime updateTs;
  @HiveField(28)
  FileDescriptor image;

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        nationalIdentifier: json['nationalIdentifier'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        fistLastNameLatin: json['fistLastNameLatin'],
        employeeNumber: json['employeeNumber'],
        createTs: json['createTs'] == null ? null : DateTime.parse(json['createTs']),
        group: json['group'] == null ? null : GroupElement.fromMap(json['group']),
        sex: json['sex'] == null ? null : AbstractDictionary.fromMap(json['sex']),
        image: json['image'] == null ? null : FileDescriptor.fromMap(json['image']),
        fioWithEmployeeNumber: json['fioWithEmployeeNumber'],
        version: json['version'],
        fullNameLatin: json['fullNameLatin'],
        fullNameCyrillic: json['fullNameCyrillic'],
        firstName: json['firstName'],
        fullNameNumberCyrillic: json['fullNameNumberCyrillic'],
        shortName: json['shortName'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        lastNameLatin: json['lastNameLatin'],
        lastName: json['lastName'],
        middleName: json['middleName'],
        firstNameLatin: json['firstNameLatin'],
        firstLastName: json['firstLastName'],
        hireDate: json['hireDate'] == null ? null : DateTime.parse(json['hireDate']),
        fullName: json['fullName'],
        dateOfBirth: json['dateOfBirth'] == null ? null : DateTime.parse(json['dateOfBirth']),
        createdBy: json['createdBy'],
        fioWithEmployeeNumberWithSortSupported: json['fioWithEmployeeNumberWithSortSupported'],
        updateTs: json['updateTs'] == null ? null : DateTime.parse(json['updateTs']),
      );

  Map<String, dynamic> toMapId() => {
        'id': id,
      };

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'nationalIdentifier': nationalIdentifier,
        'id': id,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        'fistLastNameLatin': fistLastNameLatin,
        'employeeNumber': employeeNumber,
        'createTs': createTs == null ? null : createTs.toIso8601String(),
        'group': group == null ? null : group.toMap(),
        'sex': sex == null ? null : sex.toMap(),
        'fioWithEmployeeNumber': fioWithEmployeeNumber,
        'version': version,
        'fullNameLatin': fullNameLatin,
        'fullNameCyrillic': fullNameCyrillic,
        'firstName': firstName,
        'fullNameNumberCyrillic': fullNameNumberCyrillic,
        'shortName': shortName,
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'lastNameLatin': lastNameLatin,
        'lastName': lastName,
        'middleName': middleName,
        'firstNameLatin': firstNameLatin,
        'firstLastName': firstLastName,
        'hireDate': hireDate == null
            ? null
            : "${hireDate.year.toString().padLeft(4, '0')}-${hireDate.month.toString().padLeft(2, '0')}-${hireDate.day.toString().padLeft(2, '0')}",
        'fullName': fullName,
        'dateOfBirth': dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        'createdBy': createdBy,
        'fioWithEmployeeNumberWithSortSupported': fioWithEmployeeNumberWithSortSupported,
        'updateTs': updateTs == null ? null : updateTs.toIso8601String(),
      };
}
