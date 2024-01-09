// To parse this JSON data, do
//
//     final test = testFromMap(jsonString);

import 'dart:convert';

class Test {
  Test({
    this.attemptId,
    this.timer,
    this.testSections,
    this.entityName,
    this.id,
    this.instanceName,
  });

  String id;
  String entityName;
  String instanceName;
  String attemptId;
  int timer;
  List<TestSection> testSections;

  factory Test.fromJson(String str) => Test.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Test.fromMap(Map<String, dynamic> json) => Test(
        entityName: json['_entityName'],
        instanceName:
            json['instanceName'],
        id: json['id'],
        attemptId: json['attemptId'],
        timer: json['timer'],
        testSections: json['testSections'] == null
            ? null
            : List<TestSection>.from(
                json['testSections'].map((x) => TestSection.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'attemptId': attemptId,
        'timer': timer,
        'testSections': testSections == null
            ? null
            : List<dynamic>.from(testSections.map((TestSection x) => x.toMap())),
      };
}

class TestSection {
  TestSection({
    this.id,
    this.name,
    this.questionsAndAnswers,
  });

  String id;
  String name;
  List<QuestionsAndAnswer> questionsAndAnswers;

  factory TestSection.fromJson(String str) =>
      TestSection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TestSection.fromMap(Map<String, dynamic> json) => TestSection(
        id: json['id'],
        name: json['name'],
        questionsAndAnswers: json['questionsAndAnswers'] == null
            ? null
            : List<QuestionsAndAnswer>.from(json['questionsAndAnswers']
                .map((x) => QuestionsAndAnswer.fromMap(x)),),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'questionsAndAnswers': questionsAndAnswers == null
            ? null
            : List<dynamic>.from(questionsAndAnswers.map((QuestionsAndAnswer x) => x.toMap())),
      };
}

class QuestionsAndAnswer {
  QuestionsAndAnswer({
    this.id,
    this.text,
    this.type,
    this.answers,
  });

  String id;
  String text;
  String type;
  List<Answer> answers;

  factory QuestionsAndAnswer.fromJson(String str) =>
      QuestionsAndAnswer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionsAndAnswer.fromMap(Map<String, dynamic> json) =>
      QuestionsAndAnswer(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        answers: json['answers'] == null
            ? null
            : List<Answer>.from(json['answers'].map((x) => Answer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
        'type': type,
        'answers': answers == null
            ? null
            : List<dynamic>.from(answers.map((Answer x) => x.toMap())),
      };
}

class Answer {
  Answer({
    this.id,
    this.text,
  });

  String id;
  String text;

  factory Answer.fromJson(String str) => Answer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Answer.fromMap(Map<String, dynamic> json) => Answer(
        id: json['id'],
        text: json['text'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
      };
}
