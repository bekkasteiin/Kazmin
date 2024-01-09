import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/pageviews/notifications/notification_mobile_view.dart';

class FirebasePushConfig {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future initialise() async {
    _fcm.getInitialMessage()
        .then((RemoteMessage message) async {
      if (message != null) {
        // print('${message.data['entityId']}');
        // print('sdddd');

      }});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;

      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channel.description,
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: 'launch_background',
      //         ),
      //       ));
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // NotificationModel model = NotificationModel();
      // print("2");
      // model.selectedTask = await RestServices.getNotificationById(entityId: "${message.data['entityId']}");
      // print("3");
      // print(model.selectedTask.id);
      // model.selectTask;
      // print("4");
      Get.to(NotificationPageView());

    });
  }

  Future sendDataToServer() async {
    print('sendDataToServer');
    final String token = await FirebaseMessaging.instance.getToken();
    String deviceId = '';
    String deviceInfo = '';
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
        deviceId = deviceData.androidId;
        deviceInfo = '${deviceData.brand}:${deviceData.model}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo deviceData = await deviceInfoPlugin.iosInfo;
        deviceId = deviceData.identifierForVendor;
        deviceInfo = 'apple:${deviceData.model}';
      }
      // ignore: empty_catches
    } catch (ex) {
      print(ex);
    }

    await Kinfolk.getSingleModelRest(
      serviceName: 'mobile_MobileRestService',
      fromMap: (Map<String, dynamic> val) => val,
      type: Types.services,
      body: '''{
                 "token":"$token",
                 "deviceId":"$deviceId",
                 "deviceInfo":"$deviceInfo"
               }''',
      methodName: 'saveFcmTokenBySessionUser',
    );
  }


}
