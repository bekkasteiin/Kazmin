library kinfolk;

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:kinfolk/global_variables.dart';
// import 'package:kinfolk/service/rest_helper.dart';
// import 'package:kinfolk/service/utils.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/service/auth.dart';
import 'package:kzm/core/service/kinfolk/service/rest_helper.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';
// import 'package:oauth2/src/client.dart';
import 'package:kzm/core/service/oauth2/src/client.dart';

String libName = 'KIN';

class Kinfolk {
  /// A Calculator.
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  /// setting server url and security keys (identifier,secret)
  Future<void> initializeBaseVariables(String urlEndPoint, String identifier, String secret) async {
    GlobalVariables.urlEndPoint = urlEndPoint;
    GlobalVariables.identifier = identifier;
    GlobalVariables.secret = secret;
    await Hive.initFlutter();
  }

  /// getting client from saved Access Token
  static Future<Client> getClient() async => await Authorization().client;

  /// getting client (service with Access Token) in first time with login,password
  Future getToken(String login, String password) async => await Authorization().getAccessToken(login, password);

  /// getting getFileUrl
  static dynamic getFileUrl(String fileDescriptorId) => Authorization().getFileUrlByFileDescriptorId(fileDescriptorId);

  /// create Rest Url
  static String createRestUrl(String serviceName, String methodName, Types type) => Utils.createRestUrl(serviceName, methodName, type);

  /// getting list<dynamic> from REST
  static Future getListModelRest({
    @required String serviceOrEntityName,
    @required String methodName,
    @required Types type,
    String body,
    CubaEntityFilter filter,
    @required Function(Map<String, dynamic> json) fromMap,
  }) async {
    // log('-->> $fName, getListModelRest ->> headers: $appJsonHeader');
    // log('-->> $fName, serviceOrEntityName ->> serviceOrEntityName: $serviceOrEntityName');
    // log('-->> $fName, methodName ->> methodName: $methodName');
    // log('-->> $fName, methodName ->> type: $type');
    // log('-->> $fName, methodName ->> body: $body');
    // log('-->> $fName, methodName ->> filter: $filter');

    return await RestHelper().getListModelRest(
      serviceOrEntityName: serviceOrEntityName,
      methodName: methodName,
      type: type,
      fromMap: fromMap,
      filter: filter,
      body: body,
    );
  }

  ///  getting model from REST
  static Future getSingleModelRest({
    @required String serviceName,
    @required String methodName,
    @required Types type,
    String body,
    @required Function(Map<String, dynamic> json) fromMap,
  }) async =>
      await RestHelper().getSingleModelRest(
        serviceOrEntityName: serviceName,
        methodName: methodName,
        type: type,
        fromMap: fromMap,
        body: body,
      );

  ///  getting value from REST
  static Future getSingleValueRest({
    @required String serviceName,
    @required String methodName,
    @required Types type,
    String body,
  }) async =>
      await RestHelper().getSingleValueRest(
        serviceOrEntityName: serviceName,
        methodName: methodName,
        type: type,
        body: body,
      );

  static Map<String, String> get appJsonHeader {
    final Map<String, String> _data = <String, String>{
      'Content-Type': 'application/json',
      'Accept-Language': GlobalVariables.lang,
      'Authorization': 'Bearer ${GlobalVariables.token}',
    };
    // log('-->> $fName, appJsonHeader -->> _data: $_data');
    return _data;
  }
}
