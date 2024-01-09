// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/login/pin/pin_widgets.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';


class PinMobileCreate extends StatelessWidget {
  var defaultFontSize = 16.0;
  var errorTextStyle =
  generalFontStyle.copyWith(color: Styles.appCancelBtnColor, fontSize: 16.0);
  var keyTextStyle =
  generalFontStyle.copyWith(color: Colors.black, fontSize: 25.0);
  var codeTextStyle = generalFontStyle.copyWith(
      color: Styles.appGrayColor, fontSize: 25.0, fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, model, _) {
      return Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    CodeView(
                      codeTextStyle: codeTextStyle,
                      code: (!model.pinRepeat ? model.pin1 : model.pin2),
                      obscurePin: false,
                      length: 4,
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ),
            Text(
              model.pinRepeat ? S().repeatePin : S().enterPin,
              style: generalFontStyle.copyWith(
                  fontSize: 17, fontWeight: FontWeight.w300),
            ),
            if (model.pinInCorrect) Text(
              S.current.doesntMatchPin,
              style: errorTextStyle,
              textAlign: TextAlign.center,
            ) else const SizedBox(),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: CustomKeyboard(
                textStyle: keyTextStyle,
                onPressedKey: (key) async{
                  final dynamic box = await HiveService.getBox('settings');
                  var length =
                      (!model.pinRepeat ? model.pin1 : model.pin2).length;
                  if (length < 4) {
                    if (!model.pinRepeat) {
                      model.pin1 += key.toString();
                      model.setBusy(false);
                    } else {
                      model.pin2 += key.toString();
                      model.setBusy(false);
                    }
                  }
                  if (length == 3) {
                    if (model.pin1 == model.pin2) {
                      model.setPin();
                      Get.offNamedUntil('/init', ModalRoute.withName('/'));

                      return;

                    }
                    if (model.pin1 != model.pin2 && model.pinRepeat) {
                      model.pinRepeat = false;
                      model.pinInCorrect = true;
                      model.pin1 = '';
                      model.pin2 = '';
                      return;
                    }
                    model.pinRepeat = true;
                    model.setBusy(false);
                  }
                },
                onBackPressed: () {
                  var codeLength =
                      (!model.pinRepeat ? model.pin1 : model.pin2).length;
                  if (codeLength > 0) {
                    if (!model.pinRepeat) {
                      model.pin1 = model.pin1.substring(0, codeLength - 1);
                      model.setBusy(false);
                    } else {
                      model.pin2 = model.pin2.substring(0, codeLength - 1);
                      model.setBusy(false);
                    }
                  }
                },
              ),
            ),
          ]),
        ),
      );
    });
  }
}
