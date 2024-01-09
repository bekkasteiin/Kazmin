import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/models/notification/notification.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/notifications/notification_observer.dart';
import 'package:kzm/viewmodels/base_model.dart';

const String fName = 'lib/viewmodels/notification_model.dart';

class NotificationModel extends BaseModel {
  List<NotificationTemplate> tasks;
  List<NotificationTemplate> notifications;
  NotificationTemplate selected;
  NotificationTemplate selectedTask;
  void Function() refreshData;

  Future<int> get notificationsCount async {
    tasks = await RestServices.getMyTasksNotifications(getNotification: false);
    notifications = await RestServices.getMyTasksNotifications(getNotification: true);
    return tasks.length + notifications.length;
  }

  Future<void> selectItem(
    NotificationTemplate selected, {bool inExternalBrowser = true}) async {
    setBusy(true);
    this.selected = selected;
    setBusy(false);
      Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(builder: (_)=>
            NotificationObserver(model: this),
        ),
      );
  }
}
