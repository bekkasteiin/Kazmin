import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:kzm/app.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/linked_user.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/person/person.dart' as Person;
import 'package:kzm/core/models/person/person_profile.dart';
import 'package:kzm/core/models/portal_menu_customization.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/models/user_info_by_iin.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/core/service/socket.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

const String fName = 'lib/viewmodels/user_model.dart';

class UserViewModel extends BaseModel {
  // final KzmProvider _api = Get.find<KzmProvider>();
  bool useBio;
  bool auth;
  UserInfo userInfo;
  UserInfoByIIN registerInfo;
  bool isRecoverScenario = false;
  PersonGroup person;
  final NumberFormat _cashFormat = NumberFormat.currency(locale: 'kk');
  PersonProfile personProfile;
  List<MyTeamNew> myTeam;
  List<PortalMenuCustomization> portalMenuCustomization;
  String resetPasswordLogin = '';

  // bool useBio = true;
  final CountdownTimerController timerController = CountdownTimerController(
    endTime: 0,
    onEnd: () {
      if (Get.currentRoute == KzmPages.codeVerify) Get.back();
    },
  );

  String _login = '';
  String _password = '';
  String _iinText = '';
  String _phoneText = '';
  String _verifyText = '';
  String _passwordText = '';
  String _repeatPasswordText = '';
  String pin1 = "";
  String pin2 = "";
  bool pinRepeat = false;
  String fcmToken;
  String pinVerify;

  bool pinInCorrect = false;

  String get login => _login;

  String get password => _password;

  String get iinText => _iinText;

  String get phoneText => _phoneText;

  String get verifyText => _verifyText;

  String get passwordText => _passwordText;

  String get repeatPasswordText => _repeatPasswordText;

  set login(String val) {
    _login = val;
    setBusy(false);
  }

  set password(String val) {
    _password = val;
    setBusy(false);
  }

  set iinText(String val) {
    _iinText = val;
    setBusy(false);
  }

  set phoneText(String val) {
    _phoneText = val;
    setBusy(false);
  }

  set verifyText(String val) {
    _verifyText = val;
    setBusy(false);
  }

  set passwordText(String val) {
    _passwordText = val;
    setBusy(false);
  }

  set repeatPasswordText(String val) {
    _repeatPasswordText = val;
    setBusy(false);
  }

  bool get isLoginButtonActive => login.isNotEmpty && password.isNotEmpty;

  bool get isNextButtonActive =>
      iinText.isNotEmpty &&
          phoneText.isNotEmpty &&
          iinText.length == Styles.iin.getMask().length &&
          phoneText.length == Styles.phone.getMask().length;

  bool get isVerifyButtonActive =>
      verifyText.length == Styles.verify.getMask().length;

  bool get isPasswordButtonActive =>
      passwordText.isNotEmpty &&
          passwordText == repeatPasswordText &&
          passwordText.length >= Styles.pwdLength &&
          passwordText.contains(Styles.regUpper) &&
          passwordText.contains(Styles.regLower) &&
          passwordText.contains(Styles.regDig) &&
          passwordText.contains(Styles.regSpec);

  String format(num val) {
    if (val == null) return '';
    return _cashFormat.format(val);
  }

  Future<bool> get isChief async {
    try {
      final Person.PersonGroup personGroup =
      await RestServices.getPersonGroupForAssignment()
      as Person.PersonGroup;
      final String parentPositionGroupId =
          personGroup.currentAssignment?.positionGroup?.id;
      myTeam = await RestServices.getChildrenForTeamService(
        parentPositionGroupId: parentPositionGroupId,
      );
      myTeam ??= <MyTeamNew>[];
      return myTeam.isNotEmpty;
    } catch (_) {
      myTeam = <MyTeamNew>[];
      return false;
    }
  }

