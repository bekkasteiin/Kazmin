import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person_assessment_form.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';

import 'package:kzm/viewmodels/competencies_model.dart';
import 'package:provider/provider.dart';

class CompetenciesFormView extends StatefulWidget {
  const CompetenciesFormView({Key key}) : super(key: key);

  @override
  State<CompetenciesFormView> createState() => _CompetenciesFormViewState();
}

class _CompetenciesFormViewState extends State<CompetenciesFormView> {
  int step;

  // PersonAssessmentForm personAssessmentForm;
  // PersonAssessmentForm personAssessmentForm;
  // TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    step = 1;
    // Provider.of<CompetenciesModel>(context, listen: false)
    //     .selectedPersonAssessment
    //     .personAssessmentForms[Provider.of<CompetenciesModel>(context, listen: false).personAssessmentFormIndex]
    //     .participants
    //     .firstWhere((Participant element) => element.personGroupId == '', orElse: () => Participant())
    //     .comments = controller.text.trim().isEmpty ? null : controller.text;
    // if (mounted) {
    //   final CompetenciesModel model = Provider.of<CompetenciesModel>(context, listen: false);
    //   String comment;
    //   for (final Participant el in model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants) {
    //     if (el.personGroupId == model.currentPgId) {
    //       comment = el.comments;
    //       return;
    //     }
    //   }
    //   // final String comment = model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
    //   //     .firstWhere(
    //   //       (Participant element) => element.personGroupId == model.currentPgId,
    //   //       orElse: () => Participant(),
    //   //     )
    //   //     .comments;
    //   if (comment != null && comment.isNotEmpty && model.personAssessmentFormIndex == 0) {
    //     setState(() {
    //       controller.text = comment;
    //     });
    //   }
    //   // else {
    //   //   controller.text = 'нет коммент';
    //   // }
    // }

