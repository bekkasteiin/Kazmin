import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/password_field.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/assets.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class LoginSavePassword extends StatelessWidget {
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
                Row(
                  children: [
                    Text(S.current.yourLogin, style: Styles.mainTS),
                    Text(userModel.resetPasswordLogin ?? '', style: Styles.mainTS.copyWith(color: Styles.appActiveFocusBorderColor, fontWeight: FontWeight.w700)),
                  ],
                ),
                Text(S.current.signUpPassword, style: Styles.mainTS),
                SizedBox(height: Styles.appFormSpacerHalfHeight),
                KzmPasswordInput(
                  hintText: S.current.signUpPasswordText,
                  onChanged: (String val) => userModel.passwordText = val,
                ),
                SizedBox(height: Styles.appFormSpacerHalfHeight),
                KzmPasswordInput(
                  hintText: S.current.signUpRepeatPasswordText,
                  onChanged: (String val) => userModel.repeatPasswordText = val,
                ),
                SizedBox(height: Styles.appFormSpacerFullHeight),
                KzmOutlinedBlueButton(
                  caption: S.current.next,
                  enabled: userModel.isPasswordButtonActive,
                  onPressed: () async {
                    if (!userModel.isRecoverScenario) {
                      userModel.registerInfo.login = await userModel.createUser();
                      if (userModel.registerInfo.login.isNotEmpty) {
                        Get.offNamedUntil(KzmPages.passwordSaved, ModalRoute.withName(KzmPages.login));
                      }
                    } else {
                      if (await userModel.updatePassword()) {
                        await KzmSnackbar(message: S.current.signUpSavePasswordOk, autoHide: true).show();
                        Get.offNamed(KzmPages.login);
                      }
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
