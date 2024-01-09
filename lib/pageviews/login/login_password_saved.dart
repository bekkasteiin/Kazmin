import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/assets.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class LoginPasswordSaved extends StatelessWidget {
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
                  (userModel.isRecoverScenario) ? S.current.recoverPasswordSaved : S.current.signUpLoginGenerated,
                  style: Styles.mainTS,
                ),
                if (!userModel.isRecoverScenario) SizedBox(height: Styles.appFormSpacerHalfHeight),
                if (!userModel.isRecoverScenario)
                  KzmTextInput(
                    keyboardType: null,
                    prefixIcon: KzmIcons.person,
                    caption: null,
                    showCursor: false,
                    readOnly: true,
                    maxLines: 1,
                    initValue: userModel.registerInfo.login ?? '',
                  ),
                SizedBox(height: Styles.appFormSpacerFullHeight),
                KzmOutlinedBlueButton(
                  caption: S.current.toStartPage,
                  enabled: true,
                  onPressed: () {
                    Get.offNamed(KzmPages.login);
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
