import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/advert_scroller.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_drawer.dart';
import 'package:kzm/core/components/widgets/notifications_widget.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/advert_model.dart';
import 'package:kzm/core/models/recognition/my_recognition.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/layout/main_widgets/main_tile.dart';
import 'package:kzm/layout/main_widgets/profile.dart';
import 'package:kzm/layout/main_widgets/tile.dart';
import 'package:kzm/pageviews/recognition/my_recognition_page_view.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:kzm/viewmodels/recognition_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/layout/main_layout.dart';

class MainLayout extends StatefulWidget {
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int count = 0;
  List<MyRecognition> myRecognition;
  List<MainList> listBadge = <MainList>[
    MainList(
      image: 'assets/images/gold.png',
      count: 0,
      name: 'Gold',
      recognition: null,
    ),
    MainList(
      image: 'assets/images/silver.png',
      count: 0,
      name: 'Silver',
      recognition: null,
    ),
    MainList(
      image: 'assets/images/med.png',
      count: 0,
      name: 'Cooper',
      recognition: null,
    ),
    MainList(
      image: 'assets/images/badge_first.png',
      count: 0,
      name: '5 years of work for the Company / Group',
      recognition: null,
    ),
    MainList(
      image: 'assets/images/badge_second.png',
      count: 0,
      name: '3 years of work for the Company / Group',
      recognition: null,
    ),
  ];


  void notificationService() async{
    final NotificationModel notificationModel = Provider.of<NotificationModel>(navigatorKey.currentContext, listen: false);
    final UserViewModel userModel = Provider.of<UserViewModel>(context, listen: false);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      notificationModel.notificationsCount.then((int value) => setState(() {}));
      setState(() {});
    });
    final Box settings = await HiveService.getBox('settings');
    final bool auth = settings.get('authorized') ?? false;
    userModel.auth = auth ?? false;
  }

  void handleMessageOnBackground() {
    FirebaseMessaging.instance.getInitialMessage().then(
          (remoteMessage) async{
        if (remoteMessage != null) {
          var box = await HiveService.getBox('settings');
          await box.put('tabNotification', remoteMessage.data);
          clickNotification();
        }
      },
    );
  }

  @override
  void initState() {
    notificationService();
    handleMessageOnBackground();
    super.initState();
  }

  Future<void> clickNotification()async{
    final NotificationModel notificationModel = Provider.of<NotificationModel>(navigatorKey.currentContext, listen: false);
    var box = await HiveService.getBox('settings');
    var tab = box.get('tabNotification');
    if(tab !=null){
      if(tab['click_action'] == "TASK"){
        notificationModel.openRequestByID(
            name: tab['windowPropertyName'],
            id: tab['referenceId'],
            context: navigatorKey.currentContext,
        ).then((value) =>  setState((){
          box.put('tabNotification', null);
        }));
      }else{
        await Navigator.pushNamed(navigatorKey.currentContext ,KzmPages.notificationsPage).then((value) =>  setState((){
          box.put('tabNotification', null);
        }),);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsModel appSetting = context.read<AppSettingsModel>();
    final RecognitionModel recognitionModel = context.read<RecognitionModel>();
    final NotificationModel notifications = context.read<NotificationModel>();
    return KzmScreen(
      endDrawer: KzmMenuDrawer(tiles: appSetting.tiles),
      appBar: KzmAppBar(
        context: context,
        leading: SizedBox(),
        // settings: true,
        showMenu: true,
      ),
      body: Column(
        children: <Widget>[
          ProfileMain(),
          FutureBuilder<List<MyRecognition>>(
            future: recognitionModel.recognition,
            builder: (BuildContext context,
                AsyncSnapshot<List<MyRecognition>> snapshot) {
              return (snapshot.connectionState != ConnectionState.done)
                  ? const SizedBox()
                  : recognitionModel.groupQuestion != null
                  ? Padding(
                padding: paddingHorizontal(top: 4.w, bottom: 4.h),
                child: SizedBox(
                  height: Styles.appAdScrollerHeight,
                  child: ListView.builder(
                    itemCount: listBadge.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext _, int index) {
                      int activeCount = 0;
                      recognitionModel.groupQuestion.forEach(
                              (String key, List<MyRecognition> value) {
                            if (listBadge[index].name == key) {
                              listBadge[index].recognition = value;
                              for (MyRecognition list in value) {
                                if (list.isActive ==true) {
                                  activeCount++;
                                }
                              }
                            }
                          });
                      listBadge[index].count = activeCount;
                      return GestureDetector(
                        onTap: listBadge[index].recognition == null
                            ? null
                            : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MyRecognitionPageView(
                                  list: listBadge[index],
                                ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          width: MediaQuery.of(context).size.width /
                              5.8.w,
                          decoration: BoxDecoration(
                            color:
                            listBadge[index].recognition == null
                                ? Styles.appDarkGrayColor
                                : Styles.appWhiteColor,
                            borderRadius: BorderRadius.circular(8.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                listBadge[index].image,
                                width: 25.w,
                                height: 25.h,
                              ),
                              Text(
                                listBadge[index].count.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
                  : SizedBox();
            },
          ),
          NotificationWidget(model: notifications),
          KzmMainTile(data: appSetting.questionTile),
          FutureBuilder<List<TileData>>(
            future: appSetting.tiles,
            initialData: const <TileData>[],
            builder:
                (BuildContext context, AsyncSnapshot<List<TileData>> snapshot) {
              return (snapshot.connectionState != ConnectionState.done)
                  ? const SizedBox()
                  : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                spacing: Styles.appStandartMargin,
                runSpacing: Styles.appStandartMargin,
                children: snapshot.data
                    .map((TileData e) =>
                e.showOnMainScreen ? KzmTile(data: e) : null)
                    .toList()
                  ..removeWhere((KzmTile element) => element == null),
              );
            },
          ),
          Padding(
            padding: paddingHorizontal(top: 8.w),
            child: FutureBuilder<List<KzmAdModel>>(
              initialData: const <KzmAdModel>[],
              future: appSetting.adverts,
              builder: (BuildContext context,
                  AsyncSnapshot<List<KzmAdModel>> snapshot) {
                return (snapshot.connectionState != ConnectionState.done)
                    ? const SizedBox()
                    : KzmAdScroller(images: snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
