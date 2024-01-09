import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/components/widgets/dialog.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/main_widgets/tile.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/core/components/widgets/menu_drawer.dart';

class KzmMenuDrawer extends StatefulWidget {
  final Future<List<TileData>> tiles;

  const KzmMenuDrawer({
    @required this.tiles,
    Key key,
  }) : super(key: key);

  @override
  State<KzmMenuDrawer> createState() => _KzmMenuDrawerState();
}

class _KzmMenuDrawerState extends State<KzmMenuDrawer> {
  bool isSwitched = false;
  bool useTouchId = false;
  bool useBio = false;
  Box<dynamic> box;

  void checkTouchId() async {
    box = await HiveService.getBox('settings');
    useBio = box.get('useBio') as bool;
    final List<BiometricType> availableBiometrics =
    await LocalAuthentication().getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.weak) ||
        availableBiometrics.contains(BiometricType.strong)) {
      setState(() {
        useTouchId = true;
      });
    }
  }

  @override
  void initState() {
    checkTouchId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsModel appSetting = context.read<AppSettingsModel>();
    final UserViewModel userModel = context.read<UserViewModel>();
    final String routeName = ModalRoute.of(context).settings.name;
    return Drawer(
      child: FutureProvider<List<TileData>>(
        initialData: null,
        create: (BuildContext context) => widget.tiles,
        child: Consumer<List<TileData>>(
          builder: (BuildContext context, List<TileData> tiles, Widget child) {
            if (tiles == null) {
              return const LoaderWidget();
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        if (routeName == KzmPages.init ||
                            routeName == KzmPages.login)
                          const SizedBox()
                        else
                          KzmTile(
                            data: TileData(
                              name: S.current.home,
                              url: KzmPages.init,
                              svgIcon: SvgIconData.home,
                              showOnMainScreen: true,
                            ),
                            isDrawer: true,
                          ),
                        ...tiles
                            .map((TileData e) =>
                            KzmTile(data: e, isDrawer: true))
                            .toList(),
                      ],
                    ),
                    if (useTouchId)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(S.current.touchAuth,
                            style: Styles.mainTS,),
                          Switch(
                            value: useBio,
                            onChanged: (value) async {
                              if (useBio == false) {
                                await box.put('useBio', true);
                                setState(() {
                                  useBio = true;
                                });
                              } else {
                                await box.put('useBio', false);
                                setState(() {
                                  useBio = false;
                                });
                              }
                            },
                          ),
                        ],
                      )
                    else
                      SizedBox(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          showMyDialog(
                            context: context,
                            thenFunction: () =>
                                appSetting.logout(
                                    userViewModel: userModel, context: context,),
                            content: Text(
                              S.current.areYouSureToLogout,
                              style: Styles.mainTS,
                            ),
                            title: Text(
                              S.current.logout,
                              style: Styles.mainTxtTheme.headline6,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(S.current.logout,
                              style: Styles.mainTS,),
                            SizedBox(width: 16,),
                            const Icon(Icons.logout, size: 32,
                              color: Styles.appCorporateColor,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 140,
                      child: Padding(
                        padding: paddingLRB,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FutureBuilder<String>(
                              future: context
                                  .read<AppSettingsModel>()
                                  .appVersion,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return SizedBox(
                                    child: Text('${S.current.version} ${snapshot.data ?? ''}',
                                        style: Styles.mainTS));
                              },
                            ),
                            FutureBuilder<String>(
                              future: endpointUrlAsync,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                // if (snapshot.connectionState == ConnectionState.done && snapshot.data != endpointPROD) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                    snapshot.data !=
                                        endpointUrls[Builds.prod]) {
                                  return TextButton(
                                    onPressed: () =>
                                        showCupertinoDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: SizedBox(
                                                width: 300,
                                                child: CupertinoActionSheet(
                                                  message: const Text(
                                                      'Выберите сервер'),
                                                  cancelButton: CupertinoButton(
                                                    onPressed: () => Get.back(),
                                                    child:
                                                    Text(S.current.cancel),
                                                  ),
                                                  actions: <Widget>[
                                                    ...endpointUrls.keys.map(
                                                            (Builds e) {
                                                          if (e !=
                                                              Builds.prod) {
                                                            return CupertinoActionSheetAction(
                                                              onPressed: () async {
                                                                final SettingsModel
                                                                settingModel =
                                                                context.read<
                                                                    SettingsModel>();
                                                                settingModel
                                                                    .exit(
                                                                    context
                                                                        .read<
                                                                        AppSettingsModel>(),
                                                                    newUrl:
                                                                    endpointUrls[
                                                                    e]);
                                                              },
                                                              child: Text(
                                                                endpointUrls[e],
                                                                style:
                                                                Styles.cardTS,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                            );
                                                          }
                                                        }).where(
                                                            (
                                                            CupertinoActionSheetAction
                                                            e) =>
                                                        e != null),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                    style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          Styles.mainTS.copyWith(fontSize: 12)),
                                    ),
                                    child: Text(
                                      snapshot.data,
                                      style: Styles.mainTS.copyWith(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        catchError: (BuildContext context, Object object) {
          return <TileData>[];
        },
      ),
    );
  }
}
