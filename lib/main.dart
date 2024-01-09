import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/firebase/PushNotificationService.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/service/provider/provider.dart';
import 'package:new_version/new_version.dart';
const String fName = 'lib/main.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final box = await HiveService.getBox('settings');
  await box.put('tabNotification', message.data);
  await Firebase.initializeApp();

  await PushNotificationService().initialise();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyHttpOverrides extends HttpOverrides {
  final int maxConnections = 5;
  @override
  HttpClient createHttpClient(SecurityContext context) {
    final HttpClient client = super.createHttpClient(context);
    client.maxConnectionsPerHost = maxConnections;
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
NewVersion newVersion = NewVersion();
AppVersionChecker androidVersion = AppVersionChecker();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  newVersion = NewVersion(
      iOSId: 'kz.uco.kazmineralmobile',
      androidId: 'kz.uco.kazmineralmobile');
  androidVersion = AppVersionChecker(
    appId: "kz.uco.kazmineralmobile",
    androidStore: AndroidStore.googlePlayStore,
  );
  try{
    await initServices();
  }catch(e){
    print(e);
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runZonedGuarded(
        () {
      Get.put(KzmProvider());
      runApp(MyApp());
    },
        (Object error, StackTrace stackTrace) {
    },
  );
}

Future<void> initServices() async {
  try {
    await Hive.initFlutter();
    HiveUtils.regAdapters();
  } catch (ex) {
    log('Initializing Failed with an Exception', error: jsonEncode(ex));
  }
}
