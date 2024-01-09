import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/text_button.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/assets.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/login/login_iin_phone.dart';

class LoginIINPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = context.watch<UserViewModel>();
    return KzmScreen(
      isInitPage: true,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: Styles.appFormPaddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(KzmAssets.logo, width: Styles.appFormLogoWidth),
              SizedBox(height: Styles.appFormSpacerFullHeight),
              if (userModel.isRecoverScenario) Text(S.current.recoverPasswordScreenText, style: Styles.mainTS, textAlign: TextAlign.justify,),
              if (userModel.isRecoverScenario) SizedBox(height: Styles.appFormSpacerHalfHeight),
              KzmTextInput(
                keyboardType: TextInputType.number,
                prefixIcon: KzmIcons.person,
                caption: S.current.iin,
                initValue: '',
                inputFormatters: <TextInputFormatter>[Styles.iin],
                maxLines: 1,
                onChanged: (KzmAnswerData val) => userModel.iinText = val.value,
              ),
              SizedBox(height: Styles.appFormSpacerHalfHeight),
              KzmTextInput(
                keyboardType: TextInputType.number,
                prefixIcon: KzmIcons.phone,
                caption: S.current.phone,
                initValue: '',
                inputFormatters: <TextInputFormatter>[Styles.phone],
                maxLines: 1,
                onChanged: (KzmAnswerData val) {
                  userModel.phoneText = val.value;
                },
              ),
              SizedBox(height: Styles.appFormSpacerFullHeight),
              KzmOutlinedBlueButton(
                caption: S.current.next,
                enabled: userModel.isNextButtonActive,
                onPressed: () async {
                  final bool apiResult =
                  userModel.isRecoverScenario
                      ? await userModel.recoverPassword()
                      : await userModel.signUpUser();
                  if (apiResult) {
                    userModel.verifyText = '';
                    userModel.timerController.endTime =
                        DateTime.now().millisecondsSinceEpoch + 1000 * (await userModel.getSMSTimeout());
                    Get.toNamed(KzmPages.codeVerify);
                  }
                },
              ),
              if (userModel.isRecoverScenario)
                KzmTextButton(
                  caption: S.current.toStartPage,
                  // onPressed: () => Get.toNamed(KzmPages.login),
                  onPressed: () => Get.offAllNamed(KzmPages.login),
                )
              else
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text(S.current.alreadyRegistered, style: Styles.mainTS),
                    KzmTextButton(
                      caption: S.current.enter,
                      // onPressed: () => Get.toNamed(KzmPages.login),
                      onPressed: () => Get.offAllNamed(KzmPages.login),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
