import 'package:flutter/cupertino.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmText extends StatelessWidget {
  final String text;
  final bool isExpanded;
  final int maxLines;
  final TextAlign textAlign;
  final Color textColor;

  const KzmText({
    @required this.text,
    this.isExpanded = true,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Text _widget = Text(
      text,
      style: (textColor == null) ? Styles.textFieldTS : Styles.textFieldTS.copyWith(color: textColor),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );

    return isExpanded
        ? Expanded(
            child: _widget,
          )
        : _widget;
  }
}
