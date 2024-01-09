import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person_assessment_form.dart';
import 'package:kzm/core/models/person_assessments_response.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/competencies/competencies_form_view.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/viewmodels/competencies_model.dart';

class CompetenciesModel extends BaseModel {
  List<PersonAssessments> personAssessments;
  List<AbstractDictionary> dicParticipantType;

  PersonAssessments selectedPersonAssessment;

  // PersonAssessmentForm personAssessmentForm;
  String currentPgId;
  int personAssessmentFormIndex = 0;

  Future<List<PersonAssessments>> personAssessment(
      {bool update = false}) async {
    if (personAssessments == null || update) {
      dicParticipantType = await RestServices.getDicParticipantType();
      personAssessments = await RestServices.getPersonAssessments();
      setBusy();
    }
    return personAssessments;
  }

  Future<void> openAssesment(PersonAssessments e) async {
    currentPgId = await HiveUtils.getPgId();
    selectedPersonAssessment = e;
    setBusy(true);
    try {
      // tsadv_AssessmentDetail

      final List<PersonAssessmentForm> personAssessmentForms =
          await RestServices.getPersonAssessmentForm(
              selectedPersonAssessment.personAssessmentId);
      // selectedPersonAssessment.personAssessmentForms =;
      List<PersonAssessmentForm> competence;
      competence = personAssessmentForms
          .where((PersonAssessmentForm element) =>
              element.entityName != 'tsadv_AssessmentDetail')
          .toList();
      for (final PersonAssessmentForm el in competence) {
        el.indicators = personAssessmentForms
            .where(
              (PersonAssessmentForm element) =>
                  element.entityName == 'tsadv_AssessmentDetail' &&
                  element.assessmentCompetenceId == el.assessmentCompetenceId,
            )
            .toList();
      }
      selectedPersonAssessment.competenses = competence;
      // personAssessmentForm = selectedPersonAssessment.personAssessmentForms.first;
      personAssessmentFormIndex = 0;
      setBusy();
      Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<CompetenciesModel>.value(
            value: this,
            child: const CompetenciesFormView(),
          ),
        ),
      );
    } catch (e) {
      BaseModel.showAttention(middleText: 'Ошибка');
      setBusy();
    }
  }

  // bool get participantType {
  //   if (selectedPersonAssessment.participantTypeCode == 'EMPLOYEE') {
  //     return true;
  //   } else if (selectedPersonAssessment.participantTypeCode == 'MANAGER') {
  //     return false;
  //   } else {
  //     return null;
  //   }
  // }

  Future<bool> updatePersonAssessmentForm() async {
    if (selectedPersonAssessment.statusCode == 'CLOSED' ||
        selectedPersonAssessment.participantStatusCode == 'SEND') {
      return true;
    }
    setBusy(true);

    // String id;
    // String scaleLavelId;
    bool resultAssesment;
    // final Participant participant = selectedPersonAssessment.competenses[personAssessmentFormIndex].participants.firstWhere(
    //   (Participant element) => element.personGroupId == currentPgId,
    //   orElse: () => null,
    // );
    final List<PersonAssessmentForm> list = <PersonAssessmentForm>[];
    for (final PersonAssessmentForm el in selectedPersonAssessment
        .competenses[personAssessmentFormIndex].indicators) {
      final Participant v = el.participants.firstWhere(
          (Participant element) =>
              element.scaleLevelId == null &&
              element.personGroupId == currentPgId,
          orElse: () => null);
      if (v != null) {
        list.add(el);
      }
    }
    // .where((PersonAssessmentForm e){
    //   return (e.participants.firstWhere((Participant element) => element.scaleLevelId == null)) == null;
    // }).toList();
    // // bool result;
    if (list.isNotEmpty) {
      setBusy();
      showSnacbar(S.current.periodExpiredMsg, succsses: false);
      return null;
      // if (id != null) {
      //   result = await updateAsseDet(id, scaleLavelId);
      // } else {
      //   result = false;
      // }
    }
    /*else {
      result = true;
    }*/
    resultAssesment = await RestServices.updateAssesmentCompetence(
      id: selectedPersonAssessment
          .competenses[personAssessmentFormIndex].assessmentCompetenceId,
      requireted: selectedPersonAssessment
          .competenses[personAssessmentFormIndex].requiredToTrain,
    );
    resultAssesment = await RestServices.updateAssessmentComment(
      id: selectedPersonAssessment
          .competenses[personAssessmentFormIndex].participants
          .firstWhere(
              (Participant element) => element.personGroupId == currentPgId)
          .entityId,
      comment: selectedPersonAssessment
              .competenses[personAssessmentFormIndex].participants
              .firstWhere(
                (Participant element) => element.personGroupId == currentPgId,
                orElse: () => null,
              )
              ?.comments ??
          '',
    );

    // if (participant != null) {
    //   // id = participant.entityId;
    //   // scaleLavelId = participant.scaleLevelId;
    //   resultAssesment = await RestServices.updateAssesmentCompetence(
    //     id: selectedPersonAssessment.competenses[personAssessmentFormIndex].assessmentCompetenceId,
    //     requireted: selectedPersonAssessment.competenses[personAssessmentFormIndex].requiredToTrain ?? false,
    //   );
    // } else {
    //   resultAssesment = true;
    // }

    if (selectedPersonAssessment.competenses.length - 1 ==
        personAssessmentFormIndex) {
      for (final PersonAssessmentForm competense
          in selectedPersonAssessment.competenses) {
        for (final PersonAssessmentForm indicator in competense.indicators) {
          final Participant el = indicator.participants.firstWhere(
              (Participant element) => element.personGroupId == currentPgId,
              orElse: () => null);
          if (el != null) {
            await RestServices.updateAssesmentDetailStatus(
              statusId: '7fdd44be-f20f-7cb1-dd30-19c058883f01',
              id: el.participantId,
            );
          }
        }
      }
      await personAssessment(update: true);
    }

    setBusy();
    return /*result && */ resultAssesment;
  }

  Future<bool> updateParticipant(
      String id, String scaleLavelId, String assessmentId) async {
    setBusy(true);
    bool resultAssesment;
    resultAssesment = await updateAsseDet(id, scaleLavelId);
    if (resultAssesment) {
      await RestServices.updateAssessment(assessmentId);
      await personAssessment(update: true);
    }
    setBusy();
    return resultAssesment;
  }

  Future<bool> updateAsseDet(String id, String scaleLavelId) async {
    return await RestServices.updateAssesmentDetail(
        scaleLavelId: scaleLavelId, id: id);
  }
}
