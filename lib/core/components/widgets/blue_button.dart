
import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

const String fName = 'lib/core/components/widgets/blue_button.dart';

class KzmOutlinedBlueButton extends StatelessWidget {
  final String caption;
  final bool enabled;
  final bool redStyle;
  final void Function() onPressed;

  const KzmOutlinedBlueButton({
    @required this.caption,
    @required this.enabled,
    this.redStyle = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: enabled
            ? (!redStyle)
                ? Styles.appCorporateColor
                : Styles.appRedColor
            : Styles.appDarkGrayColor,
        minimumSize: Size(double.infinity, Styles.appButtonHeight),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(caption, style: TextStyle(color: Styles.appWhiteColor)),
    );
  }
}
