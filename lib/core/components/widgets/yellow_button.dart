import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmOutlinedYellowButton extends StatelessWidget {
  final String caption;
  final bool enabled;
  final void Function() onPressed;

  const KzmOutlinedYellowButton({@required this.caption, @required this.enabled, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: enabled ? Styles.appWhiteColor : Styles.appDarkGrayColor,
        minimumSize: Size(double.infinity, Styles.appButtonHeight),
        side: BorderSide(width: 2.w, color: Styles.appYellowButtonBorderColor),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(caption, style: TextStyle(color: Styles.appDarkBlackColor)),
    );
  }
}
