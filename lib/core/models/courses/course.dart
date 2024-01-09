// To parse this JSON data, do
//
//     final course = courseFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/courses/enrollment.dart';
import 'package:kzm/core/models/courses/test.dart';
import 'package:kzm/core/models/person/person.dart';

class Course {
  Course({
    this.entityName,
    this.instanceName,
    this.id,
    this.preRequisition,
    this.description,
    this.courseSchedule,
    this.isOnline,
    this.selfEnrollment,
    this.logo,
    this.courseTrainers,
    this.sections,
    this.enrollments,
    this.feedbackTemplates,
    this.competences,
    this.name,
    this.category,
    this.learningType,
    this.targetAudience,
    this.activeFlag,
    this.shortDescription,
    this.rating,
    this.educationDuration,
    this.educationPeriod,
  });

  String entityName;
  String instanceName;
  String id;
  List<LearningType> preRequisition;
  String description;
  List<CourseScheduleElement> courseSchedule;
  bool isOnline;
  bool selfEnrollment;
  FileDescriptor logo;
  List<CourseTrainer> courseTrainers;
  List<Section> sections;
  List<Enrollment> enrollments;
  List<dynamic> feedbackTemplates;
  List<dynamic> competences;
  String name;
  double rating;
  int educationDuration;
  int educationPeriod;
  AbstractDictionary category;
  LearningType learningType;
  String targetAudience;
  bool activeFlag;
  String shortDescription;

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        preRequisition: json['preRequisition'] == null ? [] : List<LearningType>.from(json['preRequisition'].map((x) => LearningType.fromMap(x))),
        description: json['description'],
        courseSchedule:
            json['courseSchedule'] == null ? [] : List<CourseScheduleElement>.from(json['courseSchedule'].map((x) => CourseScheduleElement.fromMap(x))),
        isOnline: json['isOnline'],
        selfEnrollment: json['selfEnrollment'],
        logo: json['logo'] == null ? null : FileDescriptor.fromMap(json['logo']),
        rating: 0,
        educationDuration: json['educationDuration'],
        educationPeriod: json['educationPeriod']??0,
        courseTrainers: json['courseTrainers'] == null ? [] : List<CourseTrainer>.from(json['courseTrainers'].map((x) => CourseTrainer.fromMap(x))),
        sections: json['sections'] == null ? [] : List<Section>.from(json['sections'].map((x) => Section.fromMap(x))),
        enrollments: json['enrollments'] == null ? [] : List<Enrollment>.from(json['enrollments'].map((x) => Enrollment.fromMap(x))),
        feedbackTemplates: json['feedbackTemplates'] == null ? [] : List<dynamic>.from(json['feedbackTemplates'].map((x) => x)),
        competences: json['competences'] == null ? [] : List<dynamic>.from(json['competences'].map((x) => x)),
        name: json['name'],
        category: json['subCategory'] == null ? null : AbstractDictionary.fromMap(json['subCategory']),
        learningType: json['learningType'] == null ? null : LearningType.fromMap(json['learningType']),
        targetAudience: json['targetAudience'],
        activeFlag: json['activeFlag'],
        shortDescription: json['shortDescription'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'preRequisition': preRequisition == null ? null : List<dynamic>.from(preRequisition.map((LearningType x) => x.toMap())),
        'description': description,
        'courseSchedule': courseSchedule == null ? null : List<dynamic>.from(courseSchedule.map((CourseScheduleElement x) => x.toMap())),
        'isOnline': isOnline,
        'selfEnrollment': selfEnrollment,
        'logo': logo,
        'courseTrainers': courseTrainers == null ? null : List<dynamic>.from(courseTrainers.map((CourseTrainer x) => x.toMap())),
        'sections': sections == null ? null : List<dynamic>.from(sections.map((Section x) => x.toMap())),
        'enrollments': enrollments == null ? null : List<dynamic>.from(enrollments.map((Enrollment x) => x.toMap())),
        'feedbackTemplates': feedbackTemplates == null ? null : List<dynamic>.from(feedbackTemplates.map((x) => x)),
        'competences': competences == null ? null : List<dynamic>.from(competences.map((x) => x)),
        'name': name,
        'category': category == null ? null : category.toMap(),
        'learningType': learningType == null ? null : learningType.toMap(),
        'targetAudience': targetAudience,
        'activeFlag': activeFlag,
        'shortDescription': shortDescription,
      };
}

