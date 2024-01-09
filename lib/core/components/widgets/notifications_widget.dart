import 'package:flutter/cupertino.dart';
import 'package:kzm/layout/main_widgets/main_tile.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel model;

  const NotificationWidget({this.model});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    widget.model.refreshData = refreshData;
    widget.model.notificationsCount.then((int value) => setState(() {}));
    // FirebaseConfig.init();
    super.initState();
  }

  void refreshData() {
    widget.model.notificationsCount.then((int value) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    final AppSettingsModel appSetting = context.read<AppSettingsModel>();
    return FutureBuilder(
      future: widget.model.notificationsCount,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return (snapshot.connectionState != ConnectionState.done)
            ? KzmMainTile(data: appSetting.mainTile, onTap: refreshData,)
            : KzmMainTile(data: appSetting.mainTile, counter: snapshot.data, onTap: refreshData,);
      },
    );
  }
}
