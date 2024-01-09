import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/password_field.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/assets.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/service/socket.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/login/login_bottom_info.dart';
import 'package:kzm/pageviews/settings/settings_pageview.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/login/login_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController text = TextEditingController();
  String userLogin;

  @override
  void initState() {
    super.initState();
    readLocalLogin();
  }

  Future<void> readLocalLogin() async {
    final UserViewModel model =
        navigatorKey.currentContext.read<UserViewModel>();
    if (model.auth) {
      final box = await HiveService.getBox('settings');
      final info = userInfoFromJson(box.get('info').toString());
      setState(() {
        model.login = info.login;
      });
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = context.watch<UserViewModel>();
    final AppSettingsModel appSettingsModel = context.read<AppSettingsModel>();
    final KZMSocket socket = context.read<KZMSocket>();
    final SettingsModel settingModel = context.read<SettingsModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: KzmScreen(
        isInitPage: true,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Padding(
              padding: Styles.appFormPaddingHorizontal,
              child: buildContent(
                  context, userModel, appSettingsModel, socket, settingModel),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(
      BuildContext context,
      UserViewModel userModel,
      AppSettingsModel appSettingsModel,
      KZMSocket socket,
      SettingsModel settingModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (appSettingsModel.counter == 2) {
              appSettingsModel.counter = 0;
              changeUrl(context, appSettingsModel, settingModel);
            } else {
              appSettingsModel.logoTap();
            }
          },
          child: Image.asset(KzmAssets.logo, width: Styles.appFormLogoWidth),
        ),
        SizedBox(height: Styles.appFormSpacerFullHeight),
        KzmTextInput(
          keyboardType: TextInputType.text,
          prefixIcon: KzmIcons.person,
          hintText: userModel.auth ? userModel.login : S.current.login,
          initValue: '',
          maxLines: 1,
          readOnly: userModel.auth,
          suffixIcon: userModel.auth
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => buildExitUserDialog(
                          context, userModel, appSettingsModel),
                    );
                  },
                  child: Icon(Icons.close_outlined),
                )
              : SizedBox(),
          onChanged: (KzmAnswerData val) => userModel.login = val.value,
        ),
        SizedBox(height: Styles.appFormSpacerHalfHeight),
        KzmPasswordInput(
          hintText: S.current.password,
          onChanged: (String val) => userModel.password = val,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => changeLang(context, appSettingsModel),
            icon: const Icon(Icons.language, color: Styles.appCorporateColor),
          ),
        ),
        Row(
          children: <Widget>[
            const SizedBox(),
            Flexible(
              child: KzmOutlinedBlueButton(
                caption: S.current.logIn,
                enabled: userModel.isLoginButtonActive,
                onPressed: () {
                  userModel.auth
                      ? userModel.loginSuccess(
                          socket: socket, context: context, fromPin: true)
                      : userModel.loginSuccess(
                          socket: socket, context: context);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: Styles.appFormSpacerFullHeight),
        LoginBottomInfo(),
        SizedBox(height: Styles.appFormSpacerFullHeight),
      ],
    );
  }

  Widget buildExitUserDialog(BuildContext context, UserViewModel userModel,
      AppSettingsModel appSettingsModel) {
    return CupertinoAlertDialog(
      title: Text(S.current.exitUser),
      content: Text(S.current.exitUserInfo),
      actions: [
        CupertinoDialogAction(
          child: Text(S.current.yes),
          onPressed: () => appSettingsModel.logout(
              userViewModel: userModel, context: context),
        ),
        CupertinoDialogAction(
          child: Text(S.current.no),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  void changeUrl(
    BuildContext context,
    AppSettingsModel appSettingsModel,
    SettingsModel settingModel,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <FieldBones>[
              FieldBones(
                placeholder: 'URL',
                isTextField: true,
                isMinWidthTiles: true,
                textValue: text.text,
                onChanged: (String val) => settingModel.url = val,
              ),
            ],
          ),
          actions: <CupertinoButton>[
            CupertinoButton(
              onPressed: () {
                settingModel.saveUrl();
              },
              child: Text(S.current.save),
            ),
          ],
        );
      },
    );
  }

  void changeLang(BuildContext context, AppSettingsModel appSettingsModel) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 300,
            child: CupertinoActionSheet(
              title: Text(S.current.language),
              message: Text(S.current.selectApplicationLanguage),
              cancelButton: CupertinoButton(
                onPressed: () => Get.back(),
                child: Text(S.current.cancel),
              ),
              actions: <Widget>[
                langButton(
                  userInfo: appSettingsModel,
                  text: 'Ru',
                  code: 'ru',
                  country: 'RU',
                ),
                langButton(
                  userInfo: appSettingsModel,
                  text: 'En',
                  code: 'en',
                  country: 'US',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
