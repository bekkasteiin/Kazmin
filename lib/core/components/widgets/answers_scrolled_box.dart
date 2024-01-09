import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmAnswersScrolledBox extends StatelessWidget {
  final Widget child;

  const KzmAnswersScrolledBox({@required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: Styles.appAnswersBoxMinHeight,
        maxHeight: Styles.appAnswersBoxMaxHeight,
      ),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