    // personAssessmentForm =
    //     PersonAssessmentForm().copyWith(Provider.of<CompetenciesModel>(context, listen: false).selectedPersonAssessment.personAssessmentForms.first);
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final CompetenciesModel model = Provider.of<CompetenciesModel>(context, listen: false);
    return Scaffold(
      appBar: KzmAppBar(
        leading: step == 1 ? null : const SizedBox(),
        context: context,
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: <Widget>[
          if (step == 1) firstStep(model),
          if (step == 2) secondtStep(model),
          if (step != 1 && step != 2) lastStep(model),
        ],
      ),
    );
  }

  Widget firstStep(CompetenciesModel model) {
    return contentShadow(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.w),
          child: FieldBones(
            placeholder: S.current.assessmentSession,
            textValue: model.selectedPersonAssessment.sessionName,
          ),
        ),
        // FieldBones(
        //   placeholder: 'Position',
        //   textValue: model.selectedPersonAssessment.personAssessmentForms.first.result.toString(),
        // ),
        FieldBones(
          placeholder: S.current.employee,
          textValue: model.selectedPersonAssessment.employeeFullName,
        ),
        // FieldBones(
        //   placeholder: 'Оценочная сессия',
        //   textValue: model.selectedPersonAssessment.sessionName,
        // ),
        FieldBones(
          placeholder: S.current.dateFrom,
          textValue: formatShortly(model.selectedPersonAssessment.dateFrom),
        ),
        FieldBones(
          placeholder: S.current.dateTo,
          textValue: formatShortly(model.selectedPersonAssessment.dateTo),
        ),
        // FieldBones(
        //   placeholder: 'placeholder',
        //   textValue: model.selectedPersonAssessment.employeeFullName,
        // ),
        Container(
          padding: EdgeInsets.only(top: 16.w),
          width: double.infinity,
          child: KzmButton(
            child: Text(
              !(model.selectedPersonAssessment.statusCode != 'CLOSED' && model.selectedPersonAssessment.participantStatusCode != 'SEND')
                  ? S.current.viewCompetanceForm
                  : S.current.fillCompetanceForm,
            ),
            onPressed: () => next(model),
          ),
        )
      ],
    );
  }

  Widget secondtStep(CompetenciesModel model) {
    return contentShadow(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.w),
          child: FieldBones(
            placeholder: S.current.fillingInstructions,
            maxLinesSubTitle: 6,
            textValue: model.selectedPersonAssessment.instruction,
          ),
        ),
        if (!isDisable(model) && model.selectedPersonAssessment.dateTo.isBefore(DateTime.now()))
          Container(
            margin: EdgeInsets.only(top: 16.w),
            color: Colors.redAccent.withOpacity(0.5),
            padding: EdgeInsets.all(16.w),
            child: Text(
              S.current.periodExpiredMsg,
              style: Styles.mainTS,
            ),
          ),
        Container(
          padding: EdgeInsets.only(top: 16.w),
          width: double.infinity,
          child: KzmButton(
            disabled: !isDisable(model) && model.selectedPersonAssessment.dateTo.isBefore(DateTime.now()),
            onPressed: () => next(model),
            child: Text(!isDisable(model) ? S.current.startCompetence : S.current.viewCompetance),
          ),
        ),
        SizedBox(
          // padding: EdgeInsets.only(top: 16.w),
          width: double.infinity,
          child: KzmButton(
            outlined: true,
            onPressed: () => prev(model),
            child: Text(
              S.current.cancel,
              style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
            ),
          ),
        )
      ],
    );
  }

  Widget lastStep(CompetenciesModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(4.w),
          ),
          margin: EdgeInsets.only(top: 16.w, left: 16.w),
          child: Text(
            '${model.personAssessmentFormIndex + 1} из ${model.selectedPersonAssessment.competenses.length}',
            style: Styles.mainTS,
          ),
        ),
        contentShadow(
          children: <Widget>[
            FieldBones(
              placeholder: S.current.category,
              textValue: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].competenceType ?? '',
            ),
            FieldBones(
              placeholder: S.current.competence,
              textValue: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].competenceName ?? '',
            ),
            FieldBones(
              placeholder: S.current.totalPercent,
              textValue: '${model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].resultPercent ?? 0}%',
            ),
            FieldBones(
              placeholder: S.current.resultCompetence,
              textValue: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].result ?? '',
            ),
            FieldBones(
              placeholder: S.current.requiredLevel,
              textValue: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].requiredScaleLevel ?? '',
            ),
            ...model.selectedPersonAssessment.competenses.map((PersonAssessmentForm e) {
              if (e.assessmentCompetenceId == model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].assessmentCompetenceId) {
                return FieldBones(
                  placeholder: S.current.comment,
                  maxLinesSubTitle: 6,
                  isTextField: true,
                  editable: !isDisable(model),
                  keyboardType: TextInputType.multiline,
                  onChanged: (String val) {
                    e.participants.firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => Participant()).comments = val;
                  },
                  textValue: e.participants
                          .firstWhere(
                            (Participant element) => element.personGroupId == model.currentPgId,
                            orElse: () => null,
                          )
                          .comments ??
                      '',
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
            // FieldBones(
            //   placeholder: S.current.comment,
            //   maxLinesSubTitle: 6,
            //   isTextField: true,
            //   editable: !isDisable(model),
            //   keyboardType: TextInputType.multiline,
            //   onChanged: (String val) {
            //     model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
            //         .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => Participant())
            //         .comments = val;
            //   },
            //   textValue: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
            //           .firstWhere(
            //             (Participant element) => element.personGroupId == model.currentPgId,
            //             orElse: () => null,
            //           )
            //           .comments ??
            //       '',
            // ),
            KzmCheckboxListTile(
              title: Text(
                S.current.requiresDevelopment,
                style: Styles.mainTS,
              ),
              onChanged: !isDisable(model)
                  ? (bool val) {
                      setState(() {
                        model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].requiredToTrain = val;
                      });
                    }
                  : null,
              value: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].requiredToTrain,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                border: Border.all(color: Styles.appBorderColor),
              ),
              child: KzmExpansionTile(
                crossAxisAlignment: CrossAxisAlignment.start,
                initiallyExpanded: true,
                title: S.current.competences,
                children: <Widget>[
                  // ...model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
                  //     .where((Participant element) => element.personGroupId == model.currentPgId)
                  //     .map(
                  //       (Participant e) => FieldBones(
                  //         isRequired: true,
                  //         placeholder: model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].competenceName,
                  //         textValue: e.scaleLevel,
                  //         icon: model.currentPgId != e.personGroupId || isDisable(model) ? null : Icons.arrow_drop_down_sharp,
                  //         selector: model.currentPgId != e.personGroupId || isDisable(model)
                  //             ? null
                  //             : () => showSelector(
                  //                   model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].scaleLevels,
                  //                   model,
                  //                 ),
                  //       ),
                  //     )
                  //     .toList(),
                  ...model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].indicators.map((PersonAssessmentForm indicator) {
                    return Column(
                      children:
                          indicator.participants.where((Participant participant) => participant.personGroupId == model.currentPgId).map((Participant part) {
                        return FieldBones(
                          isRequired: true,
                          placeholder: indicator.competenceName,
                          textValue: part.scaleLevel,
                          icon: model.currentPgId != part.personGroupId || isDisable(model) ? null : Icons.arrow_drop_down_sharp,
                          selector: model.currentPgId != part.personGroupId || isDisable(model)
                              ? null
                              : () => showSelector(
                                    part,
                                    model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].scaleLevels,
                                    model,
                                  ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.w),
              width: double.infinity,
              child: KzmButton(
                child: Text(
                  model.personAssessmentFormIndex != model.selectedPersonAssessment.competenses.length - 1
                      ? S.current.nextCompetence
                      : !(model.selectedPersonAssessment.statusCode != 'CLOSED' && model.selectedPersonAssessment.participantStatusCode != 'SEND')
                          ? S.current.close
                          : S.current.completedComptence,
                ),
                onPressed: () => next(model),
              ),
            ),
            SizedBox(
              // padding: EdgeInsets.only(top: 16.w),
              width: double.infinity,
              child: KzmButton(
                outlined: true,
                onPressed: () => prev(model),
                child: Text(
                  model.personAssessmentFormIndex == 0 ? S.current.cancel : S.current.previous,
                  style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> next(CompetenciesModel model) async {
    if (step == 2) {
      if (!isDisable(model)) {
        for (final PersonAssessmentForm element in model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].indicators) {
          element.participants.firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null).scaleLevelId = null;
          element.participants.firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null).scaleLevel = null;
        }
        // model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
        //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null)
        //     .scaleLevelId = null;
        // model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
        //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null)
        //     .scaleLevel = null;
      }
    }
    if (step < 3) {
      step++;
      setState(() {});
    } else {
      if (model.selectedPersonAssessment.competenses.length > 1 && model.personAssessmentFormIndex != model.selectedPersonAssessment.competenses.length - 1) {
        if (model.personAssessmentFormIndex != model.selectedPersonAssessment.competenses.length - 1) {
          final bool response = await model.updatePersonAssessmentForm();
          if (response != null && response) {
            model.personAssessmentFormIndex++;
            model.setBusy();
            // controller = TextEditingController();
            // final Participant participant = model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
            //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => Participant());
            // controller.text = participant?.comments ?? '';
            setState(() {});
            // model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
            //     .firstWhere((Participant element) => element.personGroupId == '', orElse: () => Participant())
            //     .comments = controller.text.trim().isEmpty ? null : controller.text;
            if (!isDisable(model)) {
              for (final PersonAssessmentForm element in model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].indicators) {
                element.participants.firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null).scaleLevelId = null;
                element.participants.firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null).scaleLevel = null;
              }
              // model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
              //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null)
              //     .scaleLevelId = null;
              // model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
              //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => null)
              //     .scaleLevel = null;
            }
          } else if (response != null && !response) {
            step--;
            model.showSnacbar(S.current.unknownError, succsses: false);
          }
        }
        setState(() {});
      } else {
        if (model.selectedPersonAssessment.statusCode == 'CLOSED' || model.selectedPersonAssessment.participantStatusCode == 'SEND') {
          Get.back();
        } else {
          final bool response = await model.updatePersonAssessmentForm();
          if (response != null && response) {
            Get.back();
            model.showSnacbar(S.current.competencyAssessmentCompleted);
          } else if (response != null && !response) {
            model.showSnacbar(S.current.unknownError, succsses: false);
          }
        }
      }
    }
  }

  void prev(CompetenciesModel model) {
    if (step > 1) {
      if (model.personAssessmentFormIndex != 0) {
        model.personAssessmentFormIndex--;
      } else {
        step--;
      }
      if (step != 1 && step != 2) {
        // controller = TextEditingController();
        // final Participant participant = model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
        //     .firstWhere((Participant element) => element.personGroupId == model.currentPgId, orElse: () => Participant());
        // controller.text = participant.comments ?? '';
      }
      setState(() {});
    }
  }

  bool isDisable(CompetenciesModel model) {
    return !(model.selectedPersonAssessment.statusCode != 'CLOSED' && model.selectedPersonAssessment.participantStatusCode != 'SEND');
  }

  void showSelector(Participant part, List<ScaleLevel> list, CompetenciesModel model) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S.current.select,
                    style: Styles.mainTS.copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.clear,
                      color: Styles.appDarkGrayColor,
                    ),
                  )
                ],
              ),
            ),
            ...list.map((ScaleLevel e) {
              // final String id = model.selectedPersonAssessment.competenses[model.personAssessmentFormIndex].participants
              //     .firstWhere(
              //       (Participant element) => element.personGroupId == model.currentPgId,
              //       orElse: () => null,
              //     )
              //     .scaleLevelId;
              return InkWell(
                onTap: () async {
                  if (await model.updateParticipant(part.entityId, e.scaleLevelId, part.assessmentId)) {
                    part.scaleLevelId = e.scaleLevelId;
                    part.scaleLevel = e.lang1;
                    Get.back();
                  }
                },
                child: Container(
                  color:
                      // e.scaleLevelId == id ? Styles.appBrightBlueColor :
                      null,
                  padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        e.lang1,
                        style: Styles.mainTS,
                      ),
                      Icon(
                        // e.scaleLevelId == id ? Icons.check_circle_outline :
                        Icons.circle_outlined,
                        color: Styles.appDarkBlueColor,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
            const SafeArea(
              child: SizedBox(),
            )
          ],
        );
      },
    ).then((value) => setState(() {}));
  }
}
