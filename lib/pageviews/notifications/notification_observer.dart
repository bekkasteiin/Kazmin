import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String fName = 'lib/pageviews/notifications/notification_observer.dart';

class NotificationObserver extends StatelessWidget {
  final NotificationModel model;

  const NotificationObserver({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // appBar: defaultAppBar(context),
    //   appBar: KzmAppBar(context: context),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             model.selected.notificationHeader,
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //         ),
    //         SizedBox(height: 10),
    //         Html(
    //           data: model.selected.notificationBody,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.loadUrl(
            Uri.dataFromString(
              model.selected.notificationBody,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
          );
          model.refreshData();
          // loadAsset();
        },
      ),
    );
  }
}
