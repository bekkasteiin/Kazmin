import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';

Future<void> showMyDialog({@required BuildContext context, Widget title, Widget content, List<Widget> actions, String buttonText, @required Function thenFunction}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title ?? const SizedBox(),
        content: SingleChildScrollView(
          child: content ?? const SizedBox(),
        ),
        actions: actions ??
            <Widget>[
              KzmButton(
                  outlined: true,
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    S.current.cancel,
                    style: Styles.mainTxtTheme.button.copyWith(color: Styles.appGrayButtonColor),
                  ),),
              KzmButton(
                child: Text(
                  buttonText ?? S.current.logout,
                  style: Styles.mainTxtTheme.button.copyWith(color: Styles.appWhiteColor),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
        elevation: 24,
      );
    },
  ).then((exit) async {
    if (exit == null || !(exit as bool)) return;
    if (exit as bool) thenFunction();
  });
}
