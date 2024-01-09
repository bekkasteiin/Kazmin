import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/notification/notification.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/notification_model.dart';


const String fName = 'lib/pageviews/notifications/notifications_widget.dart';

class NotificationsWidget extends StatefulWidget {
  final NotificationModel model;

  const NotificationsWidget({Key key, this.model}) : super(key: key);

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  @override
  void initState() {
    // list();
    widget.model.refreshData = refreshData;
    super.initState();
  }

  void refreshData() {
    widget.model.notificationsCount.then((int value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RestServices.getMyNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationTemplate>> snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget();
          }
          return snapshot.data.length == 0
              ? KZMNoData()
              : ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int i) {
              return KzmCard(
                maxLinesTitle: 3,
                title: snapshot.data[i]?.notificationHeader ?? '',
                subtitle: formatShortly(snapshot.data[i].startDateTime),
                selected: () {
                  widget.model.selectItem(snapshot.data[i]).then(
                        (_) => <void>{
                      snapshot.data[i].status =
                          notificationStatusDone,
                      snapshot.data[i].name = 'name',
                      RestServices.updateEntity(
                        entityName: snapshot.data[i].entityName,
                        entityId: snapshot.data[i].id,
                        entity: snapshot.data[i],
                      )
                    },
                  );
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            },
          );
        },);
  }
}