import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/notifications/notifications_widget.dart';
import 'package:kzm/pageviews/notifications/task_widget.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotificationPageView extends StatelessWidget {
  int indexPage;
  NotificationPageView({this.indexPage});
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        // providers: <ChangeNotifierProvider<NotificationModel>>[
        //   ChangeNotifierProvider<NotificationModel>(create: (_) => NotificationModel()),
        // ],
        // child:
        Consumer<NotificationModel>(
      builder: (BuildContext context, NotificationModel counter, _) {
        return ScreenTypeLayout(
          mobile: NotificationPage(indexPage: indexPage),
          tablet: NotificationPage(indexPage: indexPage),
        );
      },
      // ),
    );
  }
}

class NotificationPage extends StatefulWidget {
  int indexPage;
  NotificationPage({this.indexPage});
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final NotificationModel model = Provider.of<NotificationModel>(context);
    return DefaultTabController(
      initialIndex: widget.indexPage ?? 0,
      length: 2,
      child: Scaffold(
        // appBar: AppBar(
        //   flexibleSpace: appBarBg(context),
        //   title: BrandLogo(),
        //   centerTitle: false,
        //   bottom: TabBar(
        //     tabs: [
        //       Tab(text: S.current.task),
        //       Tab(text: S.current.notifications),
        //     ],
        //   ),
        // ),
        // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
        appBar: KzmAppBar(
          context: context,
          bottom: TabBar(
            tabs: <Tab>[
              Tab(text: S.current.task),
              Tab(text: S.current.notifications),
            ],
          ),
        ),
        // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
        // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
        body: TabBarView(
          children: <Widget>[
            TaskWidget(model: model),
            NotificationsWidget(model: model),
          ],
        ),
      ),
    );
  }
}
