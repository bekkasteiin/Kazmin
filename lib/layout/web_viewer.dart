import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatefulWidget {
  final String url;

  const WebViewer({Key key, this.url}) : super(key: key);

  @override
  WebViewerState createState() => WebViewerState();
}

class WebViewerState extends State<WebViewer> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
