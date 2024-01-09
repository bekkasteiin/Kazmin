import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/yellow_button.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/question.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/daily_questions/kzm_question_tile.dart';
import 'package:kzm/viewmodels/kzm_daily_questions_model.dart';
import 'package:provider/provider.dart';

String fName = 'lib/pageviews/daily_questions/kzm_daily_questions.dart';

class KzmDailyQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<KzmDailyQuestionsModel>(
      initialData: null,
      create: (BuildContext context) => KzmDailyQuestionsModel().init(),
      child: Consumer<KzmDailyQuestionsModel>(
        builder: (BuildContext context, KzmDailyQuestionsModel qm, Widget child) => KzmScreen(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: Padding(
            padding: paddingHorizontal(
              top: Styles.appDoubleMargin,
              bottom: Styles.appButtonHeight + Styles.appQuadMargin,
            ),
            child: qm == null
                ? const LoaderWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...qm.questions.map(
                        (KzmQuestion val) => KzmQuestionTile(
                          questionData: val,
                          onChanged: (KzmAnswerData v) {
                            if (val.type == KzmQuestionTypes.many) {
                              if (v.add) {
                                val.answer.add(v.value);
                              } else {
                                val.answer.remove(v.value);
                              }
                            } else {
                              if (val.answer.isNotEmpty) val.answer.clear();
                              if (v.add) val.answer.add(v.value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          bottomSheet: (qm != null && qm.questions.length > 0) ? KzmOutlinedYellowButton(
            enabled: true,
            caption: S.current.everydayQuestionsButton,
            onPressed: () {
              qm?.pushResults();
            },
          ) : SizedBox(),
        ),
      ),
      catchError: (BuildContext context, Object object) {
        log('-->> catchError, KzmDailyQuestions, KzmDailyQuestionsModel, context: \n$context, object: \n$object');
        return null;
      },
    );
  }
}
