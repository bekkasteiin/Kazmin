// ignore_for_file: always_specify_types, avoid_dynamic_calls

import 'dart:convert';
import 'dart:core';
import 'dart:developer';

// import 'dart:html';
import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/absence/absence_balance.dart';
import 'package:kzm/core/models/absence/absence_for_recall.dart';
import 'package:kzm/core/models/absence/all_absence.dart';
import 'package:kzm/core/models/absence/change_days_request.dart';
import 'package:kzm/core/models/absence/leaving_vacation.dart';
import 'package:kzm/core/models/absence/validate_model.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';
import 'package:kzm/core/models/advert_model.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/assignment/employee_category.dart';
import 'package:kzm/core/models/book/book.dart';
import 'package:kzm/core/models/book/book_reviews_request.dart';
import 'package:kzm/core/models/book/dic_book_category.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/ext_task_data.dart';
import 'package:kzm/core/models/bpm/form_data.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/bpm/process_instance_data.dart';
import 'package:kzm/core/models/certificate/certificate.dart';
import 'package:kzm/core/models/collective_payment/collective_model.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/company_vacation/company_vacation.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/models/course_schedule.dart';

// import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/courses/answered_test.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/models/courses/course_category.dart';
import 'package:kzm/core/models/courses/course_notes.dart';
import 'package:kzm/core/models/courses/learned_course.dart';
import 'package:kzm/core/models/courses/learnig_history.dart';
import 'package:kzm/core/models/courses/test.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/dms/contract_assistance.dart';
import 'package:kzm/core/models/dms/insurance_contract.dart';
import 'package:kzm/core/models/dms/insured_person.dart';
import 'package:kzm/core/models/documents_familitarization.dart';
import 'package:kzm/core/models/entities/base_assignment_ext.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/entities/report_report_template.dart';
import 'package:kzm/core/models/entities/tsadv_learning_feedback_template.dart';
import 'package:kzm/core/models/entities/tsadv_portal_feedback.dart';
import 'package:kzm/core/models/entities/tsadv_tsadv_report.dart';
import 'package:kzm/core/models/kpi/assigned_goal.dart';
import 'package:kzm/core/models/kpi/my_kpi.dart';
import 'package:kzm/core/models/learning_request.dart';
import 'package:kzm/core/models/linked_user.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/models/notification/notification.dart';
import 'package:kzm/core/models/person/address.dart';
import 'package:kzm/core/models/person/person.dart' as in_person;
import 'package:kzm/core/models/person/person_profile.dart';
import 'package:kzm/core/models/person_assessment_form.dart';
import 'package:kzm/core/models/person_assessments_response.dart';
import 'package:kzm/core/models/person_learning_contract.dart';
import 'package:kzm/core/models/person_payslip.dart';
import 'package:kzm/core/models/portal_menu_customization.dart';
import 'package:kzm/core/models/position/position_harmful_condition.dart';
import 'package:kzm/core/models/proc_instance_v.dart';
import 'package:kzm/core/models/question.dart';
import 'package:kzm/core/models/recognition/my_recognition.dart';
import 'package:kzm/core/models/rvd/absence_rvd_request.dart';
import 'package:kzm/core/models/rvd/assignment_schedule.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';

// import 'package:kzm/core/models/rvd/absence_rvd_request.dart';
// import 'package:kzm/core/models/rvd/assignment_schedule.dart';
// import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';
import 'package:kzm/core/models/slider/slide.dart';
import 'package:kzm/core/models/sur_change_request.dart';
import 'package:kzm/core/models/trainin_calendar.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/models/user_info_by_iin.dart';
import 'package:kzm/core/models/util_models.dart';
import 'package:kzm/core/models/vacation_schedule/vacation_schedule_request.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/firebase/AuthenticationService.dart';

// import 'package:kinfolk/global_variables.dart';
// import 'package:kinfolk/kinfolk.dart';
// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
// import 'package:kinfolk/service/auth.dart';
// import 'package:kinfolk/service/utils.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/service/auth.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
import 'package:kzm/core/service/provider/provider.dart';
import 'package:kzm/core/service/provider/result_model.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_request.dart';

// import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:kzm/core/service/oauth2/oauth2.dart' as oauth2;
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_person.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:version/version.dart';

import '../../pageviews/hr_requests/ovd/ovd_request.dart';

const String fName = 'lib/core/service/rest_service.dart';

class RestServices {
  final KzmProvider _api = Get.find<KzmProvider>();

  static String mobileService() => 'crm_MobileService';
  static const String fName = 'lib/core/service/rest_service.dart';

  // static final fa.FirebaseAuth _firebaseAuth = fa.FirebaseAuth.instance;

  // static Future loginWithEmail({
  //   @required String email,
  //   @required String password,
  // }) async {
  //   try {
  //     print('loginWithEmail');
  //     print(password);
  //     print(email);
  //     await FirebasePushConfig().sendDataToServer();
  //
  //     var user = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return true;
  //   } catch (e) {
  //     print(e.message);
  //     return e.message;
  //   }
  // }

  Future<List<BasePersonExt>> getPersonExt({
    String personGroupId,
    DateTime startDate,
    DateTime endDate,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/base\$PersonExt/search',
      query: <String, String>{
        'view': 'person-edit',
        'filter': json.encode(<String, dynamic>{
          'conditions': <Map<String, String>>[
            <String, String>{
              'property': 'group.id',
              'operator': '=',
              'value': personGroupId ?? (await pgID)
            },
            <String, String>{
              'property': 'startDate',
              'operator': '<=',
              'value': formatFullRestNotMilSec(startDate ?? DateTime.now())
            },
            <String, String>{
              'property': 'endDate',
              'operator': '>=',
              'value': formatFullRestNotMilSec(endDate ?? DateTime.now())
            }
          ]
        }),
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>)
            .map(
                (dynamic e) => BasePersonExt.fromMap(e as Map<String, dynamic>))
            .toList();
      },
    );

