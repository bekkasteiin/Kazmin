import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/assets.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class LoginCodeVerify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = context.watch<UserViewModel>();
    return KzmScreen(
      isInitPage: true,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: Padding(
            padding: Styles.appFormPaddingHorizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(KzmAssets.logo, width: Styles.appFormLogoWidth),
                SizedBox(height: Styles.appFormSpacerFullHeight),
                Text(
                  userModel.isRecoverScenario
                      ? S.current.signUpVerifyTelegramTextRecover
                      : S.current.signUpVerifyTelegramText,
                  style: Styles.mainTS,
                ),
                SizedBox(height: Styles.appFormSpacerHalfHeight),
                KzmTextInput(
                  keyboardType: TextInputType.number,
                  prefixIcon: KzmIcons.password,
                  caption: S.current.signUpVerifyEditHint,
                  initValue: '',
                  inputFormatters: <TextInputFormatter>[Styles.verify],
                  maxLines: 1,
                  onChanged: (KzmAnswerData val) => userModel.verifyText = val.value,
                ),
                SizedBox(height: Styles.appFormSpacerHalfHeight),
                SizedBox(
                  width: Styles.appFormWidth,
                  child: CountdownTimer(
                    controller: userModel.timerController,
                    widgetBuilder: (_, CurrentRemainingTime t) {
                      final String time =
                          '${(t == null ? 0 : t.min ?? 0).toString().padLeft(2, '0')}:${(t == null ? 0 : t.sec ?? 0).toString().padLeft(2, '0')}';
                      return Text(
                        '${S.current.signUpVerifyTimer} $time',
                        style: Styles.mainTS,
                      );
                    },
                  ),
                ),
                SizedBox(height: Styles.appFormSpacerFullHeight),
                KzmOutlinedBlueButton(
                  caption: S.current.next,
                  enabled: userModel.isVerifyButtonActive,
                  onPressed: () async {
                    if (await userModel.verifyCode()) {
                      userModel.timerController.disposeTimer();
                      Get.offNamed(KzmPages.savePassword);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
