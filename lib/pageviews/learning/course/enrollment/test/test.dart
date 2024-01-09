import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/test.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/countdown_timer.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class CourseTest extends StatefulWidget {
  final LearningModel model;

  const CourseTest(this.model);

  @override
  _CourseTestState createState() => _CourseTestState();
}

class _CourseTestState extends State<CourseTest> {
  Timer _timer;
  int _start = 5;

  void startTimer() {
    const Duration oneSec = Duration(minutes: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    _start = widget.model.test.timer;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Test test = widget.model.test;
    final List<TestSection> questions = test.testSections;
    final QuestionsAndAnswer currentQuestion =
        questions.first.questionsAndAnswers[widget.model.index];
    return WillPopScope(
      onWillPop: () async {
        showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(S.current.attention),
                content: const Text('Вы уверенны что хотите завершить тестирование.'),
                actions: [
                  MaterialButton(
                    child: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: const Icon(Icons.done),
                    onPressed: () {
                      widget.model.endTest();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },);
        return false;
      },
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text('Вопрос ${widget.model.index + 1}'),
          trailing: SizedBox(
            width: 80,
            child: CountDownTimer(
              secondsRemaining: _start * 60,
              whenTimeExpires: () {},
              countDownTimerStyle:
                  Theme.of(context).textTheme.overline.copyWith(fontSize: 16),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      currentQuestion.text,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  // if test's answer type is text
                  if (currentQuestion.type == 'TEXT') TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (String text){
                      widget.model
                          .answersForCheck[widget.model.index] =
                          text;
                      widget.model.rebuild();
                    },
                  ) else currentQuestion.type == 'NUM'
                  ? TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String text){
                        widget.model
                            .answersForCheck[widget.model.index] =
                            text;
                        widget.model.rebuild();
                      },
                    )
                      // if test has several answers
                  :Column(
                      children: currentQuestion.answers
                          .map(
                              (Answer e) => currentQuestion.type == 'MANY'
                              ? CheckboxListTile(
                            value:
                            widget.model.answersForCheck[widget.model.index] != null
                                ?
                            (widget.model
                                .answersForCheck[widget.model.index]
                            as List)
                                .contains(e.id)
                                : false,
                                onChanged: (bool val) {
                              widget.model.answersForCheck[
                              widget.model.index] ??= [];
                              widget
                                  .model.answersForCheck[widget.model.index]
                                  .toList().contains(e.id)
                              ? widget
                                  .model.answersForCheck[widget.model.index]
                                  .remove(e.id)
                              : widget
                                      .model.answersForCheck[widget.model.index]
                                      .add(e.id);
                              widget.model.rebuild();
                            },
                            title: Text(e.text),
                            isThreeLine: false,
                          )
                              : RadioListTile(
                            title: Text(e.text),
                            isThreeLine: false,
                            value: e.id,
                            groupValue: widget
                                .model.answersForCheck[widget.model.index],
                            onChanged: (val) {
                              widget.model
                                  .answersForCheck[widget.model.index] =
                                  val;
                              widget.model.rebuild();
                            },
                          ),).toList(),
                    )
                  ],
                ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.model.index == 0) const SizedBox() else MaterialButton(
                          child: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            widget.model.index--;
                            widget.model.rebuild();
                          },
                        ),
                  if (widget.model.index ==
                          (questions.first.questionsAndAnswers.length - 1)) SizedBox(
                          width: 120,
                          child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: const Text('Завершить'),
                            onPressed: () => widget.model.endTest(),
                          ),
                        ) else MaterialButton(
                          child: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            widget.model.index++;
                            widget.model.rebuild();
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
