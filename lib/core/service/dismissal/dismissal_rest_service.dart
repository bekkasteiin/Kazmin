import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/entities/tsadv_tsadv_report.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/dismissal/responses.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/provider/provider.dart';
import 'package:kzm/core/service/provider/result_model.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_request.dart';
import 'package:kzm/core/service/oauth2/oauth2.dart' as oauth2;
import 'package:path_provider/path_provider.dart';
import 'package:kzm/core/models/entities/report_report_template.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/generated/l10n.dart';

import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_request.dart';

const String fName = 'lib/core/service/dismissal/dismissal_rest_service.dart';

class DismissalRestServices {
  final KzmProvider _api = Get.find<KzmProvider>();

  Future<List<DismissalRequest>> getDismissals({
    @required DismissalRequest request,
    @required String login,
    String entityName,
    String view,
  }) async {
    // log('-->> $fName, getAbsenceRvds ->> entity: ${request.getEntityName}');
    if (!(await checkConnection())) return <DismissalRequest>[];
    final String pgId = await HiveUtils.getPgId();
    log('PGID:$pgId');

    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_DismissalService/getDismissalRequest',
      body: <String, dynamic>{
        'personGroupId': pgId,
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>)
            .map((dynamic e) =>
            DismissalRequest.fromMap(e as Map<String, dynamic>)).toList();
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
    return (resp.result ?? <DismissalRequest>[])
    as List<DismissalRequest>;
  }

  ///
  ///
  Future<Responses> getDismissal({
    //@required DismissalRequest request,
    //@required String login,
    //String entityName,
    String view,
  }) async {
    // log('-->> $fName, getAbsenceRvds ->> entity: ${request.getEntityName}');
    //if (!(await checkConnection())) return null;
    final String pgId = await HiveUtils.getPgId();
    //log('PGID:$pgId');

    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_DismissalService/getDismissalRequest',
      body: <String, dynamic>{
        'personGroupId': pgId,
      },
      map: ({dynamic data}) {
        log('DataOutput:${data['id']}');
        return data['id'].toString();
        //return (data as dynamic)
        //    .map((dynamic e) =>
        //    DismissalRequest.fromMap(e as Map<String, dynamic>));
      },
    );

    //log('StatusCode:${resp.statusCode}');

    // return (map ?? <AbsenceNewRvdRequest>[]) as List<AbsenceNewRvdRequest>;
    // (resp.result as List<AbsenceNewRvdRequest>).forEach((element) {log('-->> $fName, getAbsenceRvds ->> result: ${element.toJson()}');});
    return Responses(resp.statusCode,resp.result.toString()); resp.result as String;
  }
  ///
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
        '$dir/${_template?.first?.name}';
    try {
      // final String myUrl = '$endpointUrl/rest/reports/v1/run/${_report?.id}';
      final String myUrl =
          '${await endpointUrlAsync}/rest/reports/v1/run/${_report?.id}';
      log('ReportID:${_report?.id}');
      log('FilePattern:${_template?.first?.outputNamePattern}');
      log('Template:${_template?.first?.name}');

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

        log('Success...');
        final Uint8List bytes =
        await consolidateHttpClientResponseBytes(response);
        log('FilePath:$filePath');
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

}