
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/learning_request.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';

class StudyPlanDetailView extends StatelessWidget {
  final LearningRequest learningRequest;
  const StudyPlanDetailView({@required this.learningRequest, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(context: context,),
      body: ListView(
        children: <Widget>[
          contentShadow(
            children: <Widget>[
              FieldBones(
                placeholder: S.current.course,
                textValue: learningRequest.courseName,
              ),
              FieldBones(
                placeholder: S.current.status,
                textValue: learningRequest.status.instanceName,
              ),
              FieldBones(
                placeholder: S.current.startDate,
                textValue: formatShortly(learningRequest.dateFrom),
              ),
              FieldBones(
                placeholder: S.current.endDate,
                textValue: formatShortly(learningRequest.dateTo),
              ),
              FieldBones(
                placeholder: '${S.current.durability} (часы)',
                textValue: learningRequest.numberOfHours?.toString() ?? '',
              ),
              FieldBones(
                placeholder: S.current.category,
                textValue: learningRequest.learningType.instanceName ?? '',
              ),
              FieldBones(
                placeholder: S.current.typeOfTraining,
                textValue: learningRequest.typeOfTraining.langValue1 ?? '',
              ),
              FieldBones(
                placeholder: S.current.description,
                textValue: learningRequest.courseDescription ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
