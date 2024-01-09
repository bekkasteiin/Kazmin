// ignore_for_file: always_specify_types

import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/models/advert_model.dart';
import 'package:kzm/core/models/recognition/my_recognition.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/firebase/PushNotificationService.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/viewmodels/app_settings_model.dart';

class AppSettingsModel extends BaseModel {
  bool exit = false;
  int counter = 0;
  Locale locale = const Locale('ru', 'RU');
  String localeCode = 'ru';
  String localeCountry = 'RU';
  String url;

  AppSettingsModel() {
    GlobalVariables.lang = localeCode;
  }



  Future<List<KzmAdModel>> get adverts async{
    List<String> companyList = await RestServices().getCompaniesByPersonGroupId();
    return RestServices.getAdverts(listCompany: companyList);
  }

  TileData get mainTile => TileData(
    name: S.current.tasksNotifications,
    url: KzmPages.notifications,
    svgIcon: SvgIconData.notification,
    showOnMainScreen: true,
  );

  TileData get questionTile => TileData(
    name: S.current.everydayQuestions,
    url: KzmPages.dailyQuestions,
    svgIcon: SvgIconData.everydayQuestions,
    showOnMainScreen: true,
  );

  Future<String> get appVersion async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // return '${packageInfo.version}.${packageInfo.buildNumber}';
    log('-->> $fName, appVersion ->> buildNumber: ${packageInfo.buildNumber}');
    if (currentBuild != Builds.prod) return packageInfo.version;
    return packageInfo.version;
  }

  Future<List<TileData>> get tiles async {
    final bool chief = await Get.context.read<UserViewModel>().isChief;
    return <TileData>[
      TileData(
        name: S.current.lk,
        url: KzmPages.privateOffice,
        svgIcon: SvgIconData.profile,
        showOnMainScreen: true,
      ),

      // TileData(
      //   name: S.current.myProfile,
      //   url: null,
      //   svgIcon: SvgIconData.profile,
      //   showOnMainScreen: true,
      // ),

      TileData(
        name: S.current.hr,
        url: KzmPages.hrRequests,
        svgIcon: SvgIconData.myTeam,
        showOnMainScreen: true,
      ),

      TileData(
        name: S.current.myCalendar,
        url: KzmPages.trainingCalendar,
        svgIcon: SvgIconData.calendar,
        showOnMainScreen: true,
      ),

      TileData(
        name: S.current.organizationVacancies,
        url: KzmPages.vacationOrg,
        svgIcon: SvgIconData.vacancies,
        showOnMainScreen: true,
      ),

      if (chief)
        TileData(
          name: S.current.myTeam,
          url: KzmPages.myTeam,
          svgIcon: SvgIconData.myTeam,
          showOnMainScreen: true,
        )
      else
        TileData(
          name: S.current.jclRequest,
          url: KzmPages.certificate,
          svgIcon: SvgIconData.help,
          showOnMainScreen: true,
        ),

      // TileData(
      //   name: S.current.reference,
      //   url: null,
      //   svgIcon: SvgIconData.reference,
      //   showOnMainScreen: true,
      // ),

      TileData(
        name: S.current.training,
        url: KzmPages.learning,
        svgIcon: SvgIconData.learning,
        showOnMainScreen: true,
      ),

      TileData(
        name: S.current.sendMessage,
        url: KzmPages.sendMessage,
        svgIcon: SvgIconData.sendMessage,
        showOnMainScreen: true,
      ),

      TileData(
        name: S.current.competenceAssessment,
        url: KzmPages.competenceAssessment,
        svgIcon: SvgIconData.noImage,
        showOnMainScreen: false,
      ),
/*

      TileData(
        name: S.current.myAbsences,
        url: KzmPages.absence,
        svgIcon: SvgIconData.absence,
        showOnMainScreen: false,
      ),

      TileData(
        name: S.current.medicalInsurance,
        url: KzmPages.dms,
        svgIcon: SvgIconData.myDmc,
        showOnMainScreen: false,
      ),

      TileData(
        name: S.current.myKpi,
        url: KzmPages.mykpi,
        svgIcon: SvgIconData.myKpi,
        showOnMainScreen: false,
      ),

      TileData(
        name: S.current.teamsKpi,
        url: KzmPages.kpi,
        svgIcon: SvgIconData.kpiTeam,
        showOnMainScreen: false,
      ),
*/

      TileData(
        name: S.current.newEmployeesTitle,
        url: KzmPages.newEmployees,
        svgIcon: SvgIconData.profile,
        showOnMainScreen: false,
      ),

      // TileData('РВД, сверхурочка и времененный перевод', '/actions', SvgIconData.notification),
    ];
  }

  Future<void> setLang({@required String lang, @required String cntry}) async {
    locale = Locale(lang, cntry);
    language = lang;
    country = cntry;
    localeCode = lang;
    final dynamic settings = await HiveService.getBox('settings');
    settings.put('locale', lang);
    settings.put('country', cntry);
    GlobalVariables.lang = localeCode;
    await S.load(locale);
    Get.updateLocale(locale);
    // await S.load(locale).then((value) => {Get.back()});
    Get.back();
  }

  void logoTap() => counter++;

  Future<void> logout({UserViewModel userViewModel, BuildContext context, bool fullExitApp = false}) async {
    if(fullExitApp){
      userViewModel.person = null;
      userViewModel.personProfile = null;
      userViewModel.login = '';
      userViewModel.password = '';
      userViewModel.auth = false;
      userViewModel.useBio = null;
      GlobalVariables.token = null;
      final Box settingsBox = await HiveService.getBox('settings');
      final Box settings = await HiveUtils.getSettingsBox();
      settingsBox.delete('info');
      await settings.clear();
      await settingsBox.clear();
      await Hive.deleteFromDisk();
      settings.deleteFromDisk();
      exit = true;
      setBusy(false);
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }else{
      if(userViewModel.auth==false){
        userViewModel.person = null;
        userViewModel.personProfile = null;
        userViewModel.login = '';
        userViewModel.password = '';
        userViewModel.auth = false;
        GlobalVariables.token = null;
        userViewModel.useBio = null;
        final Box settingsBox = await HiveService.getBox('settings');
        final Box settings = await HiveUtils.getSettingsBox();
        settingsBox.delete('info');
        await settings.clear();
        await settingsBox.clear();
        await Hive.deleteFromDisk();
        settings.deleteFromDisk();
        exit = true;
        setBusy(false);
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/pin', (Route<dynamic> route) => false);
      }
    }
  }

  Future<String> initApp({
    @required UserViewModel userModel,
  }) async {
    await Hive.initFlutter();
    await userModel.readBio();
    await initializeDateFormatting(language, null);
    await PushNotificationService().initialise();
    // await FirebasePushConfig().initialise();
    final Box settings = await HiveService.getBox('settings');

    // final String url = await settings.get('url');
    // // var localUrl = url == 'default' || url == null ? endpointUrl : url;
    // final String localUrl = url == 'default' || url == null ? await endpointUrlAsync : url;
    // // localEndPoint = localUrl;
    try {
      print(endpointUrls[currentBuild]);
      // Kinfolk().initializeBaseVariables(localUrl, 'tsadv-XHTr0e8J', '0d2d8d1f1402d357f27aaf63cd5411224ea8e3c3a326172270de6e249ce6c54c');
      Kinfolk().initializeBaseVariables(endpointUrls[currentBuild], 'tsadv-XHTr0e8J', '0d2d8d1f1402d357f27aaf63cd5411224ea8e3c3a326172270de6e249ce6c54c');
    } catch (e, s) {
      developer.log('-->> Kinfolk().initializeBaseVariables exception: $e, $s');
    }
    // RestServices.getAppVersion();
    String savedLocale;
    String savedCountry;
    savedLocale = settings.get('locale');
    savedCountry = settings.get('country');
    final bool auth = settings.get('authorized') ?? false;
    userModel.auth = auth ?? false;
    final Locale locale2 = Locale(savedLocale ?? language, savedCountry ?? country);
    Get.updateLocale(locale2);
    locale = locale2;
    localeCountry = savedCountry;
    GlobalVariables.lang = localeCode;
    await S.load(locale2);
    await settings.close();
    return auth ? 'authorized' : 'not_authorized';
  }

  Future<void> initializeFlutterFire() async {
    // await Firebase.initializeApp();
    //
    // if (kTestingCrashlytics) {
    //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // } else {
    //   await FirebaseCrashlytics.instance
    //       .setCrashlyticsCollectionEnabled(!kDebugMode);
    // }
    //
    // Function originalOnError = FlutterError.onError;
    // FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    //   await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    //   originalOnError(errorDetails);
    // };
  }
}

class MainList {
  final String name;
  final String image;
  int count;
  List<MyRecognition> recognition;

  MainList({this.name, this.count, this.image, this.recognition});
}
