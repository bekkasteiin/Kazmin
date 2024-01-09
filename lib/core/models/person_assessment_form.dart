// To parse this JSON data, do
//
//     final personAssessmentForm = personAssessmentFormFromMap(jsonString);

import 'dart:convert';

class PersonAssessmentFormResponse {
  PersonAssessmentFormResponse({
    this.type,
    this.value,
  });

  String type;
  List<PersonAssessmentForm> value;

  factory PersonAssessmentFormResponse.fromJson(String str) {
    return PersonAssessmentFormResponse.fromMap(json.decode(str));
  }

  // String toJson() => json.encode(toMap());

  factory PersonAssessmentFormResponse.fromMap(Map<String, dynamic> json) {
    List<PersonAssessmentForm> result;
    if (json['value'] != null) {
      result = <PersonAssessmentForm>[];
      final jsong = json['value'].replaceAll('\\', '').replaceAll('"{"scale_levels" : [', '[').replaceAll('"{"participants" : [', '[').replaceAll('}]}"', '}]');
      final list = jsonDecode(jsonDecode(jsonEncode(jsong)));
      list.forEach((v) {
        result.add(PersonAssessmentForm.fromMap(v as Map<String, dynamic>));
      });
    }
    return PersonAssessmentFormResponse(
      type: json['type'] as String,
      value: result,
    );
  }

// Map<String, dynamic> toMap() => {
//       "type": type,
//       "value": List<dynamic>.from(value.map((PersonAssessmentForm x) => x.toMap())),
//     };
}

class PersonAssessmentForm {
  PersonAssessmentForm({
    this.personAssessmentId,
    this.assessmentCompetenceId,
    this.competenceSource,
    this.competenceTypeId,
    this.competenceType,
    this.competenceGroupId,
    this.competenceName,
    this.requiredScaleLevelId,
    this.requiredScaleLevel,
    this.scaleLevels,
    this.entityName,
    this.resultPercent,
    this.resultId,
    this.result,
    this.requiredToTrain,
    this.delta,
    this.hasComments,
    this.participants,
    this.indicators,
  });

  String personAssessmentId;
  String assessmentCompetenceId;
  String competenceSource;
  String competenceTypeId;
  String competenceType;
  String competenceGroupId;
  String competenceName;
  String requiredScaleLevelId;
  String requiredScaleLevel;
  List<ScaleLevel> scaleLevels;
  String entityName;
  double resultPercent;
  String resultId;
  String result;
  bool requiredToTrain;
  int delta;
  bool hasComments;
  List<PersonAssessmentForm> indicators;
  List<Participant> participants;

  factory PersonAssessmentForm.fromJson(String str) => PersonAssessmentForm.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  PersonAssessmentForm copyWith(PersonAssessmentForm personAssessmentForm) {
    return PersonAssessmentForm(
      entityName: personAssessmentForm.entityName,
      personAssessmentId: personAssessmentForm.personAssessmentId,
      competenceSource: personAssessmentForm.competenceSource,
      competenceTypeId: personAssessmentForm.competenceTypeId,
      competenceType: personAssessmentForm.competenceType,
      competenceGroupId: personAssessmentForm.competenceGroupId,
      competenceName: personAssessmentForm.competenceName,
      requiredScaleLevelId: personAssessmentForm.requiredScaleLevelId,
      requiredScaleLevel: personAssessmentForm.requiredScaleLevel,
      scaleLevels: personAssessmentForm.scaleLevels,
      resultPercent: personAssessmentForm.resultPercent,
      resultId: personAssessmentForm.resultId,
      result: personAssessmentForm.result,
      requiredToTrain: personAssessmentForm.requiredToTrain,
      assessmentCompetenceId: personAssessmentForm.assessmentCompetenceId,
      delta: personAssessmentForm.delta,
      hasComments: personAssessmentForm.hasComments,
      participants: personAssessmentForm.participants,
    );
  }

  PersonAssessmentForm copyWithN(PersonAssessmentForm personAssessmentForm) {
    return PersonAssessmentForm(
      entityName: personAssessmentForm.entityName ?? entityName,
      personAssessmentId: personAssessmentForm.personAssessmentId ?? personAssessmentId,
      competenceSource: personAssessmentForm.competenceSource ?? competenceSource,
      competenceTypeId: personAssessmentForm.competenceTypeId ?? competenceTypeId,
      competenceType: personAssessmentForm.competenceType ?? competenceType,
      competenceGroupId: personAssessmentForm.competenceGroupId ?? competenceGroupId,
      competenceName: personAssessmentForm.competenceName ?? competenceName,
      requiredScaleLevelId: personAssessmentForm.requiredScaleLevelId ?? requiredScaleLevelId,
      requiredScaleLevel: personAssessmentForm.requiredScaleLevel ?? requiredScaleLevel,
      scaleLevels: personAssessmentForm.scaleLevels ?? scaleLevels,
      resultPercent: personAssessmentForm.resultPercent ?? resultPercent,
      resultId: personAssessmentForm.resultId ?? resultId,
      result: personAssessmentForm.result ?? result,
      requiredToTrain: personAssessmentForm.requiredToTrain ?? requiredToTrain,
      assessmentCompetenceId: personAssessmentForm.assessmentCompetenceId ?? assessmentCompetenceId,
      delta: personAssessmentForm.delta ?? delta,
      hasComments: personAssessmentForm.hasComments ?? hasComments,
      participants: personAssessmentForm.participants ?? participants,
    );
  }