  void setPin() async {
    var box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('info'));
    info.pin = pin1;
    await box.put('infoPin', userInfoToJson(info));
    await box.put('authorized', true);
    final List<BiometricType> availableBiometrics =
    await LocalAuthentication().getAvailableBiometrics();
    if ((useBio == null) &&
        (availableBiometrics.contains(BiometricType.face) ||
            availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.weak) ||
            availableBiometrics.contains(BiometricType.strong))) {
      FocusManager.instance.primaryFocus?.unfocus();
      showDialog(
        context: navigatorKey.currentContext,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(S.current.attention),
            content: Text(S.current.useBioAuth),
            actions: <TextButton>[
              TextButton(
                child: Text(S.current.no),
                onPressed: () async {
                  await box.put('useBio', false);
                  await box.close();
                  Get.back();

                },
              ),
              TextButton(
                child: Text(S.current.yes),
                onPressed: () async {
                  if (await authenticateBio()) {
                    await box.put('useBio', true);
                    await box.close();
                    Get.back();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> get pin async {
    Box box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('infoPin'));
    await box.close();
    pinVerify = info.pin;
    return pinVerify;
  }

  void regFromSaved(BuildContext context, KZMSocket socket) async {
    var box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('info'));
    login = info.login;
    password = info.password;
    await loginSuccess(fromPin: true, socket: socket, context: context);
    await box.close();
  }

  Future<PersonGroup> get personInfo async {
    // person ??= await RestServices.getPersonGroupInfo() as PersonGroup;
    person = await RestServices.getPersonGroupInfo() as PersonGroup;
    // if (personProfile == null) await getProfileByPersonGroupId();
    await getProfileByPersonGroupId();
    return person;
  }

  Future<PersonProfile> getProfileByPersonGroupId() async {
    final Box settings = await HiveUtils.getSettingsBox();
    final String pgId = settings.get('pgId') as String;
    // personProfile ??= await RestServices.getPersonProfileByPersonGroupId(pgId: pgId) as PersonProfile;
    personProfile =
    await RestServices.getPersonProfileByPersonGroupId(pgId: pgId);
    return personProfile;
  }

  Future<String> authenticateUser(
      {@required String login, @required String password}) async {
    final dynamic client =
    await Kinfolk().getToken(login.trim(), password.trim());
    if (client is String) {
      String text;
      switch (client) {
        case 'ACCESS_ERROR':
          text = S.current.incorrectness;
          break;
        case 'CONNECTION_TIME_OUT':
          text = S.current.timeout;
          break;
        default:
          text = client;
      }
      // await BaseModel.showAttention(middleText: text);
      return text;
    } else {
      userInfo = UserInfo(login: login.trim(), password: password.trim());
      return null;
    }
  }

  bool get registerInfoIINPhoneEmpty => iinText.isEmpty || phoneText.isEmpty;

  Future<bool> get registerInfoIsNull async {
    if (registerInfo == null) {
      await BaseModel.showAttention(middleText: S.current.exception);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsEmpty async {
    if (registerInfo.isEmpty) {
      await BaseModel.showAttention(middleText: S.current.signUpDataEmpty);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsLinkedUserExists async {
    if ((registerInfo.linkedUser?.login ?? '').isNotEmpty &&
        registerInfo.linkedUser.isActive) {
      await BaseModel.showAttention(
          middleText: S.current.signUpLinkedUserExists);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsLinkedUserNotExists async {
    if ((registerInfo.linkedUser.login ?? '').isEmpty) {
      await BaseModel.showAttention(
          middleText: S.current.signUpLinkedUserNotExists);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsLinkedUserLocked async {
    if ((registerInfo.linkedUser?.login ?? '').isNotEmpty &&
        !registerInfo.linkedUser.isActive) {
      await BaseModel.showAttention(middleText: S.current.signUpIINLocked);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsIncorrectPhone async {
    if (registerInfo.mobilePhone.isEmpty ||
        Styles.phone.unmaskText(registerInfo.mobilePhone) !=
            Styles.phone.unmaskText(phoneText)) {
      await BaseModel.showAttention(middleText: S.current.signUpIncorrectPhone);
      return true;
    }
    return false;
  }

  Future<bool> get registerInfoIsSmsSendError async {
    if (!registerInfo.smsSent) {
      await BaseModel.showAttention(
          middleText: S.current.signUpSendVerificationCodeError);
      return true;
    }
    return false;
  }

  Future<int> getSMSTimeout() async => RestServices().getSmsCodeTimeoutSec();

  Future<bool> signUpUser() async {
    if (registerInfoIINPhoneEmpty) return false;

    setBusy(true);
    registerInfo = null;
    registerInfo =
    await RestServices().getPersonByIIN(iin: iinText, signUser: true);

    setBusy(false);

    if (await registerInfoIsNull || await registerInfoIsEmpty) return false;
    KzmLinkedUser regUser = await RestServices().getUserByIIN(iin: iinText);
    if (regUser.login != null && regUser.isActive == true) {
      BaseModel.showAttention(middleText: S.current.signUpLinkedUserExists);
    } else if (regUser.login != null && regUser.isActive == false) {
      BaseModel.showAttention(middleText: S.current.signUpIINLocked);
    } else if (regUser.login == null) {
      setBusy(true);
      registerInfo.smsSent = await RestServices().sendSms(
        personID: registerInfo.personID,
        mobile: phoneText,
      );
      setBusy(false);
      if (!(await registerInfoIsSmsSendError)) return true;
      return false;
    }

  }

  Future<bool> recoverPassword() async {
    if (registerInfoIINPhoneEmpty) return false;
    setBusy(true);
    registerInfo = await RestServices().getPersonByIIN(iin: iinText);
    setBusy(false);
    if (await registerInfoIsNull || await registerInfoIsEmpty) return false;
    KzmLinkedUser regUser = await RestServices().getUserByIIN(iin: iinText);
    print(regUser.login);
    if (regUser.login != null) {
      resetPasswordLogin = regUser.login;
      setBusy(true);
      registerInfo.smsSent = await RestServices().sendSms(
        personID: registerInfo.personID,
        mobile: registerInfo.mobilePhone,
      );
      setBusy(false);
      if (!(await registerInfoIsSmsSendError)) return true;
      return false;
    } else if (regUser.login == null) {
      await BaseModel.showAttention(middleText: S.current.signUpDataEmpty);
    }
  }

  Future<bool> verifyCode() async {
    if (verifyText.isEmpty) return false;

    setBusy(true);
    final bool _result = await RestServices().checkVerificationCode(
      personID: registerInfo.personID,
      verificationCode: verifyText,
    );
    setBusy(false);

    if (!_result) {
      await BaseModel.showAttention(
          middleText: S.current.signUpVerifyIncorrectCode);
      return false;
    }

    return _result;
  }

  Future<String> createUser() async {
    if (passwordText.isEmpty) return '';

    setBusy(true);
    final String _result = await RestServices()
        .createUser(personID: registerInfo.personID, password: passwordText);
    setBusy(false);

    if ((_result ?? '').isNotEmpty) return _result;

    await BaseModel.showAttention(
        middleText: S.current.signUpSavePasswordError);

    return _result;
  }

  Future<bool> updatePassword() async {
    if (passwordText.isEmpty) return false;

    setBusy(true);
    final bool _result = await RestServices().updatePassword(
        personID: registerInfo.personID, password: passwordText);
    setBusy(false);
    if (_result ?? false) return true;

    await BaseModel.showAttention(
        middleText: S.current.signUpSavePasswordError);

    return false;
  }

  // Future<bool> authSilent(AppSettingsModel appSettingsModel, UserViewModel userModel, BuildContext context) async {
  //   final UserInfo info = await HiveUtils.getUserInfo();
  //   await RestServices.getPersonGroupInfo();
  //   final dynamic client = await Kinfolk().getToken(info.login.trim(), info.password.trim());
  //   // log('-->> $fName, authSilent ->> client: $client');
  //   if (client is String) {
  //     String text;
  //     switch (client) {
  //       case 'ACCESS_ERROR':
  //         // text = S.of(Get.overlayContext).incorrectness;
  //         text = S.current.incorrectness;
  //         await Get.defaultDialog(
  //           // title: S.of(Get.overlayContext).attention,
  //           title: S.current.attention,
  //           middleText: text,
  //           textConfirm: 'Ok',
  //           confirmTextColor: Colors.white,
  //           onConfirm: () async => appSettingsModel.logout(userModel, context),
  //         );
  //         break;
  //       case 'CONNECTION_TIME_OUT':
  //         // text = S.of(Get.overlayContext).timeout;
  //         text = S.current.timeout;
  //         await Get.defaultDialog(
  //           // title: S.of(Get.overlayContext).attention,
  //           title: S.current.attention,
  //           middleText: text,
  //         );
  //         break;
  //       default:
  //         // text = client;
  //         text = S.current.serverError;
  //         await Get.defaultDialog(
  //           // title: S.of(Get.overlayContext).attention,
  //           title: S.current.attention,
  //           middleText: text,
  //         );
  //     }
  //   }
  //   final UserInfo newInfo = await RestServices.getUserInfo();
  //   if (newInfo != null) {
  //     userInfo = newInfo;
  //     newInfo.password = info.password;
  //     newInfo.login ??= info.login;
  //     // await RestServices.loginWithEmail(
  //     //     email: newInfo.email, password: newInfo.password);
  //     await HiveUtils.saveUserInfo(newInfo);
  //   } else {
  //     await HiveUtils.saveUserInfo(userInfo);
  //   }
  // }

  Future<bool> authenticateBio() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool isAuthorized = false;

    Iterable<AuthMessages> msg = <AuthMessages>[
      IOSAuthMessages(
        cancelButton: S.current.cancel,
      ),
      AndroidAuthMessages(
        biometricHint: '',
        signInTitle: S.current.useFinger,
        cancelButton: S.current.cancel,
      ),
    ];

    try {
      isAuthorized = await _localAuthentication.authenticate(
        localizedReason: S.current.authenticateBio,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: msg,
      );
    } on PlatformException catch (e) {
      log('-->> $fName, authenticateBio ->> PlatformException: ${e.toString()}');
      return false;
    }
    return isAuthorized;
  }

  Future<void> readBio() async {
    Future<Duration>.delayed(const Duration(seconds: 5));
    final Box<dynamic> box = await HiveService.getBox('settings');
    useBio = box.get('useBio') as bool;
  }

  Future<void> authSilent(AppSettingsModel appSettingsModel,
      UserViewModel userModel, BuildContext context) async {
    final UserInfo info = await HiveUtils.getUserInfo();
    final dynamic client =
    await Kinfolk().getToken(info.login.trim(), info.password.trim());
    if (client is String) {
      switch (client) {
        case 'ACCESS_ERROR':
          await Get.defaultDialog(
            title: S.current.attention,
            middleText: S.current.incorrectness,
            textConfirm: 'Ok',
            confirmTextColor: Colors.white,
            onConfirm: () async => appSettingsModel.logout(userViewModel: userModel, context: context),
          );
          break;
        case 'CONNECTION_TIME_OUT':
          await BaseModel.showAttention(middleText: S.current.timeout);
          break;
        default:
          await BaseModel.showAttention(middleText: S.current.serverError);
      }
    }
    final UserInfo newInfo = await RestServices.getUserInfo();
    if (newInfo != null) {
      userInfo = newInfo;
      newInfo.password = info.password;
      newInfo.login ??= info.login;
      await HiveUtils.saveUserInfo(newInfo);
    } else {
      await HiveUtils.saveUserInfo(userInfo);
    }
    await saveFirebaseDeviceToken();
    setBusy(false);
    await Get.offNamedUntil('/init', ModalRoute.withName('/'));
  }

  Future<void> saveFirebaseDeviceToken() async {
    // return;
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // if ((fcmToken == null) && (userInfo?.login != null)) {
    fcmToken = await messaging.getToken();
    String deviceId = '';
    String deviceInfo = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo deviceData =
        await deviceInfoPlugin.androidInfo;
        deviceId = deviceData.androidId;
        deviceInfo = '${deviceData.brand}:${deviceData.model}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo deviceData = await deviceInfoPlugin.iosInfo;
        deviceId = deviceData.identifierForVendor;
        deviceInfo = 'apple:${deviceData.model}';
      }
      final dynamic result = await Kinfolk.getSingleModelRest(
        type: Types.services,
        serviceName: 'mobile_MobileRestService',
        methodName: 'saveFcmTokenBySessionUser',
        body: jsonEncode({
          'token': fcmToken,
          'deviceId': deviceId,
          'deviceInfo': deviceInfo,
        }),
        fromMap: (Map<String, dynamic> val) {},
      );
    } catch (e) {
      log('-->> $fName, getFirebaseDeviceToken ->> catch error: ${e.toString()}');
    }
    // }
  }

  Future<void> loginSuccess({
    bool fromPin = false,
    @required KZMSocket socket,
    @required BuildContext context,
  }) async {
    setBusy(true);
      final String auth =
      await authenticateUser(login: login, password: password);
      if (auth != null) {
        setBusy(false);
        await BaseModel.showAttention(middleText: S.current.incorrectness);
        return;
      }
      final dynamic box = await HiveService.getBox('settings');
      final UserInfo info = await RestServices.getUserInfo();
      if (info != null) {
        info.password = userInfo.password;
        info.login ??= userInfo.login;
        await box.put('info', userInfoToJson(info));
        userInfo = info;
      } else {
        await box.put('info', userInfoToJson(userInfo));
      }
      socket.activateSocket(userId: info.id);
    await RestServices.getPersonGroupInfo();
    await getMenu();
    await isChief;
    await saveFirebaseDeviceToken();
    log('-->> $fName, loginSuccess ->> currentBuild: $currentBuild');
    setBusy(false);
    if(fromPin){
      await Get.offNamedUntil('/init', ModalRoute.withName('/'));
    }else{
      await Get.dialog(
        AlertDialog(
          title: Text(S().pinCreate),
          content: Text(S().wantPin),
          actions: [
            GFButton(
                size: 32,
                text: S.current.no,
                textStyle: generalFontStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Styles.appDarkBlueColor),
                color: Styles.appDarkBlueColor,
                type: GFButtonType.outline,
                onPressed: () async {
                  await Get.offNamedUntil('/init', ModalRoute.withName('/'));
                }),
            GFButton(
              size: 32,
              text: S().yes,
              textStyle: generalFontStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              color: Styles.appDarkBlueColor,
              onPressed: () {
                Get.offAllNamed(KzmPages.pin_create);
              },
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  Future<List<PortalMenuCustomization>> getMenu() async {
    // ignore: join_return_with_assignment
    portalMenuCustomization = await RestServices.getPortalMenu();
    return portalMenuCustomization;
  }
}
