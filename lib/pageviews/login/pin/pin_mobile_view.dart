// ignore_for_file: missing_return

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/service/socket.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/login/login_view.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

import 'pin_widgets.dart';

class PinMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KZMSocket socket = context.read<KZMSocket>();
    final UserViewModel user = Provider.of<UserViewModel>(context, listen: false);
    final AppSettingsModel appSettingsModel = Provider.of<AppSettingsModel>(context, listen: false);
    user.readBio();
    return FutureProvider<String>(
        create: (BuildContext context) => user.pin,
        initialData: 'default',
        child: Consumer<UserViewModel>(
            builder: (BuildContext context, UserViewModel model, _) {
              return Consumer<String>(
                  builder: (BuildContext context, String pinModel, _) {
                    return Scaffold(
                      appBar: KzmAppBar(
                        context: context,
                      ),
                      body: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return CupertinoAlertDialog(
                                          title: Text(S.current.exitUser),
                                          content: Text(S.current.exitUserInfo),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text(S.current.yes),
                                              onPressed: () => appSettingsModel.logout(userViewModel: model, context: context, fullExitApp: true),
                                            ),
                                            CupertinoDialogAction(
                                              child: Text(S.current.no),
                                              onPressed: () => Get.back(),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.exit_to_app,
                                    color: Styles.appDarkBlueColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) => LoginView()),
                                        (Route route) => false),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close_outlined,
                                    color: Styles.appDarkBlueColor,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Expanded(
                            child: PinCode(
                              backgroundColor: Colors.white,
                              codeTextStyle: generalFontStyle.copyWith(
                                  color: Colors.black12,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                              subTitle: Text(
                                S.current.enterPinTitle,
                                textAlign: TextAlign.center,
                                style: generalFontStyle.copyWith(fontSize: 14),
                              ),
                              error: model.pinInCorrect ? S().incorrectPin : '',
                              codeLength: 4,
                              obscurePin: true,
                              correctPin: pinModel,
                              onCodeSuccess: (code)  {
                                 model.regFromSaved(context, socket);
                              },
                              onCodeFail: (code) {
                                model.pinInCorrect = true;
                                model.setBusy(false);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
