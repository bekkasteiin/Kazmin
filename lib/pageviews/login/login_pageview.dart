import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/update_required_layout.dart';
import 'package:kzm/pageviews/login/login_view.dart';
import 'package:kzm/pageviews/login/pin/pin_page_view.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/login/login_pageview.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = context.watch<UserViewModel>();
    final AppSettingsModel appSettingsModel = context.read<AppSettingsModel>();

    return FutureProvider<String>(
      initialData: null,
      create: (BuildContext context) async => appSettingsModel.initApp(userModel: userModel),
      child: Consumer<String>(
        builder: (BuildContext context, String model, _) {
          if (model == null) {
            return const KzmScreen(body: Center(child: LoaderWidget()));
          }
          if (model is String && model == 'REQ_UPDATE') {
            return UpdateRequiedLayout();
          }
          return userModel.auth ? PinPage(false) : LoginView();
        },
      ),
      catchError: (BuildContext c, Object o) {
        log('-->> $fName, catchError, initApp \n$c, \n$o');
        // return o.toString();
        return null;
      },
    );
  }
}
