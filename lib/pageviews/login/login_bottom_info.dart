import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class LoginBottomInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = context.watch<UserViewModel>();

    void goToNextPage({@required bool isRecoverScenario}) {
      userModel.iinText = '';
      userModel.phoneText = '';
      userModel.isRecoverScenario = isRecoverScenario;
      Get.toNamed(KzmPages.iinPhone);
    }

    return Column(
      children: <Widget>[
        Text(S.current.register, textAlign: TextAlign.center),
        TextButton(
          onPressed: () => goToNextPage(isRecoverScenario: false),
          child: Text(S.current.registerButton),
        ),
        // Text(S.current.installTelegram, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(S.current.forgotThePassword, textAlign: TextAlign.center),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () => goToNextPage(isRecoverScenario: true),
              child: Text(S.current.recoverThePassword),
            ),
          ],
        ),
      ],
    );
  }
}