  factory PersonAssessmentForm.fromMap(Map<String, dynamic> json) => PersonAssessmentForm(
        personAssessmentId: json['person_assessment_id'] as String,
        assessmentCompetenceId: json['assessment_competence_id'] as String,
        competenceSource: json['competence_source'] as String,
        competenceTypeId: json['competence_type_id'] as String,
        competenceType: json['competence_type'] as String,
        competenceGroupId: json['competence_group_id'] as String,
        competenceName: json['competence_name'] as String,
        requiredScaleLevelId: json['required_scale_level_id'] as String,
        requiredScaleLevel: json['required_scale_level'] as String,
        scaleLevels: json['scale_levels'] == null
            ? null
            : List<ScaleLevel>.from((json['scale_levels'] as List).map((x) => ScaleLevel.fromMap(x as Map<String, dynamic>))),
        entityName: json['entityName'] as String,
        resultPercent: json['result_percent'] == null ? null : json['result_percent'].toDouble() as double,
        resultId: json['result_id'] as String,
        result: json['result'] as String,
        requiredToTrain: json['required_to_train'] as bool ?? false,
        delta: json['delta'] as int,
        hasComments: json['has_comments'] as bool,
        participants: json['participants'] == null
            ? []
            : List<Participant>.from((json['participants'] as List).map((x) => Participant.fromMap(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toMap() => {
        'person_assessment_id': personAssessmentId,
        'assessment_competence_id': assessmentCompetenceId,
        'competence_source': competenceSource,
        'competence_type_id': competenceTypeId,
        'competence_type': competenceType,
        'competence_group_id': competenceGroupId,
        'competence_name': competenceName,
        'required_scale_level_id': requiredScaleLevelId,
        'required_scale_level': requiredScaleLevel,
        'scale_levels': List<dynamic>.from(scaleLevels.map((ScaleLevel x) => x.toMap())),
        'entityName': entityName,
        'result_percent': resultPercent,
        'result_id': resultId,
        'result': result,
        'required_to_train': requiredToTrain,
        'delta': delta,
        'has_comments': hasComments,
        'participants': List<dynamic>.from(participants.map((Participant x) => x.toMap())),
      };
}

class Participant {
  Participant({
    this.entityId,
    this.entityName,
    this.personGroupId,
    this.employeeName,
    this.participantRoleCode,
    this.participantOrder,
    this.scaleLevelId,
    this.scaleLevel,
    this.comments,
    this.requiredToTrain,
    this.scaleLevels,
    this.hasComments,
    this.roleName,
    this.participantId,
    this.assessmentId,
  });

  String entityId;
  String entityName;
  String personGroupId;
  String employeeName;
  String participantRoleCode;
  int participantOrder;
  String scaleLevelId;
  String scaleLevel;
  String comments;
  bool requiredToTrain;
  List<ScaleLevel> scaleLevels;
  bool hasComments;
  String roleName;
  String participantId;
  String assessmentId;

  factory Participant.fromJson(String str) => Participant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Participant.fromMap(Map<String, dynamic> json) => Participant(
        roleName: json['role_name'],
        entityId: json['entity_id'],
        assessmentId: json['assessment_id'],
        participantId: json['participant_id'],
        entityName: json['entity_name'],
        personGroupId: json['person_group_id'],
        employeeName: json['employee_name'],
        participantRoleCode: json['participant_role_code'],
        participantOrder: json['participant_order'],
        scaleLevelId: json['scale_level_id'],
        scaleLevel: json['scale_level'],
        comments: json['comments'],
        requiredToTrain: json['required_to_train'] ?? false,
        scaleLevels: json['scale_levels'] == null ? null : List<ScaleLevel>.from(json['scale_levels'].map((x) => ScaleLevel.fromMap(x))),
        hasComments: json['has_comments'],
      );

  Map<String, dynamic> toMap() => {
        'entity_id': entityId,
        'entity_name': entityName,
        'person_group_id': personGroupId,
        'employee_name': employeeName,
        'participant_role_code': participantRoleCode,
        'participant_order': participantOrder,
        'scale_level_id': scaleLevelId,
        'scale_level': scaleLevel,
        'comments': comments,
        'required_to_train': requiredToTrain,
        'scale_levels': List<dynamic>.from(scaleLevels.map((ScaleLevel x) => x.toMap())),
        'has_comments': hasComments,
      };
}

class ScaleLevel {
  ScaleLevel({
    this.scaleLevelId,
    this.lang1,
    this.lang2,
    this.lang3,
    this.levelScore,
  });

  String scaleLevelId;
  String lang1;
  String lang2;
  String lang3;
  int levelScore;

  factory ScaleLevel.fromJson(String str) => ScaleLevel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScaleLevel.fromMap(Map<String, dynamic> json) => ScaleLevel(
        scaleLevelId: json['scale_level_id'],
        lang1: json['lang1'],
        lang2: json['lang2'],
        lang3: json['lang3'],
        levelScore: json['level_score'],
      );

  Map<String, dynamic> toMap() => {
        'scale_level_id': scaleLevelId,
        'lang1': lang1,
        'lang2': lang2,
        'lang3': lang3,
        'level_score': levelScore,
      };
}
