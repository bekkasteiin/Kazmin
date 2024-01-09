
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/service/socket.dart';
import 'package:kzm/core/service/translations.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/main.dart';
import 'package:kzm/pageviews/hr_requests/ovd/ovd_model.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/disability/disability_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/experience/experience_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/military/military_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_request_model.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_balance_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_rvd_model.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/collective_payment_model.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:kzm/viewmodels/bpm_requests/material_assistans_model.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/vacation_schedule_model.dart';
import 'package:kzm/viewmodels/company_vacation_model.dart';
import 'package:kzm/viewmodels/hr_requests.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:kzm/viewmodels/settings_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'viewmodels/recognition_model.dart';


const String fName = 'lib/app.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  Future<void> _initializeFlutterFire() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onSelectNotification);
    final Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError(errorDetails);
    };
  }

  Future<void> onSelectNotification(String payload) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(payload),
          content: Text('Payload : $payload'),
        );
      },
    );
  }

  void _initializeAppState() {
    _initializeFlutterFire();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<Map<Permission, PermissionStatus>> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification
    ].request();
    return statuses;
  }

  @override
  void initState() {
    super.initState();
    _initializeAppState();
    if(Platform.isIOS){
      requestPermission();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<void> didHaveMemoryPressure() async{
    final clear = await DefaultCacheManager().emptyCache();
    return clear;
  }


  List<ChangeNotifierProvider<dynamic>> _buildProviders() {
   return [
      ChangeNotifierProvider<KZMSocket>(create: (_) => KZMSocket(socketUrl: socketUrls[currentBuild])),
      ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
      ChangeNotifierProvider<AppSettingsModel>(create: (_) => AppSettingsModel()),
      ChangeNotifierProvider<SettingsModel>(create: (_) => SettingsModel()),
      ChangeNotifierProvider<RecognitionModel>(create: (_) => RecognitionModel()),
      ChangeNotifierProvider<AbsenceModel>(create: (BuildContext context) => AbsenceModel()),
      ChangeNotifierProvider<AbsenceRequestModel>(create: (BuildContext context) => AbsenceRequestModel()),
      ChangeNotifierProvider<ChangeAbsenceModel>(create: (BuildContext context) => ChangeAbsenceModel()),
      ChangeNotifierProvider<AbsenceRvdModel>(create: (BuildContext context) => AbsenceRvdModel()),
      ChangeNotifierProvider<LeavingVacationModel>(create: (BuildContext context) => LeavingVacationModel()),
      ChangeNotifierProvider<VacationScheduleRequestModel>(create: (BuildContext context) => VacationScheduleRequestModel()),
      ChangeNotifierProvider<AbsenceForRecallModel>(create: (BuildContext context) => AbsenceForRecallModel()),
      ChangeNotifierProvider<AbsenceBalanceModel>(create: (BuildContext context) => AbsenceBalanceModel()),
      ChangeNotifierProvider<ScheduleRequestModel>(create: (BuildContext context) => ScheduleRequestModel()),
      ChangeNotifierProvider<CertificateModel>(create: (BuildContext context) => CertificateModel()),
      ChangeNotifierProvider<LearningModel>(create: (BuildContext context) => LearningModel()),
      ChangeNotifierProvider<HrRequestModel>(create: (BuildContext context) => HrRequestModel()),
      ChangeNotifierProvider<MyTeamModel>(create: (BuildContext context) => MyTeamModel()),
      ChangeNotifierProvider<AbsenceNewRvdModel>(create: (BuildContext context) => AbsenceNewRvdModel()),
      ChangeNotifierProvider<CollectivePaymentModel>(create: (BuildContext context) => CollectivePaymentModel()),
      ChangeNotifierProvider<OvdModel>(create: (BuildContext context) => OvdModel()),
      ChangeNotifierProvider<PersonDocumentRequestModel>(create: (BuildContext context) => PersonDocumentRequestModel()),
      ChangeNotifierProvider<AddressRequestModel>(create: (BuildContext context) => AddressRequestModel()),
      ChangeNotifierProvider<PersonalDataRequestModel>(create: (BuildContext context) => PersonalDataRequestModel()),
      ChangeNotifierProvider<EducationRequestModel>(create: (BuildContext context) => EducationRequestModel()),
      ChangeNotifierProvider<PersonContactRequestModel>(create: (BuildContext context) => PersonContactRequestModel()),
      ChangeNotifierProvider<ExperienceRequestModel>(create: (BuildContext context) => ExperienceRequestModel()),
      ChangeNotifierProvider<QualificationRequestModel>(create: (BuildContext context) => QualificationRequestModel()),
      ChangeNotifierProvider<AwardDegreesRequestModel>(create: (BuildContext context) => AwardDegreesRequestModel()),
      ChangeNotifierProvider<DisabilityRequestModel>(create: (BuildContext context) => DisabilityRequestModel()),
      ChangeNotifierProvider<MilitaryRequestModel>(create: (BuildContext context) => MilitaryRequestModel()),
      ChangeNotifierProvider<PersonOtherInfoRequestModel>(create: (BuildContext context) => PersonOtherInfoRequestModel()),
      ChangeNotifierProvider<BeneficiaryRequestModel>(create: (BuildContext context) => BeneficiaryRequestModel()),
      ChangeNotifierProvider<MaterialAssistantViewModel>(create: (BuildContext context) => MaterialAssistantViewModel()),
      ChangeNotifierProvider<CompanyVacationModel>(create: (BuildContext context) => CompanyVacationModel()),
      ChangeNotifierProvider<NotificationModel>(create: (_) => NotificationModel()),
    ];
  }

  ThemeData _buildTheme(AppSettingsModel settings) {
    return ThemeData(
      textTheme: Styles.mainTxtTheme,
      primaryColor: Styles.appPrimaryColor,
      backgroundColor: Styles.appBackgroundColor,
      primarySwatch: Styles.appCorporateColor,
      appBarTheme: GetPlatform.isIOS
          ? const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      )
          : null,
    );
  }

  GetMaterialApp _buildMaterialApp(AppSettingsModel settings) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      defaultTransition: Transition.cupertino,
      popGesture: true,
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('kk', 'KZ'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      debugShowCheckedModeBanner: false,
      translations: KzmTranslate(),
      locale: settings.locale,
      theme: _buildTheme(settings),
      initialRoute: KzmPages.login,
      getPages: KzmPages.pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: _buildProviders(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return Consumer<AppSettingsModel>(
                builder: (BuildContext context, AppSettingsModel settings, _) {
                  return Consumer<UserViewModel>(
                    builder: (BuildContext context, UserViewModel counter, _) {
                      return FutureProvider<void>(
                        initialData: null,
                        create: (BuildContext context) => settings.initializeFlutterFire(),
                        child: Consumer<void>(
                          builder: (BuildContext context, void model, _) {
                            return ScrollConfiguration(
                              behavior: CustomScrollBehavior(),
                              child: ScreenUtilInit(
                                designSize: const Size(392.72727272727275, 737.4545454545455),
                                builder: (_, Widget w) => _buildMaterialApp(settings),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
