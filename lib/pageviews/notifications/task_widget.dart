import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/notification/notification.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/notifications/task_widget.dart';

class TaskWidget extends StatefulWidget {
  final NotificationModel model;

  const TaskWidget({this.model});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  // Future<List<NotificationTemplate>> _list;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsModel appSettingsModel =
        Provider.of<AppSettingsModel>(context);
    return FutureBuilder(
      future: RestServices.getMyTasksNotifications(getNotification: false),
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
                    maxLinesTitle: 2,
                    title: snapshot.data[i]?.notificationHeaderLang(
                            appSettingsModel.localeCode) ??
                        '',
                    subtitle: formatFullNumeric(snapshot.data[i].updateTs),
                    selected: () {
                      widget.model.openRequestByID(
                        name: snapshot.data[i]?.type?.windowProperty
                            ?.windowPropertyEntityName,
                        id: snapshot.data[i]?.referenceId,
                        context: context,
                      );
                    },
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  );
                },
              );
      },
    );
  }
}
