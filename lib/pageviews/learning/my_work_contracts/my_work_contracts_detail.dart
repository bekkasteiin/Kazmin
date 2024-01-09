import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person_learning_contract.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';

class MyWorkContractsDetail extends StatelessWidget {
  final PersonLearningContract personLearningContract;
  final String balance;

  const MyWorkContractsDetail({@required this.personLearningContract, @required this.balance, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: ListView(
        children: <Widget>[
          contentShadow(
            children: <Widget>[
              FieldBones(
                placeholder: S.current.course,
                textValue: personLearningContract?.courseScheduleEnrollment?.courseSchedule?.instanceName ?? '',
              ),
              FieldBones(
                placeholder: S.current.contractNumber,
                textValue: personLearningContract.contractNumber,
              ),
              FieldBones(
                placeholder: S.current.workingTime,
                textValue: formatShortly(personLearningContract.contractDate),
              ),
              FieldBones(
                placeholder: S.current.contractDate,
                textValue: formatShortly(personLearningContract.termOfService),
              ),
              FieldBones(
                placeholder: S.current.contractAmount,
                textValue: personLearningContract.courseScheduleEnrollment.totalCost?.toString() ?? '',
              ),
              FieldBones(
                placeholder: S.current.balance,
                textValue: personLearningContract.courseScheduleEnrollment.totalCost != null ? balance : '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