    return (resp.result ?? <BasePersonExt>[]) as List<BasePersonExt>;
  }

  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
  }

  // ignore: missing_return
  static Future<bool> checkConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com').timeout(
        const Duration(milliseconds: 1000),
      );
      /*if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }*/
      // log('-->> $fName, checkConnection \nBEG Trying to getUserInfo');
      try {
        final UserInfo x = await getUserInfo();
      } on Exception {
        final UserInfo info = await HiveUtils.getUserInfo();
        await Kinfolk().getToken(info.login.trim(), info.password.trim());
        // return false;
      }
      // log('-->> $fName, checkConnection \nEND Trying to getUserInfo');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e, s) {
      log('-->> $fName, checkConnection -->> SocketException',
          error: e, stackTrace: s);
      return false;
    } on Exception catch (e, s) {
      log('-->> $fName, checkConnection -->> Exception',
          error: e, stackTrace: s);
      return false;
    }
  }

  static Future<UserInfo> getUserInfo() async {
    final oauth2.Client info = await Kinfolk.getClient();
    final String url = '${GlobalVariables.urlEndPoint}/rest/v2/userInfo';
    final http.Response response = await info.get(url);
    final String body = response.body;
    if (body == null || body.isEmpty) {
      return null;
    }
    final UserInfo user = userInfoFromJson(body);
    return user;
  }

  Future<bool> sendSms(
      {@required String personID, @required String mobile}) async {
    const bool _result = false;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/sendSms',
      body: <String, dynamic>{
        'person': personID,
        'mobile': mobile,
      },
      map: ({dynamic data}) => null,
    );
    log('-->> $fName, sendSms ->> resp: ${resp.bodyString}');
    if ((resp.isOk) && ((resp.bodyString ?? '').toUpperCase() == 'TRUE'))
      return true;

    return _result;
  }

  Future<int> getSmsCodeTimeoutSec() async {
    const int _result = signUpVerifySeconds;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/getSmsCodeTimeoutSec',
      body: <String, dynamic>{},
      map: ({dynamic data}) => null,
    );
    if (resp.isOk) {
      if ((resp.bodyString ?? signUpVerifySeconds.toString()).isNotEmpty) {
        try {
          return int.parse(resp.bodyString);
        } catch (e /*, s*/) {
          return signUpVerifySeconds;
        }
      }
    }
    return _result;
  }

  Future<KzmLinkedUser> getUserByIIN({@required String iin}) async {
    KzmLinkedUser _result = KzmLinkedUser(login: null, isActive: false);
    var resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/getUserByIin',
      body: <String, dynamic>{
        'iin': iin,
      },
      map: ({dynamic data}) {
        KzmLinkedUser.fromJSON(data as Map<String, dynamic>);
      },
    );
    if (resp.statusCode == 200) {
      var jsonString = json.decode(resp.bodyString);
      var response = KzmLinkedUser.fromJSON(jsonString as Map<String, dynamic>);
      return response;
    } else {
      return _result;
    }
  }

  Future<UserInfoByIIN> getPersonByIIN(
      {@required String iin, bool signUser = false}) async {
    print(iin);
    UserInfoByIIN _result = UserInfoByIIN(personID: '', mobilePhone: '');
    GlobalVariables.token = null;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/getPersonByIin',
      body: <String, dynamic>{
        'iin': iin,
      },
      map: ({dynamic data}) {
        return UserInfoByIIN.fromJSON(data as Map<String, dynamic>);
      },
    );
    if ((resp.statusCode == 200) && (resp.result != null)) {
      _result = resp.result as UserInfoByIIN;
      return _result;
    }
    return _result;
  }

  Future<bool> checkVerificationCode(
      {@required String personID, @required String verificationCode}) async {
    const bool _result = false;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/testSms',
      body: <String, dynamic>{
        'person': personID,
        'code': verificationCode,
      },
      map: ({dynamic data}) => null,
    );

    if ((resp.isOk) && ((resp.bodyString ?? '').toUpperCase() == 'TRUE'))
      return true;
    return _result;
  }

  Future<String> createUser(
      {@required String personID, @required String password}) async {
    const String _result = '';
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/createUser',
      body: <String, dynamic>{
        'person': personID,
        'password': password,
      },
      map: ({dynamic data}) => null,
    );

    if (resp.isOk) return resp.bodyString ?? '';

    return _result;
  }

  Future<bool> updatePassword(
      {@required String personID, @required String password}) async {
    KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_UserRegistrationService/updatePassword',
      body: <String, dynamic>{'person': personID, 'password': password},
      map: ({dynamic data}) => null,
    );
    var ss = (resp.isOk) && ((resp.bodyString ?? '').toUpperCase() == 'TRUE');
    print(ss);
    return ss;
  }

  static auth(String email, String password) async {
    print(email);
    print(password);
    var res = await AuthenticationService()
        .loginWithEmail(email: email.trim(), password: password.trim());
    if (res is bool) {
      if (res) {
        print('SUCCESS');
        return true;
      } else {
        print('NOT SUCCESS');
        return false;
      }
    } else {
      print(res);
      return false;
    }
  }

  static sendToken(String token) async {
    var body = '''
    {
      "token":"$token"
    }
    ''';

    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: 'setUserPhoneToken',
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static Future<bool> updateEntity(
      {@required String entityName,
      @required String entityId,
      @required entity}) async {
    if (entity.id == null) {
      final Box box = await HiveService.getBox('settings');
      final json = await box.get('info');
      final UserInfo info = userInfoFromJson(json);
      final answer = await Kinfolk.getSingleModelRest(
        serviceName: entityName,
        methodName: '',
        type: Types.entities,
        body: entity
            .toJson()
            .toString()
            .replaceAll('"id":null,', '"createdBy":"${info.login}",')
            .replaceAll('"createdBy":null,', ''),
        fromMap: (Map<String, dynamic> val) => val,
      );
      return answer['error'] == null;
    }

    final oauth2.Client client = await Kinfolk.getClient();
    final String url =
        Kinfolk.createRestUrl(entityName, entityId, Types.entities);
    final http.Response response = await client.put(url, body: entity.toJson());
    // log('-->> $fName, updateEntity ->> put: \nurl=$url\nbody=${entity.toJson()}\ntatusCode:${response.statusCode}\nresponse:${response.body}');
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> updateAssesmentDetailStatus(
      {@required String id, @required String statusId}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
        "id": "$id",
        "assessmentStatus" : {
        "id": "$statusId"
        }
      }
      ''';
    final String url = Kinfolk.createRestUrl(
        'tsadv\$AssessmentParticipant', id, Types.entities);
    final http.Response response = await client.put(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> updateAssesmentDetail(
      {@required String id, @required String scaleLavelId}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
      "id": "$id",
      "scaleLevel": {
          "id": "$scaleLavelId"
        }
      }
      ''';
    final String url =
        Kinfolk.createRestUrl('tsadv_AssessmentDetail', id, Types.entities);
    final http.Response response = await client.put(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> updateAssessment(String assessmentId) async {
    // return true;
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
      "assessmentId": "$assessmentId"
      }
      ''';
    final String url = Kinfolk.createRestUrl(
      'tsadv_AssessmentParticipantAssessmentsBrowseService',
      'updateAssessment',
      Types.services,
    );
    final http.Response response = await client.post(
      url,
      body: body,
    );

    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> updateAssessmentComment({
    @required String id,
    String comment,
  }) async {
    // print(id);
    // return true;
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
      "id": "$id",
      "comment":"${comment ?? ''}"
      }
      ''';
    final String url =
        Kinfolk.createRestUrl('tsadv\$Assessment', id, Types.entities);
    final http.Response response = await client.put(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> updateAssesmentCompetence(
      {@required String id, @required bool requireted, String comment}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
      "id": "$id",
      "requiredDevelopmet": $requireted
      }
      ''';
    final String url = Kinfolk.createRestUrl(
        'tsadv\$AssessmentCompetence', id, Types.entities);
    final http.Response response = await client.put(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future<bool> deleteEntity(
      {@required String entityName, @required String entityId}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String url =
        Kinfolk.createRestUrl(entityName, entityId, Types.entities);
    final http.Response response = await client.delete(url);
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
        response.body.contains('Server error') ||
        response.body.contains('MetaClass null not found'));
  }

  static Future<String> createAndReturnId({
    @required String entityName,
    entity,
    entityMap,
  }) async {
    try{
      final Box box = await HiveService.getBox('settings');
      final json = await box.get('info');
      final UserInfo info = userInfoFromJson(json);
      print(entity.toJson());
      final answer = await Kinfolk.getSingleModelRest(
        serviceName: entityName,
        methodName: '',
        type: Types.entities,
        body: (entity?.toJson() ?? jsonEncode(entityMap))
            .toString()
            .replaceAll('"id": null,', '"createdBy":"${info.login}",'),
        fromMap: (Map<String, dynamic> val) => val,
      );
      return answer['id'] as String;
    }catch(e){
      print(e);
    }

  }

  static Future<bool> updateInsuredPerson(
      {@required String id, @required dynamic entity}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String url =
        Kinfolk.createRestUrl('kzm_InsuredPersonKzm', id, Types.entities);
    final http.Response response = await client.put(url, body: entity.toJson());
    print(response.body);
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 200;
  }

  static Future createAndReturnIds(
      {@required String entityName, entity, entityMap}) async {
    // id must be null
    final Box box = await HiveService.getBox('settings');
    final json = await box.get('info');
    final UserInfo info = userInfoFromJson(json);
    final answer = await Kinfolk.getSingleModelRest(
      serviceName: entityName,
      methodName: '',
      type: Types.entities,
      body: (entity?.toJson() ?? jsonEncode(entityMap)).toString(),
      fromMap: (Map<String, dynamic> val) => val,
    );
    print('answer: $answer');
    return answer['id'];
  }

  static Future<String> getLocalPath() async {
    String dir = '';
    final Directory appDocDir = await getExternalStorageDirectory();
    dir = appDocDir.path;

    final String localPath = '$dir${Platform.pathSeparator}Download';
    final Directory savedDir = Directory(localPath);
    final bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    return localPath;
  }

  // // static Future<String> downloadFileWithFlutterDownloader(String url, String fileName) async {
  // //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  // //
  // //   final String taskId = await FlutterDownloader.enqueue(
  // //     url: url,
  // //     savedDir: appDocDir.toString(),
  // //     showNotification: true,
  // //     openFileFromNotification: true,
  // //     fileName: '$fileName.pdf',
  // //   );
  //
  //   return taskId;
  // }

  static Future<String> downloadFile(String url, String fileName) async {
    final HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    String dir = '';
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    dir = appDocDir.path;
    filePath = '$dir/$fileName';

    // if (await File(filePath).exists()) {
    //   return filePath;
    // }

    try {
      myUrl = url;
      final HttpClientRequest request =
          await httpClient.getUrl(Uri.parse(myUrl));
      final HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final Uint8List bytes =
            await consolidateHttpClientResponseBytes(response);
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        throw Exception('Error code: ${response.statusCode}');
      }
    } catch (ex) {
      GlobalNavigator().errorBar(title:ex.message.toString());
      throw Exception('Can not fetch url');
    }
    print('complete');
    return filePath;
  }

  static Future<void> getAppVersion() async {
    print('ss');
    if (!(await checkConnection())) {
      return;
    }
    final String url = Kinfolk.createRestUrl(
        'mobile_MobileRestService', 'getAppVersions', Types.services);
    final http.Response response =
        await http.get(url, headers: Kinfolk.appJsonHeader);
    print(currentVersion);

    final Map versionsMap = jsonDecode(response.body) as Map;
    final Version latestVersion = Version.parse(versionsMap['latest']);
    final Version minimalVersion = Version.parse(versionsMap['minimal']);

    if (currentVersion < minimalVersion) {
      await Get.offAndToNamed('/update');
    }

    if (currentVersion < latestVersion) {
      // ignore: unawaited_futures
      Get.dialog(
        CupertinoAlertDialog(
          title: Text(S.current.attention),
          content: Text(S.current.updateIsAvailable),
        ),
      );
    }
  }

  static Future absenceValidation(
      {@required String personGroupId,
      @required String absenceTypeId,
      @required DateTime startDate,
      @required DateTime endDate,
      @required int duration}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final String body = '''{
        "personGroupId":"$personGroupId",
        "absenceTypeId":"$absenceTypeId",
        "startDate": "$startDate",
        "endDate": "$endDate",
        "duration": $duration
    } ''';

    final map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_AbsenceService',
      type: Types.services,
      methodName: 'checkAbsenceRequest',
      body: body,
      fromMap: (Map<String, dynamic> val) => ValidateModel.fromJson(val),
    );
    return map.cast<ValidateModel>();
  }

  static Future dmsValidation({@required String personGroupId}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final String body = '''{
        "personGroupId":"$personGroupId"
    } ''';
    try {
      final map = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_DocumentService',
        type: Types.services,
        methodName: 'getContractListByPerson',
        body: body,
        fromMap: (Map<String, dynamic> val) => ValidateModel.fromJson(val),
      );
      return map.cast<ValidateModel>();
    } catch (e) {
      GlobalNavigator().errorBar(title: 'Нет доступных договоров страхования');
    }
  }

  static Future<BaseResult> changePassword(
      String oldPass, String newPass) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final String body = '''{
        "oldPassword":"$oldPass",
        "newPassword":"$newPass"
    } ''';

    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_LmsService',
      fromMap: (Map<String, dynamic> val) => BaseResult.fromMap(val),
      type: Types.services,
      methodName: 'changePassword',
      body: body,
    );
    return map;
  }

  static Future getLanguages() async {
    final map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicLanguage',
      fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    );
    return map.cast<AbstractDictionary>();
  }

  static Future<String> getPersonGroupId(UserInfo UserInfo)async{
    try{
      final pgMap = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv_EmployeeService',
        fromMap: (Map<String, dynamic> val) => val,
        type: Types.services,
        methodName: 'personGroupInfo',
        body: '''
        { "userId":${UserInfo.id} }
        ''',
      );

      final pgId = pgMap['groupId'];
      return pgId.toString();
    }catch(e){
      print(e);
      return null;

    }
  }

  static Future getPersonGroupInfo() async {
    // var connection = await checkConnection();
    // if (!connection) {
    //   return null;
    // }
    try {
      if (!await checkConnection()) return null;

      final UserInfo userInfo = await HiveUtils.getUserInfo();

      final pgMap = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv_EmployeeService',
        fromMap: (Map<String, dynamic> val) => val,
        type: Types.services,
        methodName: 'personGroupInfo',
        body: '''
        { "userId":${userInfo.id} }
        ''',
      );

      final pgId = pgMap['groupId'];
      // log('-->> $fName, getPersonGroupInfo ->> pgId: $pgId');

      final Box settings = await HiveUtils.getSettingsBox();
      settings.put('pgId', pgId);

      final personInfo = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'base\$PersonGroupExt',
        fromMap: (Map<String, dynamic> val) => PersonGroup.fromMap(val),
        type: Types.queries,
        methodName: 'myProfileFull',
        body: '''
        {
        "userId":"$pgId"
        }
        ''',
      );
      return personInfo.first;
    } catch (e) {
      log('-->> $fName, getPersonGroupInfo ->> exception: $e');
    }
    return null;
  }

  static Future<List<AbsenceRequest>> getMyAbsences() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.absence,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      type: Types.queries,
      methodName: 'myAbsences',
      body: '''
        {
        "session\$userPersonGroupId":"${settings.get('pgId')}"
        }
        ''',
    ) as List;

    // var pgId = pgMap.first["id"];
    return map.cast<AbsenceRequest>();
  }

  static Future<List<Absence>> getAbsencesByPgId(String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.absence,
      fromMap: (Map<String, dynamic> val) => Absence.fromMap(val),
      type: Types.queries,
      methodName: 'myAbsences',
      body: '''
        {
        "session\$userPersonGroupId":"$id"
        }
        ''',
    ) as List;

    // var pgId = pgMap.first["id"];
    return map.cast<Absence>();
  }

  static Future<FileDescriptor> getFileDescriptorById(String fileId) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    List map;

    try {
      map = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'sys\$FileDescriptor',
        fromMap: (Map<String, dynamic> val) => FileDescriptor.fromMap(val),
        type: Types.entities,
        methodName: 'search',
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: [
              FilterCondition(
                property: 'id',
                conditionOperator: Operators.equals,
                value: fileId,
              ),
            ],
          ),
          view: '_local',
        ),
      ) as List;
    } catch (ex) {
      String error = ex.message;
      print(error);
      if (ex.message == 'No element') {
        error = 'Файл не найдено';
      }
      GlobalNavigator().errorBar(title: error);
      throw Exception('Can not fetch url');
    }

    // var pgId = pgMap.first["id"];
    return map?.first;
  }

  static Future<List<VacationScheduleRequest>> getMyVacationSchedule() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_VacationScheduleRequest',
      fromMap: (Map<String, dynamic> val) =>
          VacationScheduleRequest.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'vacationScheduleRequest-edit',
        sort: 'createTs',
        sortType: SortTypes.asc,
      ),
    ) as List;

    return map.cast<VacationScheduleRequest>();
  }


  static Future<List<RelevantPerson>> getNameByUserName({String name,String companyName}) async {
    // final bool connection = await checkConnection();
    // if (!connection) {
    //   return null;
    // }
    // final Box settings = await HiveUtils.getSettingsBox();
    // final id = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonGroupExt',
      fromMap: (Map<String, dynamic> val) =>
          RelevantPerson.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              group: 'OR',
              conditions: <ConditionCondition>[
                ConditionCondition(property: 'relevantPerson.lastName', conditionOperator: Operators.startsWith, value: name),
                ConditionCondition(property: 'relevantPerson.firstName', conditionOperator: Operators.startsWith, value: name),
              ],
            ),
            FilterCondition(
              group: 'AND',
              conditions: <ConditionCondition>[
                ConditionCondition(property: 'company.code', conditionOperator: Operators.equals, value:companyName ),
              ],
            ),
          ],
        ),
        view: 'personGroup-relevantPerson-fullNameCyrillic',
        sort: 'relevantPerson.lastName',
      ),
    ) as List;
    return map.cast<RelevantPerson>();
  }

  static Future<VacationScheduleRequest> getVacationScheduleById(
      String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_VacationScheduleRequest',
      fromMap: (Map<String, dynamic> val) =>
          VacationScheduleRequest.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            )
          ],
        ),
      ),
    ) as List;

    return map.cast<VacationScheduleRequest>().first;
  }

  static Future<List<AbsenceRequest>> getMyAbsenceRequest() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AbsenceRequest',
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      type: Types.queries,
      methodName: 'myAbsenceRequests',
      body: '''
        {
        "session\$userPersonGroupId":"${settings.get('pgId')}"
        }
        ''',
    ) as List;
    // var pgId = pgMap.first["id"];
    return map.cast<AbsenceRequest>();
  }

  static Future<List<AllAbsenceRequest>> getAllAbsenceRequest() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_AllAbsenceRequest',
      fromMap: (Map<String, dynamic> val) => AllAbsenceRequest.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: pgId,
            ),
          ],
        ),
        view: 'allAbsenceRequest-view',
        sort: 'createTs',
        sortType: SortTypes.asc,
      ),
    );
    return map.cast<AllAbsenceRequest>();
  }

  static Future getLeavingRequest({String id}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$LeavingVacationRequest',
      fromMap: (Map<String, dynamic> val) =>
          LeavingVacationRequest.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'leavingVacationRequest-editView',
      ),
    );
    return map.cast<LeavingVacationRequest>();
  }

  static Future<List<AbsenceRequest>> getAnnualLeaveVacations(
      String annualLeaveId) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AbsenceRequest',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            FilterCondition(
              property: 'type.id',
              conditionOperator: Operators.equals,
              value: annualLeaveId,
            )
          ],
        ),
        view: 'absenceRequest-for-mobile',
      ),
    ) as List;

    return map.cast<AbsenceRequest>();
  }

  static Future getMyCertificates() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_CertificateRequest',
      fromMap: (Map<String, dynamic> val) => CertificateRequest.fromMap(val),
      type: Types.entities,
      //entity
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        sort: 'createTs',
        sortType: SortTypes.asc,
        view: 'portal.certificateRequest-edit',
      ),
    );

    return map.cast<CertificateRequest>();
  }

  static Future<String> get pgID async =>
      (await HiveUtils.getSettingsBox()).get('pgId') as String;

  Future<List<AbsenceNewRvdRequest>> getAbsenceRvds({
    @required AbsenceNewRvdRequest request,
    @required String login,
    String entityName,
    String view,
  }) async {
    // log('-->> $fName, getAbsenceRvds ->> entity: ${request.getEntityName}');
    if (!(await checkConnection())) return <AbsenceNewRvdRequest>[];
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/${entityName ?? request.getEntityName}/search',
      query: <String, dynamic>{
        'view': view ?? request.getView,
        'sort': '-requestNumber',
        'returnCount': 'true',
        'filter': json.encode(
          <String, dynamic>{
            'conditions': <Map<String, dynamic>>[
              <String, dynamic>{
                'property': 'createdBy',
                'operator': '=',
                'value': login
              },
              <String, dynamic>{
                'group': 'OR',
                'conditions': <Map<String, dynamic>>[
                  <String, dynamic>{
                    'property': 'type.overtimeWork',
                    'value': 'true',
                    'operator': '='
                  },
                  <String, dynamic>{
                    'property': 'type.workOnWeekend',
                    'value': 'true',
                    'operator': '='
                  },
                  <String, dynamic>{
                    'property': 'type.temporaryTransfer',
                    'value': 'true',
                    'operator': '='
                  },
                  <String, dynamic>{
                    'property': 'type.availableToManager',
                    'operator': '=',
                    'value': 'true'
                  }
                ]
              }
            ]
          },
        ),
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>)
            .map((dynamic e) =>
                AbsenceNewRvdRequest.fromMap(e as Map<String, dynamic>))
            .toList();
      },
    );
    // final dynamic map = await Kinfolk.getListModelRest(
    //   serviceOrEntityName: request.getEntityName,
    //   fromMap: (Map<String, dynamic> val) => AbsenceNewRvdRequest.fromMap(val),
    //   type: Types.entities,
    //   methodName: 'search',
    //   filter: CubaEntityFilter(
    //     view: request.getView,
    //     sort: '-timeOfStarting',
    //     sortType: SortTypes.asc,
    //     filter: Filter(
    //       conditions: <FilterCondition>[
    //         FilterCondition(
    //           group: 'OR',
    //           conditions: <ConditionCondition>[
    //             ConditionCondition(property: 'type.overtimeWork', conditionOperator: Operators.equals, value: 'true'),
    //             ConditionCondition(property: 'type.workOnWeekend', conditionOperator: Operators.equals, value: 'true'),
    //             ConditionCondition(property: 'type.temporaryTransfer', conditionOperator: Operators.equals, value: 'true'),
    //             ConditionCondition(property: 'type.availableToManager', conditionOperator: Operators.equals, value: 'true'),
    //           ],
    //         ),
    //       ],
    //     ),
    //     returnCount: true,
    //   ),
    // );

    // return (map ?? <AbsenceNewRvdRequest>[]) as List<AbsenceNewRvdRequest>;
    // (resp.result as List<AbsenceNewRvdRequest>).forEach((element) {log('-->> $fName, getAbsenceRvds ->> result: ${element.toJson()}');});
    return (resp.result ?? <AbsenceNewRvdRequest>[])
        as List<AbsenceNewRvdRequest>;
  }

  Future<List<OvdRequest>> getOvds({
    @required OvdRequest request,
    @required String login,
    String entityName,
    String view,
  }) async {
    if (!(await checkConnection())) return <OvdRequest>[];
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/${entityName ?? request.getEntityName}/search',
      query: <String, dynamic>{
        'view': view ?? request.getView,
        'sort': '-startDate',
        'returnCount': 'true',
        'filter': json.encode(
          <String, dynamic>{
            'conditions': <Map<String, dynamic>>[
              <String, dynamic>{
                'property': 'createdBy',
                'operator': '=',
                'value': login
              },
            ]
          },
        ),
      },
      map: ({dynamic data}) {
        // log('-->> $fName, getOvds ->> data: $data');
        return (data as List<dynamic>)
            .map((dynamic e) => OvdRequest.fromMap(e as Map<String, dynamic>))
            .toList();
      },
    );
    return (resp.result ?? <OvdRequest>[]) as List<OvdRequest>;
  }

  static Future<CertificateRequest> getNewCertificateRequest(
      {String entityName}) async {
    final CertificateRequest certificateRequest =
        await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "$entityName"}''',
      fromMap: (Map<String, dynamic> val) => CertificateRequest.fromMap(val),
    ) as CertificateRequest;

    return certificateRequest;
  }

  static Future getCertificateType() async {
    final map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicCertificateType',
      fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    );
    return map.cast<AbstractDictionary>();
  }

  static Future getReceivingType() async {
    final map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicReceivingType',
      fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    );
    return map.cast<AbstractDictionary>();
  }

  // static Future<List<NotificationTemplate>> getMyTasks() async {
  //   final bool connection = await checkConnection();
  //   if (!connection) {
  //     return null;
  //   }
  //   final UserInfo userInfo = await HiveUtils.getUserInfo();
  //   final List map = await Kinfolk.getListModelRest(
  //     serviceOrEntityName: 'uactivity\$Activity',
  //     fromMap: (Map<String, dynamic> val) => NotificationTemplate.fromMap(val),
  //     type: Types.entities,
  //     methodName: 'search',
  //     filter: CubaEntityFilter(
  //       filter: Filter(
  //         conditions: [
  //           FilterCondition(
  //             property: 'assignedUser.id',
  //             conditionOperator: Operators.equals,
  //             value: userInfo.id,
  //           ),
  //           FilterCondition(
  //             property: 'type.code',
  //             conditionOperator: Operators.notEquals,
  //             value: 'NOTIFICATION',
  //           ),
  //           FilterCondition(
  //             property: 'status',
  //             conditionOperator: Operators.equals,
  //             value: 'active',
  //           ),
  //         ],
  //       ),
  //       sort: 'createTs',
  //       sortType: SortTypes.asc,
  //       view: 'mobile.notification',
  //       // offset: 10,
  //       // limit: 10
  //     ),
  //   ) as List;
  //   return map.cast<NotificationTemplate>();
  // }

  // static Future<List<NotificationTemplate>> getMyTasks() async {
  //   final bool connection = await checkConnection();
  //   if (!connection) {
  //     return null;
  //   }
  //   // final UserInfo userInfo = await HiveUtils.getUserInfo();
  //   final List map = await Kinfolk.getListModelRest(
  //     serviceOrEntityName: 'tsadv_NotificationService',
  //     fromMap: (Map<String, dynamic> val) {
  //       // log('-->> $fName, getMyTasks ->> val: ${jsonEncode(val)}');
  //       return NotificationTemplate.fromMap(val);
  //     },
  //     type: Types.services,
  //     methodName: 'tasks',
  //     // filter: CubaEntityFilter(
  //     //   filter: Filter(
  //     //     conditions: [
  //     //       FilterCondition(
  //     //         property: 'assignedUser.id',
  //     //         conditionOperator: Operators.equals,
  //     //         value: userInfo.id,
  //     //       ),
  //     //       FilterCondition(
  //     //         property: 'type.code',
  //     //         conditionOperator: Operators.notEquals,
  //     //         value: 'NOTIFICATION',
  //     //       ),
  //     //       FilterCondition(
  //     //         property: 'status',
  //     //         conditionOperator: Operators.equals,
  //     //         value: 'active',
  //     //       ),
  //     //     ],
  //     //   ),
  //     //   sort: 'createTs',
  //     //   sortType: SortTypes.asc,
  //     //   view: 'mobile.notification',
  //     //   // offset: 10,
  //     //   // limit: 10
  //     // ),
  //   ) as List;
  //   return map.cast<NotificationTemplate>();
  // }
  //
  static Future<List<NotificationTemplate>> getMyTasksNotifications({@required bool getNotification}) async {
    final bool connection = await checkConnection();
    if (!connection) return null;

    final UserInfo userInfo = await HiveUtils.getUserInfo();
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'uactivity\$Activity',
      fromMap: (Map<String, dynamic> val) {
        // log('-->> $fName, notification ->> getNotification=$getNotification: ${jsonEncode(val)}');
        return NotificationTemplate.fromMap(val);
      },
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
          filter: Filter(
            conditions: [
              FilterCondition(
                property: 'assignedUser.id',
                conditionOperator: Operators.equals,
                value: userInfo.id,
              ),
              FilterCondition(
                property: 'type.code',
                conditionOperator: getNotification? Operators.equals : Operators.notEquals,
                value: 'NOTIFICATION',
              ),
              FilterCondition(
                property: 'status',
                conditionOperator: Operators.notEquals,
                value: notificationStatusDone,
              ),
            ],
          ),
          sort: 'updateTs',
          sortType: SortTypes.asc,
          view: 'portal-activity',
          returnCount: true
          // offset: 10,
          // limit: 10
          ),
    ) as List;
    return map.cast<NotificationTemplate>();
  }

  static Future<List<NotificationTemplate>> getMyNotifications() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final UserInfo userInfo = await HiveUtils.getUserInfo();

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'uactivity\$Activity',
      fromMap: (Map<String, dynamic> val) => NotificationTemplate.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'assignedUser.id',
              conditionOperator: Operators.equals,
              value: userInfo.id,
            ),
            FilterCondition(
              property: 'type.code',
              conditionOperator: Operators.equals,
              value: 'NOTIFICATION',
            ),
            FilterCondition(
              property: 'status',
              conditionOperator: Operators.notEquals,
              value: notificationStatusDone,
            ),
          ],
        ),
        sort: 'createTs',
        // sort: "startDateTime",
        sortType: SortTypes.asc,
        view: 'portal-activity',
      ),
    ) as List;
    return map.cast<NotificationTemplate>();
  }


  static Future getCoursesCatalog() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicCategory',
      fromMap: (Map<String, dynamic> val) => DicCategory.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [],
        ),
        view: 'category-courses',
      ),
    );

    return map.cast<DicCategory>();
  }

  static Future getBooks() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicBookCategory',
      fromMap: (Map<String, dynamic> val) => DicBookCategory.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(conditions: []),
        view: 'portal-books-category-browse',
      ),
    );

    return map.cast<DicBookCategory>();
  }

  static Future getEnrollments() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicCategory',
      fromMap: (Map<String, dynamic> val) => DicCategory.fromMap(val),
      type: Types.queries,
      methodName: 'searchEnrollments',
      body: '''
      {
      "userId":"$id"
      }
      ''',
    );

    return map.cast<DicCategory>();
  }

  static Future<List<LearnedCourse>> getLearningStory() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Enrollment',
      fromMap: (Map<String, dynamic> val) => LearnedCourse.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'learning-history',
      ),
    ) as List;

    return map.cast<LearnedCourse>();
  }

  static Future<List<LearningHistory>> getLearningHistory() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final oauth2.Client client = await Authorization().client;
    // final String url = '$localEndPoint/rest/learning-history?personGroupId=$id';
    final String url =
        '${await endpointUrlAsync}/rest/learning-history?personGroupId=$id';
    print(url);
    final http.Response result = await client.get(
      url,
      headers: Kinfolk.appJsonHeader,
    );
    print(result.bodyBytes);

    final List list = jsonDecode(utf8.decode(result.bodyBytes)) as List;
    final List custModel = list.map((e) => LearningHistory.fromMap(e)).toList();
    return custModel;
  }

  static Future getSliderNews() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$LmsSliderImage',
      fromMap: (Map<String, dynamic> val) => SliderInfoRequest.fromMap(val),
      type: Types.queries,
      methodName: 'sliderImages?code=my-education',
    );
    return map.cast<SliderInfoRequest>();
  }

  static Future<Course> getCourseById(String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Course',
      fromMap: (Map<String, dynamic> val) => Course.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            )
          ],
        ),
        view: 'course.edit.new',
      ),
    ) as List;
    return map.isEmpty ? null : map.first;
  }

  static Future<BookRequest> getBookById(String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Book',
      fromMap: (Map<String, dynamic> val) => BookRequest.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            )
          ],
        ),
        view: 'portal-book-info',
      ),
    ) as List;

    return map.first;
  }

  static Future<Content> getCourseContentById(String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$LearningObject',
      fromMap: (Map<String, dynamic> val) => Content.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            )
          ],
        ),
        view: 'learningObject.browse',
      ),
    ) as List;
    return map.first;
  }

  static Future getCourseNotes(String courseId) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box settings = await HiveUtils.getSettingsBox();
    final personGroupId = settings.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_CoursePersonNote',
      fromMap: (Map<String, dynamic> val) => CourseNote.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: personGroupId,
            ),
            FilterCondition(
              property: 'course.id',
              conditionOperator: Operators.equals,
              value: courseId,
            )
          ],
        ),
      ),
    ) as List;
    return map.first;
  }

  static Future getStartBpmProcess(
      {String processDefinitionKey,
      String businessKey,
      String variables}) async {
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => BaseResult.fromMap(val),
    );
    return map;
  }

  static Future<SectionObject> getCourseSectionObjectById(String id) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$CourseSectionObject',
      fromMap: (Map<String, dynamic> val) => SectionObject.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'courseSectionObject.edit',
      ),
    );
    return map.first;
  }

  static Future<List<CourseReview>> getCourseReviewsByCourseId(
      String id) async {
    final list = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$CourseReview',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => CourseReview.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'course.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'courseReview.browse',
        sort: 'createTs',
        sortType: SortTypes.desc,
      ),
    );
    return list.cast<CourseReview>();
  }

  static Future<List<BookReviewRequest>> getBookReviewsByBookId(
      String id) async {
    final list = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$BookReview',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => BookReviewRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'book.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        sort: 'createTs',
        sortType: SortTypes.desc,
      ),
    );
    return list.cast<BookReviewRequest>();
  }

  static Future getSingleDictionaryByCode(
      {String entityName, String code, String view = '_local'}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: entityName,
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'code',
              conditionOperator: Operators.equals,
              value: code,
            ),
          ],
        ),
        view: view,
      ),
    );
    return map.first;
  }

  //Получение тип отсутствие "Трудовой отпуск"
  static Future getAnnualLeaveAbsenceType() async {
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_AbsenceService',
      fromMap: (Map<String, dynamic> val) => DicAbsenceType.fromMap(val),
      type: Types.services,
      methodName: 'getLaborLeave',
      body: '''
      {
      "view":"_local"
      }
      ''',
    );
    return map;
  }

  static  getAssignmentScheduleServices() async {
    final Box a = await HiveUtils.getSettingsBox();
    final id = a.get('pgId');
    var body = '''
      {
      "personGroupId": "$id",
      "date": "${DateTime.now()}",
      "view":"_minimal"
      }
      ''';
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_AssignmentScheduleService',
      fromMap: (Map<String, dynamic> val) => AssignmentScheduleModels.fromMap(val),
      type: Types.services,
      methodName: 'getAssignmentSchedule',
      body: body,
    );
    return map;
  }

  static Future getNewBpmRequestDefault({@required entity}) async {
    // var request = await Kinfolk.getSingleModelRest(
    //     serviceName: 'tsadv_PortalHelperService',
    //     methodName: 'newEntity',
    //     type: Types.services,
    //     body: '''{"entityName": "${entity.getEntityName}"}''',
    //     fromMap: (val) => entity.getFromJson(val));

    // String url = '$localEndPoint/rest/v2/services/tsadv_PortalHelperService/newEntity';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_PortalHelperService/newEntity';
    final oauth2.Client client = await Authorization().client;
    final http.Response request = await client.post(
      url,
      body: '''
             {"entityName": "${entity.getEntityName}"}
        ''',
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': GlobalVariables.lang
      },
    );
    // request.statusCode
    // print('url: $request');
    return entity.getFromJson(request.body);
  }

  // static Future getNewLeavingRequest() async {
  //   var leavingRequest = await Kinfolk.getSingleModelRest(
  //       serviceName: 'tsadv_PortalHelperService',
  //       methodName: 'newEntity',
  //       type: Types.services,
  //       body: '''{"entityName": "tsadv\$LeavingVacationRequest"}''',
  //       fromMap: (val) => LeavingVacationRequest.fromMap(val));
  //
  //   return leavingRequest;
  // }

  // static Future getNewVacationScheduleRequest({String entityName}) async {
  //   var vacationScheduleRequest = await Kinfolk.getSingleModelRest(
  //       serviceName: 'tsadv_PortalHelperService',
  //       methodName: 'newEntity',
  //       type: Types.services,
  //       body: '''{"entityName": "$entityName"}''',
  //       fromMap: (val) => VacationScheduleRequest.fromMap(val));
  //
  //   return vacationScheduleRequest;
  // }

  static Future getVacationScheduleByPersonGroupId() async {
    final Box a = await HiveUtils.getSettingsBox();
    final id = a.get('pgId');
    final List list = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.vacationScheduleRequest,
      methodName: '',
      type: Types.entities,
      fromMap: (Map<String, dynamic> json) =>
          VacationScheduleRequest.fromMap(json),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            )
          ],
        ),
      ),
    );

    return list.first;
  }

  // static Future getVacationByPersonGroupId({String personGroupId}) async {
  //   List list = await Kinfolk.getListModelRest(
  //     serviceOrEntityName: 'tsadv_VacationSchedule',
  //       methodName: '',
  //       type: Types.entities,
  //       fromMap: (json) => VacationSchedule.fromMap(json),
  //       filter: CubaEntityFilter(
  //         filter: Filter(
  //           conditions: [
  //             FilterCondition(
  //               property: 'id',
  //               conditionOperator: Operators.equals,
  //               value: personGroupId,
  //             )
  //           ],
  //         ),
  //       )
  //   );
  //   return list.cast<VacationSchedule>();
  // }

  static Future<List<DicAbsenceType>> getAbsenceType(
      String companyId, String annualLeaveId) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicAbsenceType',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> json) => DicAbsenceType.fromMap(json),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'company.id',
              conditionOperator: Operators.equals,
              value: companyId,
            ),
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: annualLeaveId,
            )
          ],
        ),
        view: 'dicAbsenceType.view',
      ),
    );

    return map.cast<DicAbsenceType>(); //map.isEmpty ? null : map.first;
  }

  static Future startAndLoadTest(
      {String courseSectionObjectId, String enrollmentId}) async {
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_LmsService',
      fromMap: (Map<String, dynamic> val) => Test.fromMap(val),
      type: Types.services,
      methodName: 'startAndLoadTest',
      body: '''
      {
      "courseSectionObjectId":"$courseSectionObjectId",
      "enrollmentId":"$enrollmentId"
      }
      ''',
    );
    return map;
  }

  static Future endTest({AnsweredTest test}) async {
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_LmsService',
      fromMap: (Map<String, dynamic> val) => val,
      type: Types.services,
      methodName: 'finishTest',
      body: '''
      {
      "answeredTest":${test.toJson()}
      }
      ''',
    );
    return map;
  }

  static Future<FileDescriptor> saveFile({@required File file}) async {
    final String fileName = file.path.split('/').last;
    // String url = '$localEndPoint/rest/v2/files?name=$fileName';
    final String url = '${await endpointUrlAsync}/rest/v2/files?name=$fileName';
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${GlobalVariables.token}'
    };
    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.headers.addAll(headers);
    final http.StreamedResponse response = await request.send();
    final String respStr = await response.stream.bytesToString();

    return FileDescriptor.fromJson(respStr);
  }

  static Future getBpmRolesDefiner({
    @required String processDefinitionKey,
    @required String employeePersonGroupId,
    @required bool isAssistant,
    @required dynamic request,
  }) async {
    try{
      final response = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv_StartBprocService',
        methodName: 'getBpmRolesDefiner',
        type: Types.services,
        body: '''
            {
              "request" : ${json.encode(request.toMap())},
              "employeePersonGroupId" : "$employeePersonGroupId",
               "isAssistant" : $isAssistant
               
            }''',
        fromMap: (Map<String, dynamic> val)=>BpmRolesDefiner.fromMap(val),
      );
      return response;
    }catch(e){
      print(e);
    }
  }

  static Future<List<NotPersisitBprocActors>> getNotPersisitBprocActors({
    @required String employeePersonGroupId,
    @required BpmRolesDefiner bpmRolesDefiner,
    @required bool isAssistant,
    @required dynamic request,
  }) async {
    try{
      final list = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_StartBprocService',
        methodName: 'getNotPersisitBprocActors',
        type: Types.services,
        body: '''
            {
              "isAssistant" : $isAssistant,
              "bpmRolesDefiner" : ${bpmRolesDefiner.toJson()},
              "employeePersonGroupId" : "$employeePersonGroupId",
              "request" : ${json.encode(request.toMap())}
            }''',
        fromMap: (Map<String, dynamic> val) =>
            NotPersisitBprocActors.fromMap(val),
      );

      return list.cast<NotPersisitBprocActors>();
    }catch(jsonString){
      GlobalNavigator.pop();
      GlobalNavigator().errorBar(title: S.current.errorServerAdmin);
    }

  }

  static Future saveBprocActors({@required SaveBprocActors bprocActors}) async {
    final request = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_StartBprocService',
      methodName: 'saveBprocActors',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => val,
      body: bprocActors.toJson(),
    );
    return request;
  }

  static Future<BprocRuntimeService> startProcessInstanceByKey(
      {@required BprocRuntimeService bprocRuntimeService}) async {
    final String bprocRuntimeServiceJson = bprocRuntimeService.toJson();

    final BprocRuntimeService result = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => BprocRuntimeService.fromMap(val),
      body: bprocRuntimeServiceJson,
    ) as BprocRuntimeService;

    return result;
  }

  // static Future startProcessInstanceLeavingRequestByKey(
  //     {@required BprocRuntimeLeavingVacationService bprocRuntimeLeavingVacationService}) async {
  //   var bprocRuntimeLeavingVacationServiceJson = bprocRuntimeLeavingVacationService.toJson();
  //
  //   var result = await Kinfolk.getSingleModelRest(
  //       serviceName: "bproc_BprocRuntimeService",
  //       methodName: "startProcessInstanceByKey",
  //       type: Types.services,
  //       fromMap: (val) => BprocRuntimeLeavingVacationService.fromMap(val),
  //       body: bprocRuntimeLeavingVacationServiceJson
  //   );
  //   return result;
  // }

  static Future startProcessInstanceByKeyCertificate(
      {@required BprocRuntimeServiceCertificate bprocRuntimeService}) async {
    final String bprocRuntimeServiceJson = bprocRuntimeService.toJson();

    final result = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => BprocRuntimeService.fromMap(val),
      body: bprocRuntimeServiceJson,
    );

    return result;
  }

  //
  // static Future startProcessInstanceByKeyForRecallAbsence(
  //     {@required BprocRuntimeServiceForRecall bprocRuntimeService}) async {
  //   var bprocRuntimeServiceJson = bprocRuntimeService.toJson();
  //
  //   var result = await Kinfolk.getSingleModelRest(
  //       serviceName: "bproc_BprocRuntimeService",
  //       methodName: "startProcessInstanceByKey",
  //       type: Types.services,
  //       fromMap: (val) => BprocRuntimeServiceForRecall.fromMap(val),
  //       body: bprocRuntimeServiceJson);
  //
  //   return result;
  // }

  static Future getAbsenceBalanceDays(
      {@required String dicAbsenceTypeId,
      @required DateTime absenceDate}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final http.Response result = await client.post(
      url,
      body: '''{
               "absenceTypeId": "$dicAbsenceTypeId",
                "personGroupId": "$id",
                "absenceDate": "${formatFullRest(absenceDate)}"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getVacationScheduleBalanceDays(
      {@required DateTime absenceDate}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_VacationScheduleRequestService/getVacationScheduleBalanceDays';
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final http.Response result = await client.post(
      url,
      body: '''{
      "vacation":{"personGroupId": "$id","startDate": "${formatFullRest(absenceDate)}"}
       }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getEnvironmentalDays({@required DateTime absenceDate}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getEnvironmentalDays';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceBalanceService/getEnvironmentalDays';
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final http.Response result = await client.post(
      url,
      body: '''{
                "personGroupId": "$id",
                "absenceDate": "${formatFullRest(absenceDate)}"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getRemainingDaysWeekendWork() async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceService/getRemainingDaysWeekendWork';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceService/getRemainingDaysWeekendWork';
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');

    final http.Response result = await client.post(
      url,
      body: '''{
                "personGroupId": "$id"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getReceivedVacationDaysOfYear({String absenceTypeId}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getReceivedVacationDaysOfYear';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceService/getReceivedVacationDaysOfYear';
    final DateTime date = DateTime.now();
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final http.Response result = await client.post(
      url,
      body: '''{
                "personGroupId": "$id",
                "absenceTypeId": "$absenceTypeId",
                "date": "$date"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future<bool> getAbsenceHasMaxDaysByTypId(
      {@required DicAbsenceType absenceType}) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final int year = DateTime.now().year;
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Absence',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            FilterCondition(
              property: 'type.id',
              conditionOperator: Operators.equals,
              value: absenceType.id,
            ),
            FilterCondition(
              property: 'absenceDays',
              conditionOperator: Operators.greaterThanEqual,
              value: absenceType.minDay,
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.greater,
              value: "${year - 1}-12-31",
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.less,
              value: "${year + 1}-01-01",
            )
          ],
        ),
        // view: 'mobile.notification',
      ),
    );
    return res.isNotEmpty;
  }

  static Future<bool> getVacationScheduleRequestHasMaxDaysByTypId(
      {@required DicAbsenceType absenceType}) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final int year = DateTime.now().year;
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.vacationScheduleRequest,
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) =>
          VacationScheduleRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            FilterCondition(
              property: 'absenceDays',
              conditionOperator: Operators.greaterThanEqual,
              value: absenceType.minDay ?? 0,
            ),
            FilterCondition(
              property: 'startDate',
              conditionOperator: Operators.greater,
              value: '$year-01-01',
            ),
            FilterCondition(
              property: 'endDate',
              conditionOperator: Operators.less,
              value: '${year + 1}-12-31',
            ),
          ],
        ),
        // view: 'mobile.notification',
      ),
    );
    return res.isNotEmpty;
  }

  static Future<bool> hasIntersectsVacationScheduleRequest(
      {@required VacationScheduleRequest request}) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final int year = DateTime.now().year;
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.vacationScheduleRequest,
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            // FilterCondition(
            //   property: 'type.id',
            //   conditionOperator: Operators.equals,
            //   value: absenceType.id,
            // ),
            // FilterCondition(
            //   property: 'absenceDays',
            //   conditionOperator: Operators.equals,
            //   value: absenceType.minDay,
            // ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.equals,
              value: '${year - 1}-12-31',
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.equals,
              value: '${year + 1}-01-01',
            ),
          ],
        ),
        // view: 'mobile.notification',
      ),
    );
    return res.isNotEmpty;
  }

  static Future<bool> getAbsenceRequestHasMaxDaysByTypId(
      {@required DicAbsenceType absenceType}) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final int year = DateTime.now().year;
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AbsenceRequest',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'status.code',
              conditionOperator: Operators.equals,
              value: 'APPROVING',
            ),
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            FilterCondition(
              property: 'type.id',
              conditionOperator: Operators.equals,
              value: absenceType.id,
            ),
            FilterCondition(
              property: 'absenceDays',
              conditionOperator: Operators.greaterThanEqual,
              value: absenceType.minDay,
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.greater,
              value: "${year - 1}-12-31",
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.less,
              value: "${year + 1}-01-01",
            )
          ],
        ),
        // view: 'mobile.notification',
      ),
    );
    print(res.toJSON());
    return res.isNotEmpty;
  }

  static Future isAbsenceIntersecte(
      {@required String dateFrom, @required String dateTo}) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Absence',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
            FilterCondition(
              property: 'type.availableForRecallAbsence',
              conditionOperator: Operators.equals,
              value: true,
            ),
            FilterCondition(
              property: 'type.availableForChangeDate',
              conditionOperator: Operators.equals,
              value: true,
            ),
            FilterCondition(
              property: 'type.useInSelfService',
              conditionOperator: Operators.equals,
              value: true,
            ),
            FilterCondition(
              property: 'dateTo',
              conditionOperator: Operators.greaterThanEqual,
              value: dateFrom,
            ),
            FilterCondition(
              property: 'dateFrom',
              conditionOperator: Operators.lessThanEqual,
              value: dateTo,
            ),
          ],
        ),
        view: '_local',
      ),
    ) as List;

    return res.isNotEmpty ? res.first : null;
  }

  static Future startProcessInstanceByKeyForChangeDays(
      {@required BprocRuntimeServiceForChangeDays bprocRuntimeService}) async {
    final String bprocRuntimeServiceJson = bprocRuntimeService.toJson();

    final result = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) =>
          BprocRuntimeServiceForChangeDays.fromMap(val),
      body: bprocRuntimeServiceJson,
    );

    return result;
  }

  static Future startProcessInstanceByKeySchedule(
      {@required BprocRuntimeServiceSchedule bprocRuntimeService}) async {
    final String bprocRuntimeServiceJson = bprocRuntimeService.toJson();

    final result = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) =>
          BprocRuntimeServiceSchedule.fromMap(val),
      body: bprocRuntimeServiceJson,
    );

    return result;
  }

  static Future startProcessInstanceByKeyRvdAbsenceRequest(
      {@required
          BprocRuntimeServiceRvdAbsenceRequest bprocRuntimeService}) async {
    final String bprocRuntimeServiceJson = bprocRuntimeService.toJson();

    final result = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocRuntimeService',
      methodName: 'startProcessInstanceByKey',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) =>
          BprocRuntimeServiceRvdAbsenceRequest.fromMap(val),
      body: bprocRuntimeServiceJson,
    );

    return result;
  }

  static Future getCountDay(
      {@required DateTime dateFrom,
      @required DateTime dateTo,
      @required String absenceTypeId,
      @required String personGroupId}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceService/countDays';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceService/countDays';
    // dateTo = DateTime(dateTo.year, dateTo.month, dateTo.day, dateTo.minute + 1);
    final http.Response result = await client.post(
      url,
      body: '''{
              "dateFrom" : "${formatFullRestNotMilSec(dateFrom)}",
              "dateTo" : "${formatFullRestNotMilSec(dateTo)}",
              "absenceTypeId" : "$absenceTypeId",
              "personGroupId" : "$personGroupId"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getProcessInstanceData(
      {@required String processInstanceBusinessKey,
      @required String processDefinitionKey}) async {
    final response = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_BprocService',
      methodName: 'getProcessInstanceData',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => ProcessInstanceData.fromMap(val),
      body: '''{
              "processInstanceBusinessKey" : "$processInstanceBusinessKey",
               "processDefinitionKey" : "$processDefinitionKey"
              }''',
    );

    return response;
  }

  static Future<List<ExtTaskData>> getProcessTasks(
      {@required ProcessInstanceData processInstanceData}) async {
    final String toJson = processInstanceData.toJson();
    final response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_BprocService',
      methodName: 'getProcessTasks',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => ExtTaskData.fromMap(val),
      body: '''{
                "processInstanceData" : $toJson 
              }''',
    );

    return response.cast<ExtTaskData>();
  }

  static Future getTaskFormData({@required String taskId}) async {
    final response = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocFormService',
      methodName: 'getTaskFormData',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => BpmFormData.fromMap(val),
      body: '''{"taskId": "$taskId"}''',
    );

    return response;
  }

  static Future completeWithOutcome(
      {String comment,
      @required String outcomeId,
      @required ExtTaskData currentTask}) async {
    // var body = '''{
    //           "taskData" : ${currentTask.toJson()},
    //           "outcomeId" : "$outcomeId",
    //           "processVariables" : {
    //             "comment" : "$comment"
    //            }
    //           }''';
    final response = await Kinfolk.getSingleModelRest(
      serviceName: 'bproc_BprocTaskService',
      methodName: 'completeWithOutcome',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => val,
      body: '''{
              "taskData" : ${currentTask.toJson()},
              "outcomeId" : "$outcomeId",
              "processVariables" : {
                "comment" : "$comment"
               }
              }''',
    );
    return response;
    return null;
  }

  //
  // static Future getLeavingVacationAbsenceById({@required String entityId}) async {
  //   oauth2.Client client = await Authorization().client;
  //   var url = '$localEndPoint/rest/v2/entities/' +
  //       'tsadv\$LeavingVacationRequest' +
  //       '/$entityId' +
  //       '?view=leavingVacationRequest-editView';
  //
  //   var result = await client.get(url, headers: Kinfolk.appJsonHeader);
  //
  //   return LeavingVacationRequest.fromJson(result.body);
  // }

  static Future getEntityParticipant1ScaleLevelId(
      {String view = '_local', @required entity}) async {
    // print("entity.getEntityName: ${entity.getEntityName}");
    final oauth2.Client client = await Authorization().client;
    // final String url = '$localEndPoint/rest/v2/entities/${entity.getEntityName}/${entity.id}?view=${entity.getView}';
    final String url =
        '${await endpointUrlAsync}/rest/v2/entities/${entity.getEntityName}/${entity.id}?view=${entity.getView}';

    final http.Response result = await client.get(
      url,
      headers: Kinfolk.appJsonHeader,
    );

    return entity.getFromJson(result.body);
  }

  static Future getEntity({@required dynamic entity, String view}) async {
    final oauth2.Client client = await Authorization().client;
    // final String url = '$localEndPoint/rest/v2/entities/${entity.getEntityName}/${entity.id}?view=${view ?? entity.getView}';
    final String url =
        '${await endpointUrlAsync}/rest/v2/entities/${entity.getEntityName}/${entity.id}?view=${view ?? entity.getView}';
    // log('-->> $fName, getEntity ->> url: $url');
    final http.Response result =
        await client.get(url, headers: Kinfolk.appJsonHeader);
    // log('-->> $fName, getEntity ->> result: ${result.body}');
    return entity.getFromJson(result.body);
  }

  // static Future getScheduleRequestById({@required String entityId}) async {
  //   oauth2.Client client = await Authorization().client;
  //   var url = '$localEndPoint/rest/v2/entities/' +
  //       'tsadv_ScheduleOffsetsRequest' +
  //       '/$entityId' +
  //       '?view=scheduleOffsetsRequest-for-my-team';
  //
  //   var result = await client.get(url, headers: Kinfolk.appJsonHeader);
  //
  //   return ScheduleRequest.fromJson(result.body);
  // }

  // static Future getAbsenceRvdRequestById({@required String entityId}) async {
  //   oauth2.Client client = await Authorization().client;
  //   var url = '$localEndPoint/rest/v2/entities/' +
  //       'tsadv_AbsenceRvdRequest' +
  //       '/$entityId' +
  //       '?view=absenceRvdRequest.edit';
  //
  //   var result = await client.get(url, headers: Kinfolk.appJsonHeader);
  //   return AbsenceRvdRequest.fromJson(result.body);
  // }

  // static Future getChangeAbsenceDaysById({@required String entityId}) async {
  //   oauth2.Client client = await Authorization().client;
  //   var url = '$localEndPoint/rest/v2/entities/' +
  //       'tsadv_ChangeAbsenceDaysRequest' +
  //       '/$entityId' +
  //       '?view=changeAbsenceDaysRequest.edit';
  //
  //   var result = await client.get(url, headers: Kinfolk.appJsonHeader);
  //
  //   return ChangeAbsenceDaysRequest.fromJson(result.body);
  // }

  static Future getCertificateById({@required String entityId}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/entities/' + 'tsadv_CertificateRequest' + '/$entityId' + '?view=portal.certificateRequest-edit';
    final String url =
        '${await endpointUrlAsync}/rest/v2/entities/tsadv_CertificateRequest/$entityId?view=portal.certificateRequest-edit';

    final http.Response result =
        await client.get(url, headers: Kinfolk.appJsonHeader);
    return CertificateRequest.fromJson(result.body);
  }

  static Future getNotificationById({@required String entityId}) async {
    final List res = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'uactivity\$Activity',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => NotificationTemplate.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: entityId,
            ),
          ],
        ),
        view: 'mobile.notification',
      ),
    );

    return res.first();
  }

  static Future getMyKpi() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignedPerformancePlan',
      fromMap: (Map<String, dynamic> val) =>
          AssignedPerformancePlan.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'assignedPerson.id',
              conditionOperator: Operators.equals,
              value: pgId,
            ),
            // FilterCondition(
            //   property: "type.code",
            //   conditionOperator: Operators.equals,
            //   value: "KPI_APPROVE",
            // ),
          ],
        ),
        view: 'assignedPerformancePlan-myKpi-edit',
      ),
    );

    return map.cast<AssignedPerformancePlan>();
  }

  static Future getAssignedGoalByPlanId({@required String planId}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignedGoal',
      fromMap: (Map<String, dynamic> val) => AssignedGoal.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'assignedPerformancePlan.id',
              conditionOperator: Operators.equals,
              value: planId,
            )
          ],
        ),
        view: 'assignedGoal-portal-kpi-create-default',
      ),
    );

    return map.cast<AssignedGoal>();
  }

  static Future getMyTeamKpi() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignedPerformancePlan',
      fromMap: (Map<String, dynamic> val) =>
          AssignedPerformancePlan.fromMap(val),
      type: Types.queries,
      methodName: 'kpiTeam',
      body: '''
        {
        "personGroupId":"$pgId"
        }
        ''',
    );
    return map.cast<AssignedPerformancePlan>();
  }

  static Future getMyTeamKpiList() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$PerformancePlan',
      fromMap: (Map<String, dynamic> val) => PerformancePlan.fromMap(val),
      type: Types.queries,
      methodName: 'kpiTeamPerformancePlans',
      body: '''
        {
        "personGroupId":"$pgId"
        }
        ''',
    );

    return map.cast<PerformancePlan>();
  }

  static Future getMyTeamKpiListFilter({String performanceId}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignedPerformancePlan',
      fromMap: (Map<String, dynamic> val) =>
          AssignedPerformancePlan.fromMap(val),
      type: Types.queries,
      methodName: 'kpiTeamPerformancePlan',
      body: '''
        {
        "personGroupId":"$pgId",
        "performancePlanId": "$performanceId"
        }
        ''',
    );
    return map.cast<AssignedPerformancePlan>();
  }

  static Future<AbstractDictionary> getCompanyByPersonGroupId() async {
    final String pgId = await HiveUtils.getPgId();
    // var a = await HiveUtils.getSettingsBox();
    // var pgId = a.get('pgId');
    final response = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_EmployeeService',
      methodName: 'getCompanyByPersonGroupId',
      type: Types.services,
      fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      body: '''{
              "personGroupId" : $pgId
              }''',
    );

    return response as AbstractDictionary;
  }

  static Future<InsuredPerson> getMyInsuredPerson(@required String id) async {
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'kzm_InsuredPersonKzm',
      methodName: '$id?view=insuredPersonKzm-editView',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
    );
    return map as InsuredPerson;
  }

  static Future<InsuredPerson> getInsuredTsadvPerson(
      @required String id) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$InsuredPerson',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'insuredPerson-editView',
      ),
    ) as List;
    return map.first as InsuredPerson;
  }

  static Future<List<Assistance>> getAssistanceById(@required String id) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicAssistance',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => Assistance.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: '_minimal',
      ),
    ) as List;
    return map.cast<Assistance>();
  }

  static Future<List<ContractAssistance>> getContractAssistanceById(
      @required String contractID) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_ContractAssistance',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => ContractAssistance.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'contract.id',
              conditionOperator: Operators.equals,
              value: contractID,
            ),
          ],
        ),
      ),
    ) as List;
    return map.cast<ContractAssistance>();
  }

  Future<List<String>> getCompaniesByPersonGroupId() async {
    final String pgId = await HiveUtils.getPgId();
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_PortalHelperService/getCompaniesForLoadDictionary',
      body: <String, dynamic>{
        'personGroupId': pgId,
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => e as String).toList();
      },
    );

    return (resp.result ?? <String>[]) as List<String>;
  }

  static Future<List<InsuredPerson>> getMyDMS() async {
    // final Box settings = await HiveUtils.getSettingsBox();

    final List map = await Kinfolk.getListModelRest(
      // serviceOrEntityName: 'tsadv\$InsuredPerson',
      serviceOrEntityName: 'kzm_DocumentService',
      fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
      // type: Types.entities,
      type: Types.services,
      methodName: 'getMyInsurances',
      // methodName: 'search',
      // filter: CubaEntityFilter(
      //   filter: Filter(
      //     conditions: <FilterCondition>[
      //       FilterCondition(
      //         property: 'employee.id',
      //         conditionOperator: Operators.equals,
      //         value: settings.get('pgId'),
      //       ),
      //       FilterCondition(
      //         property: 'relative.code',
      //         conditionOperator: Operators.equals,
      //         value: 'PRIMARY',
      //       ),
      //     ],
      //   ),
      //   view: 'insuredPerson-editView',
      // ),
    );

    return map.cast<InsuredPerson>();
  }

  static Future getMembers(
      {@required String insuranceContractId, @required String personId}) async {
    final List map = await Kinfolk.getListModelRest(
        // serviceOrEntityName: 'tsadv\$InsuredPerson',
        serviceOrEntityName: 'kzm_DocumentService',
        fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
        // type: Types.entities,
        type: Types.services,
        methodName: 'getInsuredPersonKzmMembersWithNewContract',
        body: '''
      {"insuredPersonId": "$personId",
      "contractId": "$insuranceContractId"}'''
        // filter: CubaEntityFilter(
        //   filter: Filter(
        //     conditions: [
        //       FilterCondition(
        //         property: 'insuredPersonId',
        //         conditionOperator: Operators.equals,
        //         value: settings.get('pgId'),
        //       ),
        //       // FilterCondition(
        //       //   property: 'relative.code',
        //       //   conditionOperator: Operators.notEquals,
        //       //   value: 'PRIMARY',
        //       // ),
        //       // FilterCondition(
        //       //   property: 'insuranceContract.id',
        //       //   conditionOperator: Operators.equals,
        //       //   value: insuranceContractId,
        //       // ),
        //       FilterCondition(
        //         property: 'contractId',
        //         conditionOperator: Operators.equals,
        //         value: insuranceContractId,
        //       ),
        //     ],
        //   ),
        //   view: 'insuredPerson-editView',
        // ),
        );

    return map.cast<InsuredPerson>();
  }

  static Future getNewInsuredPerson({String entityName}) async {
    final insuredPerson = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "$entityName"}''',
      fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
    );

    return insuredPerson;
  }

  static Future getPersonGroup() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonGroupExt',
      fromMap: (Map<String, dynamic> val) => in_person.PersonGroup.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: 'personGroupExt-person-data',
      ),
    );

    return map.first;
  }

  static Future getPersonGroupForAssignment() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    // pgId ??= (await getUserInfo()).id;

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonGroupExt',
      fromMap: (Map<String, dynamic> val) {
        return in_person.PersonGroup.fromMap(val);
      },
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: 'personGroupExt.mobile',
      ),
    ) as List;
    return map?.first;
  }

  static Future<List<MyTeamNew>> getChildrenForTeamService(
      {String parentPositionGroupId}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_MyTeamService',
      fromMap: (Map<String, dynamic> val) => MyTeamNew.fromMap(val),
      type: Types.services,
      methodName: 'getChildren',
      body: '''{"parentPositionGroupId": "$parentPositionGroupId"}''',
    );

    return map.cast<MyTeamNew>();
  }

  static Future<List<AssignmentSchedule>> getAssignmentSchedule(
      {String personGroupId}) async {
    print(personGroupId);
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignmentSchedule',
      fromMap: (Map<String, dynamic> val) => AssignmentSchedule.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'assignmentGroup',
              conditionOperator: Operators.equals,
              value: personGroupId,
            ),
          ],
        ),
        view: 'assignmentSchedule-for-my-team',
      ),
      // body: '''{"personGroupId": "$personGroupId"}''',
    ) as List;

    return map.cast<AssignmentSchedule>();
  }

  static Future getMyContracts({String companyId}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final int year = DateTime.now().year;

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$InsuranceContract',
      fromMap: (Map<String, dynamic> val) => InsuranceContract.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'company.id',
              conditionOperator: Operators.equals,
              value: companyId,
            ),
            FilterCondition(
              property: 'startDate',
              conditionOperator: Operators.greater,
              value: "${year - 1}-12-31 00:00:00",
            ),
            FilterCondition(
              property: 'startDate',
              conditionOperator: Operators.less,
              value: "${year + 2}-01-01 00:00:00",
            )
          ],
        ),
      ),
    );

    return map.cast<InsuranceContract>();
  }

  static Future getMemberContracts({String personGroupId}) async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final int year = DateTime.now().year;

    final List map = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_DocumentService',
        fromMap: (Map<String, dynamic> val) => print(val),
        type: Types.services,
        methodName: 'getContractListByPerson',
        body: '''{
        "personGroupId":"$personGroupId"
    } ''');

    return map.cast<InsuranceContract>();
  }

  static Future<List<Address>> getMyAddresses() async {
    final Box a = await HiveUtils.getSettingsBox();
    final id = a.get('pgId');
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Address',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => Address.fromMap(val),
      // ignore: require_trailing_commas
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'address.view',
      ),
    ) as List;

    return map.cast<Address>();
  }

  static Future calcAmount({
    @required String insuranceContractId,
    @required DateTime bith,
    @required String relativeTypeId,
    @required String memberId,
  }) async {
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');

    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_DocumentService/calcAmount';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_DocumentService/calculateAmount';
    var memberIds = memberId == null ? null : "$memberId";
    final http.Response result = await client.post(
      url,
      // ignore: leading_newlines_in_multiline_strings
      body: '''{
              "contractId" : "$insuranceContractId",
              "personGroupId" : "$pgId",
              "memberId": $memberIds,
              "memberBirthDate" : "${formatFullRest(bith)}",
              "replationTypeId" : "$relativeTypeId"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getPersonGroupById({@required String pgId}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonGroupExt',
      fromMap: (Map<String, dynamic> val) => in_person.PersonGroup.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: 'personGroupExt.mobile',
      ),
    );

    return map.first;
  }

  static Future<PersonProfile> getPersonProfileByPersonGroupId(
      {@required String pgId}) async {
    if (!await checkConnection()) return null;
    final map = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_EmployeeService',
      fromMap: (Map<String, dynamic> val) => PersonProfile.fromMap(val),
      type: Types.services,
      methodName: 'personProfile',
      body: '''{
          "personGroupId" : "$pgId"
        }''',
    );

    return map;
  }

  // static Future<bool> isChiefUser({@required String parentPositionGroupId}) async {
  //   if (!await checkConnection()) return false;
  //   List<dynamic> _result;
  //   try {
  //     _result = await Kinfolk.getListModelRest(
  //       serviceOrEntityName: 'tsadv_MyTeamService',
  //       methodName: 'getChildren',
  //       type: Types.services,
  //       body: <String, String>{
  //         'parentPositionGroupId': parentPositionGroupId,
  //       }.toString(),
  //       fromMap: (Map<String, dynamic> json) => json['id'],
  //     ) as List<dynamic>;
  //   } catch (e, s) {
  //     log('-->> $fName, isChiefUser', error: e, stackTrace: s);
  //     log('-->> _result: $_result');
  //     return false;
  //   }
  //   return (_result..removeWhere((dynamic element) => element == null)).isNotEmpty;
  // }

  static Future<List<AllAbsenceRequest>> getAllAbsenceByPersonGroupId() async {
    final Box settings = await HiveUtils.getSettingsBox();
    final UserInfo info = await HiveUtils.getUserInfo();

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_AllAbsenceRequest',
      methodName: 'search',
      type: Types.entities,
      // body: '''
      // {"
      //   "session\$userPersonGroupId":"${settings.get('pgId')}"
      // }
      // ''',
      fromMap: (Map<String, dynamic> val) => AllAbsenceRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'createdBy',
              conditionOperator: Operators.equals,
              value: info.login,
            ),
            // FilterCondition(
            //   property: 'personGroup.id',
            //   conditionOperator: Operators.equals,
            //   value: id,
            // ),
            // FilterCondition(
            //   property: 'entityName',
            //   conditionOperator: Operators.equals,
            //   value: 'tsadv\$AbsenceRequest',
            // ),
            // FilterCondition(
            //   group: 'OR',
            //   conditions: [
            //     ConditionCondition(
            //       property: 'entityName',
            //       conditionOperator: Operators.equals,
            //       value: 'tsadv_AbsenceForRecall',
            //     ),
            //     ConditionCondition(
            //       property: 'entityName',
            //       conditionOperator: Operators.equals,
            //       value: 'tsadv_ChangeAbsenceDaysRequest',
            //     )
            //   ],
            // ),
          ],
        ),
        view: 'allAbsenceRequest-view',
        sort: 'createTs',
        sortType: SortTypes.asc,
      ),
    ) as List;

    return map.cast<AllAbsenceRequest>();
  }

  static Future<List<AbsenceRvdRequest>> getAbsencesRvdByPersonGroupId(
      {@required String id}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_AbsenceRvdRequest',
      methodName: 'search',
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) => AbsenceRvdRequest.fromMap(val),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup',
              conditionOperator: Operators.equals,
              value: id,
            ),
          ],
        ),
        view: 'absenceRvdRequest.edit',
        sort: 'createTs',
        sortType: SortTypes.asc,
      ),
    );

    return map.cast<AbsenceRvdRequest>();
  }

  static Future<List<ScheduleOffsetsRequest>> getAbsencesSchedulePersonGroupId(
      {@required String id}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_ScheduleOffsetsRequest',
      methodName: 'getScheduleOffsetRequest?personGroupId=$id',
      type: Types.queries,
      fromMap: (Map<String, dynamic> val) =>
          ScheduleOffsetsRequest.fromMap(val),
    ) as List;

    return map.cast<ScheduleOffsetsRequest>();
  }

  static Future<List<Absence>> getAbsencesByPersonGroupId(
      {@required String id}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Absence',
      fromMap: (Map<String, dynamic> val) => Absence.fromMap(val),
      type: Types.queries,
      methodName: 'myAbsences',
      body: '''
        {
        "session\$userPersonGroupId":"$id"
        }
        ''',
    ) as List;

    return map.cast<Absence>();
  }

  static Future getNewAbsenceForRecall() async {
    final absenceRequest = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "tsadv_AbsenceForRecall"}''',
      fromMap: (Map<String, dynamic> val) => AbsenceForRecall.fromMap(val),
    );

    return absenceRequest;
  }

  static Future<List<AbsenceForRecall>> getAbsenceForRecall() async {
    List list;
    final UserInfo info = await HiveUtils.getUserInfo();
    try {
      list = await Kinfolk.getListModelRest(
        serviceOrEntityName: AbsenceForRecall().getEntityName,
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => AbsenceForRecall.fromMap(val),
        methodName: 'search',
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'createdBy',
                conditionOperator: Operators.equals,
                value: info.login,
              ),
            ],
          ),
          view: AbsenceForRecall().getView,
        ),
      ) as List;
    } catch (e) {}
    // var changeAbsenceDaysRequest = await Kinfolk.getSingleModelRest(
    //     serviceName: 'tsadv_PortalHelperService',
    //     methodName: 'newEntity',
    //     type: Types.services,
    //     body: '''{"entityName": "tsadv_ChangeAbsenceDaysRequest"}''',
    //     fromMap: (Map<String, dynamic> val) => ChangeAbsenceDaysRequest.fromMap(val));

    return list.cast<AbsenceForRecall>();
  }

  static Future<List<AbsenceVacationBalance>>
      getAbsenceVacationBalance() async {
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');

    List list = await Kinfolk.getListModelRest(
      serviceOrEntityName: "tsadv\$AbsenceBalance",
      type: Types.entities,
      fromMap: (Map<String, dynamic> val) =>
          AbsenceVacationBalance.fromMap(val),
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: pgId,
            ),
          ],
        ),
        view: '_local',
      ),
    ) as List;
    return list.cast<AbsenceVacationBalance>();
  }

  static Future getVacationBalanceDays({
    @required DateTime absenceDate,
  }) async {
    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');
    final oauth2.Client client = await Authorization().client;
    // final String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';

    final http.Response result = await client.post(
      url,
      // ignore: leading_newlines_in_multiline_strings
      body: '''{
              "absenceDate": "${formatFullRest(absenceDate)}",
              "personGroupId": "$pgId"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future<List<ChangeAbsenceDaysRequest>>
      getChangeAbsenceDaysRequests() async {
    List list;
    final UserInfo info = await HiveUtils.getUserInfo();
    try {
      list = await Kinfolk.getListModelRest(
        serviceOrEntityName: ChangeAbsenceDaysRequest().getEntityName,
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) =>
            ChangeAbsenceDaysRequest.fromMap(val),
        methodName: 'search',
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'createdBy',
                conditionOperator: Operators.equals,
                value: info.login,
              ),
            ],
          ),
          view: ChangeAbsenceDaysRequest().getView,
        ),
      ) as List;
    } catch (e) {}
    // var changeAbsenceDaysRequest = await Kinfolk.getSingleModelRest(
    //     serviceName: 'tsadv_PortalHelperService',
    //     methodName: 'newEntity',
    //     type: Types.services,
    //     body: '''{"entityName": "tsadv_ChangeAbsenceDaysRequest"}''',
    //     fromMap: (Map<String, dynamic> val) => ChangeAbsenceDaysRequest.fromMap(val));

    return list.cast<ChangeAbsenceDaysRequest>();
  }

  static Future<ScheduleOffsetsRequest> getNewScheduleOffsetsRequest() async {
    final ScheduleOffsetsRequest absenceSchedule =
        await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "tsadv_ScheduleOffsetsRequest"}''',
      fromMap: (Map<String, dynamic> val) =>
          ScheduleOffsetsRequest.fromMap(val),
    ) as ScheduleOffsetsRequest;

    return absenceSchedule;
  }

  static Future getNewAbsenceRvdRequest() async {
    final absenceRvd = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "tsadv_AbsenceRvdRequest"}''',
      fromMap: (Map<String, dynamic> val) => AbsenceRvdRequest.fromMap(val),
    );

    return absenceRvd;
  }

  static Future getNewEntityDefaultValues(
      {@required String entityName, @required entity}) async {
    final response = await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_PortalHelperService',
      methodName: 'newEntity',
      type: Types.services,
      body: '''{"entityName": "$entityName"}''',
      fromMap: (Map<String, dynamic> val) => entity.fromMap(val),
    );

    return response;
  }

  static Future getCountDaysWithoutHolidays(
      {@required DateTime startDate,
      @required DateTime endDate,
      @required String personGroupId}) async {
    final oauth2.Client client = await Authorization().client;
    // String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceService/countDaysWithoutHolidays';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceService/countDaysWithoutHolidays';

    final http.Response result = await client.post(
      url,
      // ignore: leading_newlines_in_multiline_strings
      body: '''{
              "dateFrom" : "${formatFullRest(startDate)}",
              "dateTo" : "${formatFullRest(endDate)}",
              "personGroupId" : "$personGroupId"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future getBalanceDays({
    @required String absenceTypeId,
    @required DateTime absenceDate,
    @required String personGroupId,
  }) async {
    final oauth2.Client client = await Authorization().client;
    // final String url = '$localEndPoint/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';
    final String url =
        '${await endpointUrlAsync}/rest/v2/services/tsadv_AbsenceBalanceService/getAbsenceBalance';

    final http.Response result = await client.post(
      url,
      // ignore: leading_newlines_in_multiline_strings
      body: '''{
              "absenceTypeId": "$absenceTypeId",
              "absenceDate": "${formatFullRest(absenceDate)}",
              "personGroupId": "$personGroupId"
              }''',
      headers: Kinfolk.appJsonHeader,
    );
    return result.body;
  }

  static Future<User> getUserByPersonGroupId({
    @required String pgId,
    String view = '_local',
    List<FilterCondition> additionalConditions,
  }) async {
    final List<dynamic> map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$UserExt',
      fromMap: (Map<String, dynamic> val) => User.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: pgId,
            ),
            if (additionalConditions != null) ...additionalConditions,
          ],
        ),
        view: view,
      ),
    ) as List<dynamic>;
    log('-->> $fName getUserByPersonGroupId -->> map: $map');

    return map.first as User;
  }

  static Future<BaseAssignmentExt> getBaseAssignmentExt() async {
    final DateTime _dt = DateTime.now();
    final List<dynamic> map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$AssignmentExt',
      fromMap: (Map<String, dynamic> val) => BaseAssignmentExt.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: await pgID,
            ),
            FilterCondition(
              property: 'assignmentStatus.code',
              conditionOperator: Operators.notEquals,
              value: 'TERMINATED',
            ),
            FilterCondition(
              property: 'primaryFlag',
              conditionOperator: Operators.equals,
              value: 'TRUE',
            ),
            FilterCondition(
              property: 'startDate',
              conditionOperator: Operators.lessThanEqual,
              value: formatFullRestNotMilSec(_dt),
            ),
            FilterCondition(
              property: 'endDate',
              conditionOperator: Operators.greaterThanEqual,
              value: formatFullRestNotMilSec(_dt),
            ),
          ],
        ),
        view: 'portal-assignment-group',
      ),
    ) as List<dynamic>;

    return map.first as BaseAssignmentExt;
  }

  static Future<AssignmentSchedule> getTsadvAssignmentSchedule(
      {@required String assignmentGroupID}) async {
    final List<dynamic> map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$AssignmentSchedule',
      fromMap: (Map<String, dynamic> val) => AssignmentSchedule.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'assignmentGroup.id',
              conditionOperator: Operators.equals,
              value: assignmentGroupID,
            ),
          ],
        ),
      ),
    ) as List<dynamic>;

    return map.first as AssignmentSchedule;
  }

  static Future<List<DicAbsenceType>> getAbsenceTypesForManager() async {
    // var a = await HiveUtils.getSettingsBox();
    // var id = a.get('pgId');
    final AbstractDictionary company =
        await RestServices.getCompanyByPersonGroupId();

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicAbsenceType',
      fromMap: (Map<String, dynamic> val) => DicAbsenceType.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'availableToManager',
              conditionOperator: Operators.equals,
              value: true,
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'company.code',
                  conditionOperator: Operators.equals,
                  value: 'empty',
                ),
                ConditionCondition(
                  property: 'company.id',
                  conditionOperator: Operators.equals,
                  value: company.id,
                )
              ],
            ),
          ],
        ),
        view: '_local',
      ),
    );

    return map.cast<DicAbsenceType>();
  }

  static Future<List<PositionHarmfulCondition>> getPositionHarmfulConditionByPG(
      {@required String pgId}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_PositionHarmfulCondition',
      fromMap: (Map<String, dynamic> val) =>
          PositionHarmfulCondition.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'positionGroup.id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: '_local',
      ),
    ) as List;

    return map.cast<PositionHarmfulCondition>();
  }

  static Future getPersonForSex({@required String pgId}) async {
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonExt',
      fromMap: (Map<String, dynamic> val) => in_person.Person.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: 'assignment.card.person',
      ),
    );

    return map.first;
  }

  static Future getPersonWithDocAndAddress() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }

    final Box a = await HiveUtils.getSettingsBox();
    final pgId = a.get('pgId');

    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonGroupExt',
      fromMap: (Map<String, dynamic> val) => in_person.PersonGroup.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'id',
              conditionOperator: Operators.equals,
              value: pgId,
            )
          ],
        ),
        view: 'personGroupExt-for-mobile-dms',
      ),
    );

    return map.first;
  }

  static Future<InsuredPerson> getInsuredPerson(
      {@required String type, @required dynamic insuranceContractId}) async {
    final response = await Kinfolk.getSingleModelRest(
      // serviceName: 'tsadv_DocumentService',
      serviceName: 'kzm_DocumentService',
      fromMap: (Map<String, dynamic> val) => InsuredPerson.fromMap(val),
      type: Types.services,
      // methodName: 'getInsuredPerson',
      methodName: 'getInsuredPersonKzm',
      body: '''
        {
        "type":"$type",
        "contractId": "$insuranceContractId"
         }
        ''',
    );

    // var pgId = pgMap.first["id"];
    return response as InsuredPerson;
  }

  static Future<List<KzmAdModel>> getAdverts({var listCompany}) async {
    if (!await checkConnection()) return <KzmAdModel>[];
    List<dynamic> _result = <KzmAdModel>[];
    try {
      _result = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_Timeline',
        methodName: 'search',
        type: Types.entities,
        filter: CubaEntityFilter(
          view: 'timeline.edit',
          limit: 8,
          offset: 0,
          returnCount: true,
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'company.id',
                conditionOperator: Operators.inList,
                value: listCompany,
              ),
              FilterCondition(
                property: 'isPublished',
                conditionOperator: Operators.equals,
                value: 'true',
              ),
            ],
          ),
          sort: 'createTs',
          sortType: SortTypes.asc,
        ),
        fromMap: (Map<String, dynamic> json) {
          // log('-->> $fName, getAdverts.fromMap: $json');
          return KzmAdModel.fromMap(json: json);
        },
      ) as List<dynamic>;
    } catch (e, s) {
      log('-->> $fName, getAdverts', error: e, stackTrace: s);
      log('-->> _result: $_result');
      return <KzmAdModel>[];
    }
    return _result.map((dynamic val) => val as KzmAdModel).toList();
  }

  static Future<List<TsadvLearningFeedbackTemplate>> getDailySurvey() async {
    if (!await checkConnection()) return <TsadvLearningFeedbackTemplate>[];
    final List<String> companies =
        (await RestServices().getCompaniesByPersonGroupId()) ?? <String>[];
    List<dynamic> _result = <TsadvLearningFeedbackTemplate>[];
    try {
      _result = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv\$LearningFeedbackTemplate',
        methodName: 'search',
        type: Types.entities,
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'usageType',
                conditionOperator: Operators.equals,
                value: 'DAILY_SURVEY',
              ),
              FilterCondition(
                property: 'company.id',
                conditionOperator: Operators.inList,
                value: companies,
              ),
            ],
          ),
        ),
        fromMap: (Map<String, dynamic> json) {
          return TsadvLearningFeedbackTemplate.fromMap(json);
        },
      ) as List<dynamic>;
    } catch (e, s) {
      log('-->> $fName, getDailyQuestions', error: e, stackTrace: s);
      log('-->> _result: $_result');
      return <TsadvLearningFeedbackTemplate>[];
    }

    return _result
        .map((dynamic val) => val as TsadvLearningFeedbackTemplate)
        .toList();
  }

  static Future<List<KzmQuestion>> getDailyQuestions() async {
    final List<TsadvLearningFeedbackTemplate> dailySurvey =
        await getDailySurvey();
    List<dynamic> _result = <KzmQuestion>[];
    try {
      final dynamic settings = await HiveService.getBox('settings');
      final String locale = (settings.get('locale') as String) ?? 'ru';
      const String id = 'feedbackQuestion';
      const Map<String, String> lng = <String, String>{
        'ru': '1',
        'kk': '2',
        'en': '3'
      };

      _result = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv\$LearningFeedbackTemplateQuestion',
        methodName: 'search',
        type: Types.entities,
        filter: CubaEntityFilter(
          view: 'learningFeedbackTemplateQuestion.edit',
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'feedbackTemplate.id',
                conditionOperator: Operators.equals,
                value: dailySurvey?.first?.id ?? '',
              ),
            ],
          ),
        ),
        fromMap: (Map<String, dynamic> json) {
          return KzmQuestion(
            type: KzmQuestion.mapKzmQuestionType(
                type: json[id]['questionType'] as String),
            templateId: json['feedbackTemplate']['id'].toString(),
            id: json[id]['id'] as String,
            text: (json[id]['questionLangValue${lng[locale]}'] ??
                json[id]['questionLangValue1']) as String,
            variants: (json[id]['answers'] as List<dynamic>)
                .map((dynamic e) =>
                    KzmCommonItem(id: e['id'].toString(), text: null))
                .toList(),
          );
        },
      ) as List<dynamic>;
    } catch (e, s) {
      log('-->> $fName, getDailyQuestions', error: e, stackTrace: s);
      log('-->> _result: $_result');
      return <KzmQuestion>[];
    }

    final List<KzmQuestion> questions =
        _result.map((dynamic val) => val as KzmQuestion).toList();
    for (final KzmQuestion question in questions) {
      for (final KzmCommonItem answer in question.variants) {
        answer.text ??= await getAnswerByID(id: answer.id);
      }
    }
    return questions;
  }

  static Future<String> getAnswerByID({@required String id}) async {
    if (!await checkConnection()) return '';
    dynamic _result = '';
    const Map<String, String> lng = <String, String>{
      'ru': '1',
      'kk': '',
      'en': '3'
    };
    try {
      final dynamic settings = await HiveService.getBox('settings');
      final String locale = (settings.get('locale') as String) ?? 'ru';
      _result = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv\$LearningFeedbackAnswer',
        methodName: id,
        type: Types.entities,
        fromMap: (Map<String, dynamic> json) =>
            json['answerLangValue${lng[locale]}'] ?? json['answerLangValue'],
      ) as dynamic;
    } catch (e, s) {
      log('-->> $fName, getAnswerByID', error: e, stackTrace: s);
      log('-->> _result: $_result');
      return '';
    }
    return _result as String;
  }

  static Future<dynamic> pushDailyQuestionsAnswers({
    @required String templateId,
    @required List<Map<String, dynamic>> answers,
  }) async {
    if (!await checkConnection()) return '';
    dynamic _result = '';
    final String pgId = await HiveUtils.getPgId();
    final Map<String, dynamic> _body = <String, dynamic>{
      'personGroupId': pgId,
      'answeredFeedback': <String, dynamic>{
        'templateId': templateId,
        'questionsAndAnswers': answers,
      },
    };

    try {
      _result = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv_LmsService',
        methodName: 'finishFeedback',
        type: Types.services,
        body: json.encode(_body),
        fromMap: (Map<String, dynamic> json) {
          return json.toString();
        },
      ) as dynamic;
    } catch (e, s) {
      log('-->> $fName, pushDailyQuestionsAnswers', error: e, stackTrace: s);
      log('-->> _result: $_result');
      return '';
    }
    // return _result as String;
    return _result;
  }

  static Future<List<PersonPayslip>> getPayslip() async {
    final String pgId = await HiveUtils.getPgId();
    List response;
    try {
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_PersonPayslip',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => PersonPayslip.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          view: 'portal.personPayslip-list',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }
    return response.cast<PersonPayslip>();
  }

  static Future<List<SurChargeRequest>> getMySurChangeRequestHistory() async {
    List responce = [];
    final String pgId = await HiveUtils.getPgId();
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_SurChargeRequest',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => SurChargeRequest.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'employeeName.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          sort: 'requestNumber',
          sortType: SortTypes.asc,
          view: 'surchargerequest.view',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.cast<SurChargeRequest>();
  }



  static Future<List<CollAgreementPaymentRequest>> getCollAgreementPaymentRequest() async {
    List responce = [];
    final String pgId = await HiveUtils.getPgId();
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'kzm_CollAgreementPaymentRequest',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => CollAgreementPaymentRequest.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          sort: 'requestNumber',
          sortType: SortTypes.asc,
          view: 'collAgreementPaymentRequest.edit',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.cast<CollAgreementPaymentRequest>();
  }

  static Future<List<ProcInstanceV>> getRequestHistory() async {
    List response = [];
    final UserInfo pgId = await HiveUtils.getUserInfo();
    // log('-->> $fName, getRequestHistory -->> pgId.id: ${pgId.id}');
    try {
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv\$ProcInstanceV',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => ProcInstanceV.fromMap(val),
        filter: CubaEntityFilter(
          sortType: SortTypes.asc,
          // sort: 'requestDate',
          sort: 'requestNumber',
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'startUser.id',
                conditionOperator: Operators.equals,
                value: pgId.id,
              ),
            ],
          ),
          view: 'procInstanceV-view',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }
    print(response.length);
    await HiveUtils.syncProcInstanceV(response.cast<ProcInstanceV>());
    return response.cast<ProcInstanceV>();
  }

  static Future<List<TrainingCalendar>> getTrainingCalendars() async {
    List responce;
    final String pgId = await HiveUtils.getPgId();
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_CourseScheduleEnrollment',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => TrainingCalendar.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          view: 'CourseScheduleEnrollment-view',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.cast<TrainingCalendar>();
  }

  static Future<List<CourseSchedule>> getCourseSchedules() async {
    List response;
    final String pgId = await HiveUtils.getPgId();
    try {
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_LearningService',
        methodName: 'getPersonCourseSchedule',
        type: Types.services,
        body: '''{"personGroupId":"$pgId"}''',
        fromMap: (Map<String, dynamic> val) =>
            CourseShedulesResponse.fromMap(val),
      ) as List;
    } catch (e) {
      print(e);
    }

    final List list = json.decode(response.first.value as String) as List;
    return list
        .map((e) => CourseSchedule.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> courseScheduleRequested(String id) async {
    final String url = Kinfolk.createRestUrl(
      'tsadv_LearningService',
      'createScheduleEnrollment',
      Types.services,
    );
    final oauth2.Client client = await Authorization().client;
    final String pgId = await HiveUtils.getPgId();
    final String login = (await HiveUtils.getUserInfo()).login;

    final http.Response response = await client.post(
      url,
      body: '''
          {
            "personGroupId": "$pgId",
            "scheduleId": "$id",
            "status": 1,
            "user": "$login"
          }''',
      headers: Kinfolk.appJsonHeader,
    );
  }

  static Future<List<LearningRequest>> getLearninRequests() async {
    List responce;
    final String pgId = await HiveUtils.getPgId();
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_LearningRequest',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => LearningRequest.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          view: 'portal.learningRequest-edit',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.cast<LearningRequest>();
  }

  static Future<List<PersonLearningContract>> getMyWorkContracts() async {
    List responce;
    final String pgId = await HiveUtils.getPgId();
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv\$PersonLearningContract',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) =>
            PersonLearningContract.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          view: 'personLearningContract.edit',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }
    print(responce.length);
    return responce.cast<PersonLearningContract>();
  }

  static Future<List<PortalMenuCustomization>> getPortalMenu() async {
    List responce = [];
    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_PortalHelperService',
        methodName: 'getPortalMenu',
        type: Types.services,
        fromMap: (Map<String, dynamic> val) {
          // log('-->> $fName, getPortalMenu ->> $val');
          return PortalMenuCustomization.fromMap(val);
        },
        body: '''
        {"menuType":"P"}
        ''',
      ) as List;
    } catch (e) {
      print(e);
    }
    return responce?.cast<PortalMenuCustomization>();
  }

  Future<List<TsadvTsadvReport>> _getReport({
    @required String codeValue,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/report\$Report/search',
      query: <String, dynamic>{
        'view': 'report.edit',
        'limit': '1',
        'filter': json.encode(<String, dynamic>{
          'conditions': <dynamic>[
            <String, dynamic>{
              'property': 'code',
              'operator': '=',
              'value': codeValue,
            },
            <String, dynamic>{
              'property': 'restAccess',
              'operator': '=',
              'value': 'TRUE',
            },
          ]
        }),
      },
      map: ({dynamic data}) {
        // kzmLog(fName: fName, func: '_getReport', text: 'map data', data: jsonEncode(data));
        // log('-->> $fName, _getReport ->> data: ${jsonEncode(data)}');
        return (data as List<dynamic>)
            .map((dynamic e) =>
                TsadvTsadvReport.fromMap(e as Map<String, dynamic>))
            .toList();
      },
    );

    return (resp.result ?? <TsadvTsadvReport>[]) as List<TsadvTsadvReport>;
  }

  Future<String> getReportData({
    @required String codeValue,
    @required List<Map<String, dynamic>> parameters,
    String templateCode = 'DEFAULT',
  }) async {
    final HttpClient httpClient = HttpClient();
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocDir.listSync(recursive: true).forEach((FileSystemEntity f) {
      try {
        if (f.path.contains(reportlFileName)) File(f.path).delete();
      } catch (_) {}
    });
    final String dir = appDocDir.path;
    final TsadvTsadvReport _report =
        (await _getReport(codeValue: codeValue)).first;
    final List<ReportReportTemplate> _template =
        _report.templates?.where((ReportReportTemplate e) {
      return e.code?.trim()?.toUpperCase() == templateCode.trim().toUpperCase();
    })?.toList();
    final String filePath =
        '$dir/$reportlFileName.${formatSolid(DateTime.now())}.${_template?.first?.outputNamePattern ?? _template?.first?.name}';
    try {
      // final String myUrl = '$endpointUrl/rest/reports/v1/run/${_report?.id}';
      final String myUrl =
          '${await endpointUrlAsync}/rest/reports/v1/run/${_report?.id}';
      final HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(myUrl));
      request.headers.set('content-type', 'application/json');
      if (GlobalVariables.token != null)
        request.headers.set('Authorization', 'Bearer ${GlobalVariables.token}');
      request.add(
        utf8.encode(
          json.encode(
            <String, dynamic>{
              'template': _template?.first?.code ?? templateCode,
              'parameters': parameters,
            }..removeWhere((String key, dynamic value) => value == null),
          ),
        ),
      );
      final HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final Uint8List bytes =
            await consolidateHttpClientResponseBytes(response);
        final File file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        log('-->> $fName, getReportData error -->> ${await response.transform(utf8.decoder).join()}');
        throw Exception('Error code: ${response.statusCode}');
      }
    } catch (e, s) {
      GlobalNavigator().errorBar(title: e.message as String);
      log('-->> $fName, getReportData -->>', error: e, stackTrace: s);
    } finally {
      httpClient.close();
    }
    return filePath;
  }

  static Future<List<AdaptationPlan>> getAdaptationPlans() async {
    List responce = [];
    final String pgId = await HiveUtils.getPgId();
    print(pgId);

    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_AdaptationPlan',
        methodName: 'search',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => AdaptationPlan.fromMap(val),
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: <FilterCondition>[
              FilterCondition(
                property: 'personGroup.id',
                conditionOperator: Operators.equals,
                value: pgId,
              ),
            ],
          ),
          view: 'adaptationPlan',
          sort: 'dateFrom',
          sortType: SortTypes.asc,
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.cast<AdaptationPlan>();
  }

  static Future<List<GetDocumentListResponse>> getDocumentListResponse() async {
    List responce = [];
    // final AbstractDictionary company = await getCompanyByPersonGroupId();
    final UserInfo userInfo = await HiveUtils.getUserInfo();

    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_LearningService',
        fromMap: (Map<String, dynamic> val) =>
            GetDocumentListResponse.fromMap(val),
        type: Types.services,
        methodName: 'getDocumentList',
        body: '''
        {"userId":"${userInfo.id}"}
        ''',
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.toList().cast<GetDocumentListResponse>().toList();
  }

  static Future<List<DocumentsFamiliarization>>
      getIntroductoryDocuments() async {
    List responce = [];
    final AbstractDictionary company = await getCompanyByPersonGroupId();

    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_DocumentsFamiliarization',
        fromMap: (Map<String, dynamic> val) =>
            DocumentsFamiliarization.fromMap(val),
        type: Types.entities,
        methodName: 'search',
        filter: CubaEntityFilter(
          filter: Filter(
            conditions: [
              FilterCondition(
                property: 'company',
                conditionOperator: Operators.equals,
                value: company.id,
              ),
            ],
          ),
          view: 'documentsFamiliarization.edit',
        ),
      ) as List;
    } catch (e) {
      print(e);
    }

    return responce.toList().cast<DocumentsFamiliarization>().toList();
  }

  // static Future<void> checkDocFamilization() async {
  //   final String pgId = await HiveUtils.getPgId();
  //   List knownResponce = [];
  //   try {
  //     knownResponce = await Kinfolk.getListModelRest(
  //       serviceOrEntityName: 'tsadv_ListOfAcknowledgement',
  //       fromMap: (Map<String, dynamic> val) => val,
  //       type: Types.entities,
  //       methodName: 'search',
  //       filter: CubaEntityFilter(
  //         filter: Filter(
  //           conditions: [
  //             FilterCondition(
  //               property: 'user.personGroup.id',
  //               conditionOperator: Operators.equals,
  //               value: pgId,
  //             )
  //           ],
  //         ),
  //         view: 'listOfAcknowledgement.edit',
  //       ),
  //     ) as List;
  //     Box box = await HiveService.getBox('documentsFamiliarization') as Box;
  //     knownResponce.forEach((element) {
  //       try {
  //         final key = element['documentFamiliarization']['id'];
  //         box.put(key, key);
  //       } catch (e) {
  //         print(e);
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static Future<List<in_person.PersonGroup>> getMyAdaptationTeam() async {
    final List responce = [];
    final String pgId = await HiveUtils.getPgId();
    try {
      responce.addAll(
        await Kinfolk.getListModelRest(
          serviceOrEntityName: 'tsadv_AdaptationService',
          fromMap: (Map<String, dynamic> val) =>
              in_person.PersonGroup.fromMap(val),
          type: Types.services,
          methodName: 'getManagers',
          body: '''
        {
        "id":"$pgId"
        }
        ''',
        ) as List,
      );
    } catch (e) {
      print(e);
    }
    try {
      responce.addAll(
        await Kinfolk.getListModelRest(
          serviceOrEntityName: 'tsadv_AdaptationService',
          fromMap: (Map<String, dynamic> val) =>
              in_person.PersonGroup.fromMap(val),
          type: Types.services,
          methodName: 'getHrs',
        ) as List,
      );
    } catch (e) {
      print(e);
    }
    return responce.cast<in_person.PersonGroup>();
  }

  static Future<List<Course>> getAdaptationCourses(String id) async {
    List responce = [];

    try {
      responce = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_AdaptationService',
        fromMap: (Map<String, dynamic> val) =>
            Course.fromMap(val['course'] as Map<String, dynamic>),
        type: Types.services,
        methodName: 'getPositionCourse',
        body: '''
        {
        "entityId":"$id"
        }
        ''',
      ) as List;
    } catch (e) {
      print(e);
    }
    print(responce);

    return responce.cast<Course>();
  }

  static Future<List<MyTeamNew>> getChildren(
      {@required String parentPositionGroupId}) async {
    List<dynamic> response;
    try {
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_MyTeamService',
        methodName: 'getChildren',
        type: Types.services,
        fromMap: (Map<String, dynamic> val) => MyTeamNew.fromMap(val),
        body: json.encode(
          <String, dynamic>{
            'parentPositionGroupId': parentPositionGroupId,
          },
        ),
      ) as List<dynamic>;
    } catch (e, s) {
      log('-->> $fName, getChildren -->> error!', error: e, stackTrace: s);
    }
    return response.cast<MyTeamNew>();
  }

  static Future<List<AbstractDictionary>> getDicParticipantType() async {
    List<dynamic> response;
    try {
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv\$DicParticipantType',
        methodName: '',
        type: Types.entities,
        fromMap: (Map<String, dynamic> val) => AbstractDictionary.fromMap(val),
      ) as List<dynamic>;
    } catch (e, s) {
      log('-->> $fName, getDicParticipantType -->> error!',
          error: e, stackTrace: s);
    }
    return response.cast<AbstractDictionary>();
  }

  static Future<List<PersonAssessments>> getPersonAssessments() async {
    List response = [];
    final String pgId = await HiveUtils.getPgId();
    print(pgId);
    try {
      final dynamic settings = await HiveService.getBox('settings');
      final String locale = (settings.get('locale') as String) ?? 'ru';
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_LearningService',
        methodName: 'getPersonAssessments',
        type: Types.services,
        fromMap: (Map<String, dynamic> val) =>
            PersonAssessmentsResponse.fromMap(val),
        body: '''
        {
        "personGroupId":"$pgId",
        "lang":"$locale"
                }
        ''',
      ) as List;
    } catch (e) {
      print(e);
    }
    if (response.isEmpty) {
      return <PersonAssessments>[];
    }
    final List list = json.decode(response.first.value as String) as List;
    return list
        .map((e) => PersonAssessments.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<PersonAssessmentForm>> getPersonAssessmentForm(
      String personAssessmentId) async {
    List response = [];
    // final String pgId = await HiveUtils.getPgId();

    try {
      final dynamic settings = await HiveService.getBox('settings');
      final String locale = (settings.get('locale') as String) ?? 'ru';
      response = await Kinfolk.getListModelRest(
        serviceOrEntityName: 'tsadv_LearningService',
        methodName: 'getPersonAssessmentForm',
        type: Types.services,
        fromMap: (Map<String, dynamic> val) =>
            PersonAssessmentFormResponse.fromMap(val),
        body: '''
        {
        "personGroupId":"$personAssessmentId",
        "lang":"$locale"
                }
        ''',
      ) as List;
    } catch (e) {
      print(e);
    }
    if (response.isEmpty) {
      return <PersonAssessmentForm>[];
    }
    final List list = response.first.value;
    return list.cast<PersonAssessmentForm>();
    // return list.map((e) => PersonAssessmentForm.fromMap(e as Map<String, dynamic>)).toList();
  }

  static Future<List<AdaptationTask>> getMyAdaptationTask(
      String adaptationId) async {
    final List responce = [];
    final String pgId = await HiveUtils.getPgId();

    try {
      responce.addAll(
        await Kinfolk.getListModelRest(
          serviceOrEntityName: 'tsadv_AdaptationTask',
          fromMap: (val) => AdaptationTask.fromMap(val),
          type: Types.entities,
          methodName: 'search',
          filter: CubaEntityFilter(
            filter: Filter(
              conditions: [
                FilterCondition(
                  property: 'adaptationPlan.personGroup',
                  conditionOperator: Operators.equals,
                  value: pgId,
                ),
                FilterCondition(
                  property: 'adaptationPlan.needless',
                  conditionOperator: Operators.equals,
                  value: false,
                ),
              ],
            ),
            view: 'adaptationTask',
          ),
        ) as List,
      );
    } catch (e) {
      print(e);
    }
    return responce.cast<AdaptationTask>();
  }

  static Future createEntity({
    @required String entityName,
    entity,
    entityMap,
  }) async {
    return await Kinfolk.getSingleModelRest(
      serviceName: entityName,
      methodName: '',
      type: Types.entities,
      body: (entity?.toJson() ?? jsonEncode(entityMap))
          .toString()
          .replaceAll('"id":null,', ''),
      fromMap: (val) => val,
    );
  }

  static Future<List<CompanyVacation>> getCompanyVacation(
      {String companyId, String companyName, int page}) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$Requisition',
      fromMap: (Map<String, dynamic> val) {
        return CompanyVacation.fromMap(val);
      },
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              group: "OR",
              conditions: [
                ConditionCondition(
                  property: 'nameForSiteLang1',
                  conditionOperator: Operators.contains,
                  value: companyName ?? "",
                ),
                ConditionCondition(
                  property: 'nameForSiteLang2',
                  conditionOperator: Operators.contains,
                  value: companyName ?? "",
                ),
                ConditionCondition(
                  property: 'nameForSiteLang3',
                  conditionOperator: Operators.contains,
                  value: companyName ?? "",
                ),
              ],
            ),
            FilterCondition(
              property: 'requisitionStatus',
              conditionOperator: Operators.equals,
              value: 'OPEN',
            ),
            FilterCondition(
              property: 'positionGroup.company.id',
              conditionOperator:
                  companyId != '' ? Operators.equals : Operators.notEquals,
              value: companyId,
            ),
            FilterCondition(
              property: 'createdBy',
              conditionOperator: Operators.notEquals,
              value: 'migration_candidate2',
            ),
          ],
        ),
        sort: 'createTs',
        sortType: SortTypes.asc,
        view: 'requisition.list',
      ),
    ) as List;
    return map.cast<CompanyVacation>();
  }

  static Future<CompanyVacationItem> getCompanyVacationItem(String id) async {
    var entity = CompanyVacationItem();
    final oauth2.Client client = await Authorization().client;
    final String url =
        '${await endpointUrlAsync}/rest/v2/entities/tsadv\$Requisition/$id?view=requisition.info';
    final http.Response result = await client.get(
      url,
      headers: Kinfolk.appJsonHeader,
    );
    return entity.userInfoFromJson(result.body);
  }

  static Future<bool> applyVacation({String companyId}) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
        "candidatePersonGroup": "$id",
        "requestDate": "${formatFullRest(DateTime.now())}",
        "requisition": "$companyId"
      }
      ''';
    final String url = Kinfolk.createRestUrl('tsadv_LearningService',
        'createJobRequestForRecommendation', Types.services);
    final http.Response response = await client.post(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 204;
  }

  static Future<bool> applyRecommendVacation(
      {String companyId, String personId}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    final String body = '''
      {
        "candidatePersonGroup": "$personId",
        "requestDate": "${formatFullRest(DateTime.now())}",
        "requisition": "$companyId"
      }
      ''';
    final String url = Kinfolk.createRestUrl('tsadv_LearningService',
        'createJobRequestForRecommendation', Types.services);
    final http.Response response = await client.post(
      url,
      body: body,
    );
    return !(response.body.contains('Cannot deserialize an entity from JSON') ||
            response.body.contains('Server error') ||
            response.body.contains('MetaClass null not found')) &&
        response.statusCode == 204;
  }

  static Future<BasePersonGroupExt> createCandidate(
      {String companyId, String firstName, String lastName, String mobilePhone, String email, DateTime birthDate}) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    var body = '''
      {
      "firstName": "$firstName",
      "lastName": "$lastName",
      "requisitionId": "$companyId",
      "mobilePhone": "$mobilePhone",
      "email": "$email",
      "birthDate": "$birthDate"
      }
      ''';
    final createVacation = await Kinfolk.getSingleModelRest(
        serviceName: 'tsadv_LearningService',
        fromMap: (Map<String, dynamic> val) => BasePersonGroupExt.fromMap(val),
        type: Types.services,
        methodName: 'createCandidateForReferral',
        body: body,);

    return createVacation as BasePersonGroupExt;
  }

  static Future createRefferalCandidate(VacanciesRecommend request) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    request.referrer = AbstractDictionary(id: id.toString());
    return await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv_RefferalCandidate',
      methodName: '',
      type: Types.entities,
      body: request.toJson(),
      fromMap: (val) => val,
    );
  }

  static Future getPersonGroupRefferalCandidate(String id) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    return await Kinfolk.getSingleModelRest(
      serviceName: 'base\$PersonGroupExt',
      methodName: '$id?view=person-group-ext-intern',
      type: Types.entities,
      fromMap: (val) => val,
    );
  }

  static Future createCityGroupRefferalCandidate(
      {String id, String city}) async {
    final oauth2.Client client = await Kinfolk.getClient();
    var body = '''{
      "id": $id,
      "city": $city
      }''';
    final String url =
        Kinfolk.createRestUrl('base\$PersonExt', id, Types.entities);
    final http.Response response = await client.put(url, body: body);
    var jsonCode = json.decode(response.body);
    return jsonCode;
  }

  static Future createPersonAttachment(
      {FileDescriptor attachment,
      String personGroup,
      EmployeeCategory category}) async {
    final bool connection = await checkConnection();
    if (!connection) return null;
    return await Kinfolk.getSingleModelRest(
      serviceName: 'tsadv\$PersonAttachment',
      methodName: '',
      type: Types.entities,
      body: '''{
           "personGroup": {
             "id": "$personGroup"
           },
           "category": ${category.toMap()},
           "attachment": ${attachment.toMap()},
           "filename": "${attachment.name}"
      
      }''',
      fromMap: (val) => val,
    );
  }

  static Future<List<AbstractDictionary>> getDicExperience() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicExperience',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;
    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> companySearches() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base_DicCompany',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> relationshipToReferrer() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicRelationshipToReferrer',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> dicEducation() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicEducation',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> dicPersonalEvaluation() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_DicPersonalEvaluation',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<EmployeeCategory>> getAttachmentCategory() async {
    final bool connection = await checkConnection();
    if (!connection) {
      return null;
    }
    final List map = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicAttachmentCategory',
      fromMap: (Map<String, dynamic> val) => EmployeeCategory.fromMap(val),
      type: Types.entities,
      methodName: 'search',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'code',
              conditionOperator: Operators.equals,
              value: "RESUME",
            ),
          ],
        ),
        view: '_minimal',
      ),
    );
    return map.cast<EmployeeCategory>();
  }

  Future<bool> checkClicks(String requisitionId, String id) async {
    const bool _result = false;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_RequisitionService/existsByGroupIdAndRequisitionId',
      body: <String, dynamic>{
        'candidatePersonGroupId': '$id',
        'requisitionId': "$requisitionId",
      },
      map: ({dynamic data}) => null,
    );
    log('-->> $fName, sendSms ->> resp: ${resp.bodyString}');
    if ((resp.isOk) && ((resp.bodyString ?? '').toUpperCase() == 'TRUE'))
      return true;

    return _result;
  }

  Future<bool> checkRecommendClick({String requisitionId, String lastName, String firstName, DateTime birthDate}) async {
    const bool _result = false;
    final KzmApiResult resp = await _api.reqPostMap(
      checkConnection: false,
      url: 'services/tsadv_RequisitionService/existsByRequisitionIdAndFullName',
      body: <String, dynamic>{
        'lastName': lastName,
        'firstName': firstName,
        'requisitionId': requisitionId,
        'dateOfBirth': formatFullRestNotMilSec(birthDate)
      },
      map: ({dynamic data}) => null,
    );
    log('-->> $fName, sendSms ->> resp: ${resp.bodyString}');
    if ((resp.isOk) && ((resp.bodyString ?? '').toUpperCase() == 'TRUE'))
      return true;

    return _result;
  }

  static Future<BasePersonGroupExt> getPersonByFullName({String lastName, String firstName, DateTime birthDate}) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$PersonExt',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'firstName',
              conditionOperator: Operators.equals,
              value: firstName,
            ),
            FilterCondition(
              property: 'lastName',
              conditionOperator: Operators.equals,
              value: lastName,
            ),
            FilterCondition(
              property: 'type.code',
              conditionOperator: Operators.equals,
              value:'CANDIDATE',
            ),
            FilterCondition(
              property: 'dateOfBirth',
              conditionOperator: Operators.equals,
              value: formatFullRestNotMilSec(birthDate),
            ),

          ],
        ),
        view: 'person-for-search',
      ),
      fromMap: (val) => BasePersonExt.fromMap(val),
      type: Types.entities,
      methodName: 'search',
    ) as List;
    var list = response.cast<BasePersonExt>();
    if(list.isEmpty){

      return null;
    }else{
      return list.first.group;
    }
  }


  static Future<List<AbstractDictionary>> getRegion() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'base\$DicRegion',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<DicAbsenceType>> getAbsenceTypes(String companyId) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicAbsenceType',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'useInSelfService',
              conditionOperator: Operators.equals,
              value: true,
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'company.code',
                  conditionOperator: Operators.equals,
                  value: 'empty',
                ),
                ConditionCondition(
                  property: 'company.id',
                  conditionOperator: Operators.equals,
                  value: companyId,
                ),
              ],
            ),
          ],
        ),
        view: '_local',
      ),
      fromMap: (val) => DicAbsenceType.fromMap(val),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<DicAbsenceType>();
  }

  static Future<List<VacationScheduleRequest>> getScheduleTypes(
      String personGroupId) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.vacationScheduleRequest,
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'personGroup.id',
              conditionOperator: Operators.equals,
              value: personGroupId,
            ),
            FilterCondition(
              property: 'sentToOracle',
              conditionOperator: Operators.equals,
              value: 'SENT_TO_ORACLE',
            ),
            FilterCondition(
              property: 'startDate',
              conditionOperator: Operators.greater,
              value: formatFullRestNotMilSec(DateTime.now()),
            ),
          ],
        ),
        view: '_local',
        sort: 'createTs',
        sortType: SortTypes.desc,
      ),
      fromMap: (Map<String, dynamic> json) =>
          VacationScheduleRequest.fromMap(json),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<VacationScheduleRequest>();
  }

  static Future<List<ContractAssistance>> getAssistanceContract(
      String id) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_ContractAssistance',
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'contract.id',
              conditionOperator: Operators.equals,
              value: id ?? '',
            ),
          ],
        ),
      ),
      fromMap: (val) => ContractAssistance.fromMap(val),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<ContractAssistance>();
  }

  static Future<List<AbstractDictionary>> getAddressType() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicAddressType',
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> getMemberSex() async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.dicSex,
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: '',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> getDocType(String companyId) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv\$DicDocumentType',
      fromMap: (Map<String, dynamic> json) => AbstractDictionary.fromMap(json),
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'company.id',
              conditionOperator: Operators.equals,
              value: companyId,
            ),
            FilterCondition(
              property: 'isIdOrPassport',
              conditionOperator: Operators.equals,
              value: 'TRUE',
            )
          ],
        ),
        view: '_local',
      ),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> getRelative(String companyCode) async {
    final DateTime _dt = DateTime.now();
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.dicRelationshipType,
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'code',
              conditionOperator: Operators.notEquals,
              value: 'PRIMARY',
            ),
            FilterCondition(
              property: 'useInVmi',
              conditionOperator: Operators.equals,
              value: 'TRUE',
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'endDate',
                  conditionOperator: Operators.equals,
                  value: '',
                ),
                ConditionCondition(
                  property: 'endDate',
                  conditionOperator: Operators.greaterThanEqual,
                  value: formatFullRestNotMilSec(_dt),
                ),
              ],
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'company.code',
                  conditionOperator: Operators.equals,
                  value: companyCode,
                ),
              ],
            ),
          ],
        ),
        view: 'dicRelationshipType-browse',
      ),
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<AbstractDictionary>> getRelativeList() async {
    final DateTime _dt = DateTime.now();
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: EntityNames.dicRelationshipType,
      filter: CubaEntityFilter(
        filter: Filter(
          conditions: [
            FilterCondition(
              property: 'useInVmi',
              conditionOperator: Operators.equals,
              value: 'TRUE',
            ),
            FilterCondition(
              property: 'code',
              conditionOperator: Operators.notEquals,
              value: 'PRIMARY',
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'endDate',
                  conditionOperator: Operators.equals,
                  value: '',
                ),
                ConditionCondition(
                  property: 'endDate',
                  conditionOperator: Operators.greaterThanEqual,
                  value: formatFullRestNotMilSec(_dt),
                ),
              ],
            ),
            FilterCondition(
              group: 'OR',
              conditions: [
                ConditionCondition(
                  property: 'company.code',
                  conditionOperator: Operators.equals,
                  value: 'empty',
                ),
              ],
            ),
          ],
        ),
        view: 'dicRelationshipType-browse',
      ),
      fromMap: (val) => AbstractDictionary.fromMap(val),
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<AbstractDictionary>();
  }

  static Future<List<TsadvPortalFeedback>> getFeedbackList(
      dynamic companiesList) async {
    var response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_PortalFeedback',
      filter: CubaEntityFilter(
        view: 'portalFeedback-portal',
        filter: Filter(
          conditions: <FilterCondition>[
            FilterCondition(
              property: 'company.id',
              conditionOperator: Operators.inList,
              value: await companiesList,
            ),
          ],
        ),
      ),
      fromMap: (Map<String, dynamic> json) {
        return TsadvPortalFeedback.fromMap(json);
      },
      type: Types.entities,
      methodName: 'search',
    ) as List;

    return response.cast<TsadvPortalFeedback>();
  }


  static Future<List<MyRecognition>> getRecognitionList() async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    final String body = '''
      {
      "personGroupId": "$id"
      }
      ''';
    final response = await Kinfolk.getListModelRest(
      serviceOrEntityName: 'tsadv_RecognitionPortalService',
      body: body,
      fromMap: (Map<String, dynamic> val)=> MyRecognition.fromMap(val),
      type: Types.services,
      methodName: 'loadUserMedals',
    ) as List;

    return response.cast<MyRecognition>();
  }
}
