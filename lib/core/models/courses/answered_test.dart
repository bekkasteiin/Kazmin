import 'dart:convert';

class AnsweredTest {
  String attemptId;
  List<AttemptQuestionPojo> questionsAndAnswers;

  String toJson() => jsonEncode(
        {
          'attemptId': attemptId,
          'questionsAndAnswers': questionsAndAnswers == null
              ? null
              : List<dynamic>.from(questionsAndAnswers.map((AttemptQuestionPojo x) => x.toMap())),
        },
      );
}

class AttemptQuestionPojo {
  String questionId;
  List<String> answer;

  AttemptQuestionPojo({this.questionId, this.answer});

  Map<String, dynamic> toMap() => {
        'questionId': questionId,
        'answer':
            answer == null ? null : List<dynamic>.from(answer.map((String x) => x)),
      };
}
