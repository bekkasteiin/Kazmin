// import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:version/version.dart';

const String fName = 'lib/core/constants/globals.dart';

enum Builds { test, prpp, prod }

Map<Builds, String> endpointUrls = <Builds, String>{
  Builds.test: 'https://test-adhr.kazminerals.com/kzm',
  Builds.prpp: 'https://adhrpp.kazminerals.com/kzm',
  Builds.prod: 'https://mykazmin.kazminerals.com/kzm',
};

Map<Builds, String> socketUrls = <Builds, String>{
  Builds.test: 'wss://test-adhr.kazminerals.com/kzm-core/ws/handler/995/sstwz40l/websocket',
  Builds.prpp: 'wss://adhrpp.kazminerals.com/kzm-core/ws/handler/234/el1tl120/websocket',
  Builds.prod: 'http://dev.uco.kz:8014/kzm-core/ws/handler',
};

// Builds.prod
// Login: Naziya.Sabirova
// Password: 2zZqL5P1

Builds currentBuild = Builds.prod;

Future<String> get endpointUrlAsync async {
  if (currentBuild == Builds.prod) {
    return endpointUrls[Builds.prod];
  }
  final Box<dynamic> settings = await HiveUtils.getSettingsBox();
  final String url = settings.get('url') as String;
  // log('-->> $fName, endpointUrlAsync ->> url: $url');
  if (url == null) {
    currentBuild = Builds.prpp;
    settings.put('url', endpointUrls[currentBuild]);
    return endpointUrls[currentBuild];
  } else {
    endpointUrls.forEach((Builds key, String value) {
      if (value == url) currentBuild = key;
    });
  }
  return url;
}

// String localEndPoint = endpointUrl;

final Version currentVersion = Version(1, 2, 182);

const bool kTestingCrashlytics = true;

const String richTextToolBar = """
    [
      ['style', ['bold', 'italic', 'underline']],
      ['font', ['fontsize']],
      ['para', ['ul', 'ol']],
    ]
  """;

String language = 'ru';
String country = 'RU';
const int signUpVerifySeconds = 300;
const int minimalDateTimeYear = 2000;
var generalFontStyle = GoogleFonts.openSans();

int mapLocale() {
  const Map<String, int> locales = <String, int>{
    'RU': 1,
    'KK': 2,
    'EN': 3,
  };
  return locales[Get.locale.languageCode.toUpperCase()];
}

void showBusy({bool busy}) {
  while (Get.isDialogOpen) {
    Get.back();
  }
  if (busy) Get.dialog(const LoaderWidget(isPop: true));
}

// Future<void> kzmLog({
//   @required String name,
//   Map<String, Object> parameters,
//   AnalyticsCallOptions callOptions,
// }) async {
//   log('-->> $fName, FB instance ->> ${FirebaseAnalytics.instance}');
//   FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters, callOptions: callOptions);
// }

Future<void> kzmLog({
  @required String fName,
  @required String func,
  @required String text,
  String data
}) async {
  final DateTime t = DateTime.now();
  log('-->> $t | $fName | $func -->> $text${(data != null) ? '\n-->> $data' : ''}');
}
