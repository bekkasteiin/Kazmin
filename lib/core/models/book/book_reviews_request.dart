// To parse this JSON data, do
//
//     final bookRequest = bookRequestFromMap(jsonString);

import 'dart:convert';

class BookReviewRequest {
  BookReviewRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.author,
    this.book,
    this.rating,
    this.version,
    this.reviewText,
  });

  String entityName;
  String instanceName;
  String id;
  Author author;
  Book book;
  num rating;
  num version;
  String reviewText;

  factory BookReviewRequest.fromJson(String str) => BookReviewRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookReviewRequest.fromMap(Map<String, dynamic> json) => BookReviewRequest(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    author: json['author'] == null ? null : Author.fromMap(json['author']),
    book: json['book'] == null ? null : Book.fromMap(json['book']),
    rating: json['rating'],
    version: json['version'],
    reviewText: json['reviewText'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'author': author == null ? null : author.toMap(),
    'book': book == null ? null : book.toMap(),
    'rating': rating,
    'version': version,
    'reviewText': reviewText,
  };
}

class Author {
  Author({
    this.entityName,
    this.instanceName,
    this.id,
    this.personFioWithEmployeeNumber,
    this.fioWithEmployeeNumber,
    this.list,
    this.version,
    this.personFirstLastNameLatin,
    this.person,
    this.personLatinFioWithEmployeeNumber,
    this.firstLastName,
    this.fullName,
  });

  String entityName;
  String instanceName;
  String id;
  String personFioWithEmployeeNumber;
  String fioWithEmployeeNumber;
  List<Person> list;
  num version;
  String personFirstLastNameLatin;
  Person person;
  String personLatinFioWithEmployeeNumber;
  String firstLastName;
  String fullName;

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    personFioWithEmployeeNumber: json['personFioWithEmployeeNumber'],
    fioWithEmployeeNumber: json['fioWithEmployeeNumber'],
    list: json['list'] == null ? null : List<Person>.from(json['list'].map((x) => Person.fromMap(x))),
    version: json['version'],
    personFirstLastNameLatin: json['personFirstLastNameLatin'],
    person: json['person'] == null ? null : Person.fromMap(json['person']),
    personLatinFioWithEmployeeNumber: json['personLatinFioWithEmployeeNumber'],
    firstLastName: json['firstLastName'],
    fullName: json['fullName'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'personFioWithEmployeeNumber': personFioWithEmployeeNumber,
    'fioWithEmployeeNumber': fioWithEmployeeNumber,
    'list': list == null ? null : List<dynamic>.from(list.map((Person x) => x.toMap())),
    'version': version,
    'personFirstLastNameLatin': personFirstLastNameLatin,
    'person': person == null ? null : person.toMap(),
    'personLatinFioWithEmployeeNumber': personLatinFioWithEmployeeNumber,
    'firstLastName': firstLastName,
    'fullName': fullName,
  };
}

class Person {
  Person({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.fistLastNameLatin,
    this.employeeNumber,
    this.group,
    this.fioWithEmployeeNumber,
    this.version,
    this.fullNameLatin,
    this.firstName,
    this.shortName,
    this.startDate,
    this.lastNameLatin,
    this.lastName,
    this.firstNameLatin,
    this.firstLastName,
    this.fullName,
    this.personName,
    this.fioWithEmployeeNumberWithSortSupported,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  String fistLastNameLatin;
  String employeeNumber;
  Group group;
  String fioWithEmployeeNumber;
  num version;
  String fullNameLatin;
  String firstName;
  String shortName;
  DateTime startDate;
  String lastNameLatin;
  String lastName;
  String firstNameLatin;
  String firstLastName;
  String fullName;
  String personName;
  String fioWithEmployeeNumberWithSortSupported;

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
    fistLastNameLatin: json['fistLastNameLatin'],
    employeeNumber: json['employeeNumber'],
    group: json['group'] == null ? null : Group.fromMap(json['group']),
    fioWithEmployeeNumber: json['fioWithEmployeeNumber'],
    version: json['version'],
    fullNameLatin: json['fullNameLatin'],
    firstName: json['firstName'],
    shortName: json['shortName'],
    startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
    lastNameLatin: json['lastNameLatin'],
    lastName: json['lastName'],
    firstNameLatin: json['firstNameLatin'],
    firstLastName: json['firstLastName'],
    fullName: json['fullName'],
    personName: json['personName'],
    fioWithEmployeeNumberWithSortSupported: json['fioWithEmployeeNumberWithSortSupported'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'endDate': endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    'fistLastNameLatin': fistLastNameLatin,
    'employeeNumber': employeeNumber,
    'group': group == null ? null : group.toMap(),
    'fioWithEmployeeNumber': fioWithEmployeeNumber,
    'version': version,
    'fullNameLatin': fullNameLatin,
    'firstName': firstName,
    'shortName': shortName,
    'startDate': startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    'lastNameLatin': lastNameLatin,
    'lastName': lastName,
    'firstNameLatin': firstNameLatin,
    'firstLastName': firstLastName,
    'fullName': fullName,
    'personName': personName,
    'fioWithEmployeeNumberWithSortSupported': fioWithEmployeeNumberWithSortSupported,
  };
}

class Group {
  Group({
    this.entityName,
    this.instanceName,
    this.id,
  });

  String entityName;
  String instanceName;
  String id;

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Group.fromMap(Map<String, dynamic> json) => Group(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
  };
}

class Book {
  Book({
    this.entityName,
    this.instanceName,
    this.id,
    this.version,
    this.bookNameLang1,
  });

  String entityName;
  String instanceName;
  String id;
  num version;
  String bookNameLang1;

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    version: json['version'],
    bookNameLang1: json['bookNameLang1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'version': version,
    'bookNameLang1': bookNameLang1,
  };
}
