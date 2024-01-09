import 'package:flutter/cupertino.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmHintText extends Text {
  final String hint;
  final bool isExpanded;

  const KzmHintText({@required this.hint, this.isExpanded = true}) : super(hint);

  @override
  Widget build(BuildContext context) {
    final Text _widget = Text(
      hint,
      style: Styles.textFieldHintTS,
      overflow: TextOverflow.ellipsis,
    );

    return isExpanded
        ? Expanded(
            child: _widget,
          )
        : _widget;
  }
}
