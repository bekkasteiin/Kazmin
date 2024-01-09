import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/models/question.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/base_model.dart';

const String fName = 'lib/viewmodels/kzm_daily_questions_model.dart';

class KzmDailyQuestionsModel extends BaseModel {
  List<KzmQuestion> _questions;

  Future<KzmDailyQuestionsModel> init() async {
    _questions = await RestServices.getDailyQuestions();
    return this;
  }

  List<KzmQuestion> get questions => _questions;

  bool get isAllAnswered {
    for (final KzmQuestion question in questions) {
      if (question.answer.isEmpty) return false;
    }
    return true;
  }

  Future<void> pushResults() async {
    if (!isAllAnswered) {
      await KzmSnackbar(message: S.current.everydayQuestionsAlert).show();
      return;
    }
    setBusy(true);
    String templateId;
    final List<Map<String, dynamic>> tmp = <Map<String, dynamic>>[];
    for (final KzmQuestion val in questions) {
      templateId ??= val.templateId;
      tmp.add(<String, dynamic>{
        'questionId': val.id,
        'answer': <String>[...val.answer],
      });
    }
    final dynamic _res = await RestServices.pushDailyQuestionsAnswers(
      templateId: templateId,
      answers: tmp,
    );
    if ((_res ?? '').toString().isNotEmpty) {
      setBusy(false);
      await KzmSnackbar(message: S.current.everydayQuestionsPushError).show();
      return;
    }
    setBusy(false);
    await KzmSnackbar(message: S.current.everydayQuestionsSuccess).show();
    GlobalNavigator.pop();
  }
}
