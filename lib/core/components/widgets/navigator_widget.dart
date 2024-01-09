import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:m_toast/m_toast.dart';

class GlobalNavigator {
  ShowMToast toast = ShowMToast();

  static pop() {
    navigatorKey.currentState.pop();
  }

  static showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext,
      builder: (BuildContext context) {
        return const LoaderWidget(
          isPop: true,
        );
      },
    );
  }

  static defultShowDialog({@required String middleText}){
    showCupertinoDialog(
      context: navigatorKey.currentContext,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(S.current.attention),
          content: Text(middleText),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                GlobalNavigator.pop();
              },
              child: Text(S.current.ok),
            ),
          ],
        );
      },
    );
  }

  static successSnackbar() {
    ScaffoldMessenger.of(navigatorKey.currentContext).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFF3BB55D),
        content: Text(
          S.current.saveRequestSuccess,
        ),
      ),
    );
  }

  static doneSnackbar(String title) {
    ScaffoldMessenger.of(navigatorKey.currentContext).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFF3BB55D),
        content: Text(
            title
        ),
      ),
    );
  }

  static errorSnackbar(String title) {
    ScaffoldMessenger.of(navigatorKey.currentContext).showSnackBar(
      SnackBar(
        backgroundColor: Styles.appRedColor,
        content: Text(
          title,
        ),
      ),
    );
  }

  errorBar({@required String title}) {
    toast.errorToast(
      navigatorKey.currentContext,
      message: title,
      backgroundColor: Colors.white,
      alignment: Alignment.topCenter,
      duration: 2000,
    );
  }

  errorClickBar() {
    toast.errorToast(
      navigatorKey.currentContext,
      message: S.current.checkClick,
      backgroundColor: Colors.white,
      alignment: Alignment.topCenter,
      duration: 1500,
    );
  }

  errorClickRecommendBar() {
    toast.errorToast(
      navigatorKey.currentContext,
      message: S.current.checkClickRecommend,
      backgroundColor: Colors.white,
      alignment: Alignment.topCenter,
      duration: 1500,
    );
  }

  fillAllBar(){
    toast.errorToast(
      navigatorKey.currentContext,
      message: S.current.fillRequiredFields,
      backgroundColor: Colors.white,
      alignment: Alignment.topCenter,
      duration: 1500,
    );
  }

  static showAlertDialog(String text) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
