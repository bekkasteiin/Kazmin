import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

class PushNotificationService {


  Future<void> _onMessageOpenApp(RemoteMessage message) async {
    await Firebase.initializeApp();
    var box = await HiveService.getBox('settings');
    await box.put('tabNotification', message.data);

  }

  String titleLang(language, dynamic title){
    if(language == 'ru'){
      return title['titleRu'];
    }else if(language == 'kz'){
      return title['titleKz'];
    }else if(language == 'en'){
      return title['titleEn'];
    }else{
      return title['titleRu'];
    }
  }

  Future initialise() async {
    final AppSettingsModel appSettingsModel = Provider.of<AppSettingsModel>(navigatorKey.currentContext, listen: false);
    final NotificationModel notificationModel = Provider.of<NotificationModel>(navigatorKey.currentContext, listen: false);

    if (kIsWeb) {
      return;
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await RestServices.getMyTasksNotifications(getNotification: false);
      await RestServices.getMyTasksNotifications(getNotification: true);
      RemoteNotification notification = message.notification;
      if (notification != null) {
        MotionToast(
          height: 100,
          padding: EdgeInsets.all(8),
          icon: Icons.notifications_active_outlined,
          width:  MediaQuery.of(navigatorKey.currentContext).size.width,
          position:  MotionToastPosition.top,
          animationType:  AnimationType.fromTop,
          title:  Text("My Kazmin"),
          description:  InkWell(
            onTap: ()async{
              if(message.data['click_action'] == "TASK"){
                Navigator.pop(navigatorKey.currentContext);
                notificationModel.openRequestByID(
                    name: message.data['windowPropertyName'],
                    id: message.data['referenceId'],
                    context: navigatorKey.currentContext,
                );
              }else{
                Navigator.pop(navigatorKey.currentContext);
                await Get.toNamed(KzmPages.notificationsPage);
              }
            },
            child: Text(titleLang(appSettingsModel.localeCode, message.data) ?? notification.title,),),
          primaryColor: Styles.appSuccessColor,
        ).show(navigatorKey.currentContext);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await HiveService.getClearBox('tabNotification');
      MotionToast(
        height: 100,
        padding: EdgeInsets.all(8),
        icon: Icons.notifications_active_outlined,
        width:  MediaQuery.of(navigatorKey.currentContext).size.width,
        position:  MotionToastPosition.top,
        animationType:  AnimationType.fromTop,
        title:  Text("My Kazmin"),
        description:  InkWell(
          onTap: ()async{
            if(message.data['click_action'] == "TASK"){
              Navigator.pop(navigatorKey.currentContext);
              notificationModel.openRequestByID(
                  name: message.data['windowPropertyName'],
                  id: message.data['referenceId'],
                  context: navigatorKey.currentContext,
              );
            }else{
              Navigator.pop(navigatorKey.currentContext);
              await Get.toNamed(KzmPages.notificationsPage);
            }
          },
          child: Text(titleLang(appSettingsModel.localeCode, message.data) ?? message.notification.title,),),
        primaryColor: Styles.appSuccessColor,
      ).show(navigatorKey.currentContext);
    });
  }
}