class CourseScheduleElement {
  CourseScheduleElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.address,
    this.endDate,
    this.learningCenter,
    this.name,
    this.course,
    this.maxNumberOfPeople,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  String address;
  DateTime endDate;
  LearningType learningCenter;
  String name;
  CourseTrainer course;
  int maxNumberOfPeople;
  DateTime startDate;

  factory CourseScheduleElement.fromJson(String str) => CourseScheduleElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseScheduleElement.fromMap(Map<String, dynamic> json) => CourseScheduleElement(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        address: json['address'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        learningCenter: json['learningCenter'] == null ? null : LearningType.fromMap(json['learningCenter']),
        name: json['name'],
        course: json['course'] == null ? null : CourseTrainer.fromMap(json['course']),
        maxNumberOfPeople: json['maxNumberOfPeople'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'address': address,
        'endDate': endDate == null ? null : endDate.toIso8601String(),
        'learningCenter': learningCenter == null ? null : learningCenter.toMap(),
        'name': name,
        'course': course == null ? null : course.toMap(),
        'maxNumberOfPeople': maxNumberOfPeople,
        'startDate': startDate == null ? null : startDate.toIso8601String(),
      };
}

class CourseTrainer {
  CourseTrainer({
    this.entityName,
    this.instanceName,
    this.id,
    this.trainer,
    this.employee,
    this.list,
    this.course,
  });

  String entityName;
  String instanceName;
  String id;
  CourseTrainer trainer;
  GroupElement employee;
  List<ListElement> list;
  CourseTrainer course;

  factory CourseTrainer.fromJson(String str) => CourseTrainer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseTrainer.fromMap(Map<String, dynamic> json) => CourseTrainer(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        trainer: json['trainer'] == null ? null : CourseTrainer.fromMap(json['trainer']),
        employee: json['employee'] == null ? null : GroupElement.fromMap(json['employee']),
        list: json['list'] == null ? null : List<ListElement>.from(json['list'].map((x) => ListElement.fromMap(x))),
        course: json['course'] == null ? null : CourseTrainer.fromMap(json['course']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'trainer': trainer == null ? null : trainer.toMap(),
        'employee': employee == null ? null : employee.toMap(),
        'list': list == null ? null : List<dynamic>.from(list.map((ListElement x) => x.toMap())),
        'course': course == null ? null : course.toMap(),
      };
}

class ListElement {
  ListElement({
    this.entityName,
    this.instanceName,
    this.id,
    this.employeeNumber,
    this.firstName,
    this.startDate,
    this.lastName,
    this.middleName,
    this.endDate,
  });

  String entityName;
  String instanceName;
  String id;
  String employeeNumber;
  String firstName;
  DateTime startDate;
  String lastName;
  String middleName;
  DateTime endDate;

  factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        employeeNumber: json['employeeNumber'],
        firstName: json['firstName'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        lastName: json['lastName'],
        middleName: json['middleName'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'employeeNumber': employeeNumber,
        'firstName': firstName,
        'startDate': startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        'lastName': lastName,
        'middleName': middleName,
        'endDate': endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class LearningType {
  LearningType({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.langValue1,
    this.requisitionCourse,
  });

  String entityName;
  String instanceName;
  String id;
  String code;
  String langValue1;
  RequisitionCourse requisitionCourse;

  factory LearningType.fromJson(String str) => LearningType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LearningType.fromMap(Map<String, dynamic> json) => LearningType(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        langValue1: json['langValue1'],
        requisitionCourse: json['requisitionCourse'] == null ? null : RequisitionCourse.fromMap(json['requisitionCourse']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'langValue1': langValue1,
        'requisitionCourse': requisitionCourse == null ? null : requisitionCourse.toMap(),
      };
}

class RequisitionCourse {
  RequisitionCourse({
    this.entityName,
    this.instanceName,
    this.id,
    this.description,
    this.selfEnrollment,
    this.logo,
    this.targetAudience,
    this.name,
    this.category,
  });

  String entityName;
  String instanceName;
  String id;
  String description;
  bool selfEnrollment;
  String logo;
  String targetAudience;
  String name;
  AbstractDictionary category;

  factory RequisitionCourse.fromJson(String str) => RequisitionCourse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RequisitionCourse.fromMap(Map<String, dynamic> json) => RequisitionCourse(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        description: json['description'],
        selfEnrollment: json['selfEnrollment'],
        logo: json['logo'],
        targetAudience: json['targetAudience'],
        name: json['name'],
        category: json['category'] == null ? null : AbstractDictionary.fromMap(json['category']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'description': description,
        'selfEnrollment': selfEnrollment,
        'logo': logo,
        'targetAudience': targetAudience,
        'name': name,
        'category': category == null ? null : category.toMap(),
      };
}

class EnrollmentCourseSchedule {
  EnrollmentCourseSchedule({
    this.entityName,
    this.instanceName,
    this.id,
    this.endDate,
    this.name,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  DateTime endDate;
  String name;
  DateTime startDate;

  factory EnrollmentCourseSchedule.fromJson(String str) => EnrollmentCourseSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EnrollmentCourseSchedule.fromMap(Map<String, dynamic> json) => EnrollmentCourseSchedule(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        name: json['name'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'endDate': endDate == null ? null : endDate.toIso8601String(),
        'name': name,
        'startDate': startDate == null ? null : startDate.toIso8601String(),
      };
}

class Section {
  Section({
    this.entityName,
    this.instanceName,
    this.id,
    this.courseSectionAttempts,
    this.session,
    this.format,
    this.mandatory,
    this.sectionName,
    this.sectionObject,
    this.order,
    this.description,
  });

  String entityName;
  String instanceName;
  String id;
  List<CourseSectionAttempt> courseSectionAttempts;
  List<Session> session;
  AbstractDictionary format;
  bool mandatory;
  String sectionName;
  SectionObject sectionObject;
  int order;
  String description;

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> json) => Section(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        courseSectionAttempts: json['courseSectionAttempts'] == null
            ? null
            : List<CourseSectionAttempt>.from(json['courseSectionAttempts'].map((x) => CourseSectionAttempt.fromMap(x))),
        session: json['session'] == null ? null : List<Session>.from(json['session'].map((x) => Session.fromMap(x))),
        format: json['format'] == null ? null : AbstractDictionary.fromMap(json['format']),
        mandatory: json['mandatory'],
        sectionName: json['sectionName'],
        sectionObject: json['sectionObject'] == null ? null : SectionObject.fromMap(json['sectionObject']),
        order: json['order'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'courseSectionAttempts': courseSectionAttempts == null ? null : List<dynamic>.from(courseSectionAttempts.map((CourseSectionAttempt x) => x.toMap())),
        'session': session == null ? null : List<dynamic>.from(session.map((Session x) => x.toMap())),
        'format': format == null ? null : format.toMap(),
        'mandatory': mandatory,
        'sectionName': sectionName,
        'sectionObject': sectionObject == null ? null : sectionObject.toMap(),
        'order': order,
        'description': description,
      };
}

class CourseSectionAttempt {
  CourseSectionAttempt({
    this.entityName,
    this.instanceName,
    this.id,
    this.courseSection,
    this.attemptDate,
    this.enrollment,
    this.activeAttempt,
    this.success,
  });

  String entityName;
  String instanceName;
  String id;
  CourseTrainer courseSection;
  DateTime attemptDate;
  Enrollment enrollment;
  bool activeAttempt;
  bool success;

  factory CourseSectionAttempt.fromJson(String str) => CourseSectionAttempt.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseSectionAttempt.fromMap(Map<String, dynamic> json) => CourseSectionAttempt(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        courseSection: json['courseSection'] == null ? null : CourseTrainer.fromMap(json['courseSection']),
        attemptDate: json['attemptDate'] == null ? null : DateTime.parse(json['attemptDate']),
        enrollment: json['enrollment'] == null ? null : Enrollment.fromMap(json['enrollment']),
        activeAttempt: json['activeAttempt'],
        success: json['success'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'courseSection': courseSection == null ? null : courseSection.toMap(),
        'attemptDate': attemptDate == null
            ? null
            : "${attemptDate.year.toString().padLeft(4, '0')}-${attemptDate.month.toString().padLeft(2, '0')}-${attemptDate.day.toString().padLeft(2, '0')}",
        'enrollment': enrollment == null ? null : enrollment.toMap(),
        'activeAttempt': activeAttempt,
        'success': success,
      };
}

class SectionObject {
  SectionObject({
    this.entityName,
    this.instanceName,
    this.id,
    this.content,
    this.test,
  });

  String entityName;
  String instanceName;
  String id;
  Content content;
  Test test;

  factory SectionObject.fromJson(String str) => SectionObject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectionObject.fromMap(Map<String, dynamic> json) => SectionObject(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        content: json['content'] == null ? null : Content.fromMap(json['content']),
        test: json['test'] == null ? null : Test.fromMap(json['test']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'content': content == null ? null : content.toMap(),
        'test': test == null ? null : test.toMap(),
      };
}

class Content {
  Content({
    this.entityName,
    this.instanceName,
    this.id,
    this.description,
    this.file,
    this.objectName,
    this.contentType,
    this.html,
    this.text,
    this.url,
  });

  String entityName;
  String instanceName;
  String id;
  String description;
  FileDescriptor file;
  String objectName;
  String contentType;
  String html;
  String text;
  String url;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        description: json['description'],
        file: json['file'] == null ? null : FileDescriptor.fromMap(json['file']),
        objectName: json['objectName'],
        contentType: json['contentType'],
        html: json['html'],
        text: json['text'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'description': description,
        'file': file == null ? null : file.toMap(),
        'objectName': objectName,
        'contentType': contentType,
        'html': html,
        'text': text,
        'url': url,
      };
}

class Session {
  Session({
    this.entityName,
    this.instanceName,
    this.id,
    this.courseSection,
    this.endDate,
    this.maxPerson,
    this.learningCenter,
    this.startDate,
  });

  String entityName;
  String instanceName;
  String id;
  CourseTrainer courseSection;
  DateTime endDate;
  int maxPerson;
  AbstractDictionary learningCenter;
  DateTime startDate;

  factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        courseSection: json['courseSection'] == null ? null : CourseTrainer.fromMap(json['courseSection']),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
        maxPerson: json['maxPerson'],
        learningCenter: json['learningCenter'] == null ? null : AbstractDictionary.fromMap(json['learningCenter']),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'courseSection': courseSection == null ? null : courseSection.toMap(),
        'endDate': endDate == null ? null : endDate.toIso8601String(),
        'maxPerson': maxPerson,
        'learningCenter': learningCenter == null ? null : learningCenter.toMap(),
        'startDate': startDate == null ? null : startDate.toIso8601String(),
      };
}

class Rating {
  Rating({
    this.key,
    this.value,
  });

  double key;
  int value;

  factory Rating.fromJson(String str) => Rating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        key: json['key'].toDouble(),
        value: json['value'],
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'value': value,
      };
}

class CourseReview {
  CourseReview({
    this.entityName,
    this.instanceName,
    this.id,
    this.personGroup,
    this.rate,
    this.course,
    this.text,
  });

  String entityName;
  String instanceName;
  String id;
  PersonGroup personGroup;
  num rate;
  Course course;
  String text;

  factory CourseReview.fromJson(String str) => CourseReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseReview.fromMap(Map<String, dynamic> json) => CourseReview(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        personGroup: json['personGroup'] == null ? null : PersonGroup.fromMap(json['personGroup']),
        rate: json['rate'],
        course: json['course'] == null ? null : Course.fromMap(json['course']),
        text: json['text'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'personGroup': personGroup == null ? null : personGroup.toMap(),
        'rate': rate,
        'course': course == null ? null : course.toMap(),
        'text': text,
      };
}
