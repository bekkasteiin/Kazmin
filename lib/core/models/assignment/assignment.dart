import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:kzm/core/models/assignment/assignment_element.dart';
import 'package:kzm/core/models/person/person.dart';

part 'assignment.g.dart';

@HiveType(typeId: 3)
class PersonGroup {
  PersonGroup({
    this.entityName,
    this.instanceName,
    this.id,
    this.assignments,
    this.list,
    this.person,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  List<AssignmentElement> assignments;
  @HiveField(4)
  List<Person> list;
  @HiveField(5)
  Person person;

  AssignmentElement get currentAssignment {
    return assignments.where((AssignmentElement element) {
      final DateTime dateTime = DateTime.now();
      return dateTime.isBefore(element.endDate) &&
          dateTime.isAfter(element.startDate);
    }).first;
  }

  factory PersonGroup.fromJson(String str) =>
      PersonGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonGroup.fromMap(Map<String, dynamic> json) => PersonGroup(
        entityName: json['_entityName'],
        instanceName:
            json['_instanceName'],
        id: json['id'],
        assignments: json['assignments'] == null
            ? []
            : List<AssignmentElement>.from(
                json['assignments'].map((x) => AssignmentElement.fromMap(x)),),
        list: json['list'] == null
            ? []
            : List<Person>.from(json['list'].map((x) => Person.fromMap(x))),
        person: json['person'] == null ? null : Person.fromMap(json['person']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'assignments': assignments == null
            ? null
            : List<dynamic>.from(assignments.map((AssignmentElement x) => x.toMap())),
        'list': list == null
            ? null
            : List<dynamic>.from(list.map((Person x) => x.toMap())),
        'person': person == null ? null : person.toMap(),
      };

  Map<String, dynamic> toMapId() => {
    'id': id
  };
}
