import 'package:flutter/cupertino.dart';
import 'package:kzm/core/models/common_item.dart';

enum KzmQuestionTypes { text, one, many, num }

class KzmQuestion {
  final KzmQuestionTypes type;
  final String text;
  final String id;
  final List<KzmCommonItem> variants;
  final String templateId;
  List<String> answer = <String>[];

  KzmQuestion({
    @required this.type,
    @required this.id,
    @required this.text,
    @required this.variants,
    @required this.templateId,
  });

  static KzmQuestionTypes mapKzmQuestionType({@required String type}) {
    switch (type) {
      case 'MANY':
        return KzmQuestionTypes.many;
      case 'NUM':
        return KzmQuestionTypes.num;
      case 'ONE':
        return KzmQuestionTypes.one;
      default:
        return KzmQuestionTypes.text;
    }
  }
}
