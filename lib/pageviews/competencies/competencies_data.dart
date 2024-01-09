import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person_assessments_response.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/competencies/competencies_widget.dart';
import 'package:kzm/viewmodels/competencies_model.dart';

class CompetenciesData extends StatelessWidget {
  final CompetenciesModel model;
  final bool opened;

  const CompetenciesData({@required this.model, this.opened = true, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => model.personAssessment(update: true),
      child: ListView(
        children: <Widget>[
          FutureBuilder<List<PersonAssessments>>(
            future: model.personAssessment(),
            builder: (BuildContext context, AsyncSnapshot<List<PersonAssessments>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoaderWidget();
              }
              if (snapshot.data?.isEmpty ?? false) {
                return noData;
              }
              return CompetenciesWidget(
                list: snapshot.data,
                opened: opened,
                participantTypes: model.dicParticipantType,
              );
            },
          )
        ],
      ),
    );
  }
}
