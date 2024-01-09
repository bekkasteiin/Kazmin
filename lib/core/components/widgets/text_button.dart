import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmTextButton extends StatelessWidget {
  final String caption;
  final void Function() onPressed;

  const KzmTextButton({@required this.caption, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Styles.appTextHeight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(caption, style: const TextStyle(color: Styles.appCorporateColor)),
      ),
    );
  }
}
