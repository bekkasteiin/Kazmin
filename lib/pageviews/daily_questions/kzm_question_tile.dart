import 'package:flutter/cupertino.dart';
import 'package:kzm/core/components/widgets/checkbox_input.dart';
import 'package:kzm/core/components/widgets/radio_input.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/question.dart';
import 'package:kzm/generated/l10n.dart';

class KzmQuestionTile extends StatelessWidget {
  final KzmQuestion questionData;
  final Function(KzmAnswerData) onChanged;

  const KzmQuestionTile({@required this.questionData, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Styles.appQuadMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(questionData.text, style: Styles.questionText),
          SizedBox(height: Styles.appDoubleMargin),
          if (questionData.type == KzmQuestionTypes.text)
            KzmTextInput(
              keyboardType: TextInputType.text,
              prefixIcon: KzmIcons.question,
              caption: S.current.everydayQuestionsAnswer,
              initValue: '',
              maxLines: 1,
              onChanged: onChanged,
            )
          else if (questionData.type == KzmQuestionTypes.num)
            KzmTextInput(
              keyboardType: TextInputType.number,
              prefixIcon: KzmIcons.question,
              caption: S.current.everydayQuestionsAnswer,
              initValue: '',
              maxLines: 1,
              onChanged: onChanged,
            )
          else if (questionData.type == KzmQuestionTypes.one)
            KzmRadioInput(
              data: questionData.variants,
              onChanged: onChanged,
            )
          else if (questionData.type == KzmQuestionTypes.many)
            KzmCheckBoxInput(
              data: questionData.variants,
              onChanged: onChanged,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
