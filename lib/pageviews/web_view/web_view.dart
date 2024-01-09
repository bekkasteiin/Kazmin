import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KzmWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KzmScreen(
      body: WebView(
        // initialUrl: 'https://flutter.dev/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          developer.log('-->> onWebViewCreated');
          final UserInfo info = await HiveUtils.getUserInfo();
          final dynamic client = await Kinfolk().getToken(info.login.trim(), info.password.trim());
          // final oauth2.Client x = await Kinfolk.getClient() as oauth2.Client;
          developer.log('-->> token: ${client.credentials.accessToken}');
          final Map<String, String> headers = <String, String>{'Authorization': 'Bearer ${client.credentials.accessToken}'};
          developer.log('-->> headers: ${headers.toString()}');
          webViewController.loadUrl(
              'http://kzmala3503.kazminerals.kazakhmys.local/kzm-front/#/my-education?access_token=${client.credentials.accessToken}', /*, headers: headers*/);
        },
      ),
    );
  }
}
