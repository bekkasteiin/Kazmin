import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/dialog.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/settings/widgets.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsModel()),
      ],
      child: Consumer<SettingsModel>(
        builder: (BuildContext context, SettingsModel counter, _) {
          return ScreenTypeLayout(
            mobile: SettingsPage(),
            tablet: SettingsPage(),
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final SettingsModel settingModel = Provider.of<SettingsModel>(context);
    final AppSettingsModel appSettingsModel = Provider.of<AppSettingsModel>(context);
    final UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      // appBar: defaultAppBar(
      //   context,
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 10),
      //       child: InkWell(
      //         onTap: () => showAboutDialog(
      //             context: context,
      //             applicationName: 'KZM',
      //             applicationVersion: 'Version: ' + currentVersion.toString(),
      //             applicationLegalese: 'Разработчик: ТОО "UCO"'),
      //         child: Icon(Icons.info_outline),
      //       ),
      //     )
      //   ],
      // ),
      appBar: KzmAppBar(
        context: context,
        actions: <Padding>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () => showAboutDialog(
                context: context, applicationName: 'KZM', applicationVersion: 'Version: $currentVersion', applicationLegalese: 'Разработчик: ТОО "UCO"',),
              child: const Icon(Icons.info_outline),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              KzmMenuItem(
                item: Item(Icons.language, S.current.language, null, Colors.white),
                onTap: () {
                  changeLang(context, appSettingsModel);
                  setState((){});
                },
              ),
              // KzmMenuItem(
              //   item: Item(Icons.link, 'URL', null, Colors.white),
              //   onTap: () => changeUrl(context, appSettingsModel, settingModel),
              // ),
              KzmMenuItem(
                item: Item(Icons.remove_red_eye_outlined, S.current.changePassword, null, Colors.white),
                onTap: () => changePassword(context, appSettingsModel, settingModel),
              ),
              KzmMenuItem(
                item: Item(Icons.exit_to_app_rounded, S.current.logout, null, Colors.white),
                onTap: () => showMyDialog(
                  context: context,
                  thenFunction: () => appSettingsModel.logout(userViewModel: userViewModel,context: context),
                  content: Text(
                    S.current.areYouSureToLogout,
                    style: Styles.mainTS,
                  ),
                  title: Text(
                    S.current.logout,
                    style: Styles.mainTxtTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 20),
          //   child: CupertinoButton.filled(
          //     child: Text(S.current.logout),
          //     // padding: EdgeInsets.symmetric(horizontal: 32),
          //     // bgColor: appPrimaryColor,
          //     onPressed: () => showMyDialog(
          //       context: context,
          //       thenFunction: () => appSettingsModel.logout(userViewModel),
          //       content: Text(
          //         'Вы действительно хотите выйти?',
          //         style: mainTS,
          //       ),
          //       title: Text(
          //         'Выход',
          //         style: mainTS.copyWith(
          //             fontSize: 20, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
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
              actions: [
                langButton(
                  userInfo: appSettingsModel,
                  text: 'Ru',
                  code: 'ru',
                  country: 'RU',
                ),
                // langButton(
                //   userInfo: appSettingsModel,
                //   text: 'Kz',
                //   code: 'kk',
                //   country: 'KZ',
                // ),
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

  // void changeUrl(
  void changePassword(
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
            children: [
              FieldBones(
                placeholder: 'Текущий пароль',
                isTextField: true,
                onChanged: (String val) => settingModel.password = val,
                isMinWidthTiles: true,
              ),
              FieldBones(
                placeholder: 'Новый пароль',
                isTextField: true,
                onChanged: (String val) => settingModel.newPassword = val,
                isMinWidthTiles: true,
              ),
              FieldBones(
                placeholder: 'Повторите пароль',
                isTextField: true,
                onChanged: (String val) => settingModel.newPasswordCopy = val,
                isMinWidthTiles: true,
              ),
            ],
          ),
          actions: [
            CupertinoButton(
              onPressed: () => settingModel.changePassword(),
              child: Text(S.current.save),
            ),
          ],
        );
      },
    );
  }
}

Widget langButton({
  @required String text,
  @required String code,
  @required String country,
  AppSettingsModel userInfo,
}) {
  return CupertinoActionSheetAction(
    onPressed: (){
      userInfo.localeCode = code;
      userInfo.setLang(lang: code, cntry: country);
    },
    isDefaultAction: userInfo.locale.languageCode == code,
    child: Text(text),
  );
}
