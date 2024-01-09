import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/uploaded_file_response.dart';

// import 'package:kinfolk/global_variables.dart';
// import 'package:kinfolk/service/utils.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/provider/result_model.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';

const String fName = 'lib/core/service/provider/provider.dart';

// String kBaseURL = '$endpointUrl/rest/v2/';
Future<String> get kBaseURL async => '${await endpointUrlAsync}/rest/v2/';
// String kCleanURL = '$endpointUrl/';
Future<String> get kCleanURL async => '${await endpointUrlAsync}/';

class KzmProvider extends GetConnect {
  // dynamic _settings;

  @override
  bool get allowAutoSignedCert => true;

  @override
  void onInit() {
    httpClient.userAgent = Platform.operatingSystem;
    // httpClient.baseUrl = kBaseURL;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 8);
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.none:
            KzmSnackbar(message: 'Отсутствует соединение с интернетом'.tr, autoHide: false).show();
            //try to freeze app
            break;
          default:
            //try to unfreeze app
            while (Get.isSnackbarOpen) {
              Get.back();
            }
            while (Get.isDialogOpen) {
              Get.back();
            }
            break;
        }
      },
    );
  }

  Future<Map<String, String>> get headers async {
    final Map<String, String> _data = <String, String>{
      if (GlobalVariables.token != null) 'Authorization': 'Bearer ${GlobalVariables.token}',
      'Accept-Language': GlobalVariables.lang,
    };
    // log('-->> $fName, headers -->> _data: $_data');
    return _data;
  }

  Future<KzmApiResult> reqPostMap({
    @required String url,
    @required Map<String, dynamic> body,
    @required Function({@required dynamic data}) map,
    bool checkConnection = true,
    bool changeEndpoint = false,
  }) async {
    try {
      httpClient.baseUrl = await kBaseURL;
      final KzmApiResult _result = KzmApiResult(statusCode: 0, statusText: null, result: null);
      if (checkConnection && (!await RestServices.checkConnection())) {
        _result.statusText = 'reqPostMap, checkConnection is false';
        return _result;
      }
      Response<dynamic> response;
      try {
        if (changeEndpoint) httpClient.baseUrl = await kCleanURL;
        response = await post(
          url,
          json.encode(body),
          headers: await headers,
        );
      } catch (e, s) {
        _result.statusText = 'reqPostMap, post error: $e, stackTrace: $s';
        return _result;
      } finally {
        if (changeEndpoint) httpClient.baseUrl = await kBaseURL;
      }

      if (response.isOk) {
        try {
          _result.statusCode = response.statusCode ?? 0;
          _result.statusText = null;
          _result.bodyString = response.bodyString;
          _result.result = map(data: json.decode(response.bodyString));
          return _result;
        } catch (e, s) {
          log('-->> $fName, reqPostMap, $url NOT OK!!!', error: e, stackTrace: s);
          log('-->> $fName, reqPostMap -->> response.isNotOk, _result.statusCode: ${_result.statusCode}, possibly it is not in JSON-format');
          log('-->> $fName, reqPostMap -->> response.bodyString: ${response.bodyString}');
          _result.statusText = 'reqPostMap, _result preparing error, possibly it is not in JSON-format';
          return _result;
        }
      } else {
        _result.statusCode = response.statusCode ?? 0;
        _result.bodyString = response.bodyString;
        _result.statusText = 'reqPostMap, response http code is not Ok';
        log(
          '-->> $fName, reqPostMap -->> response error'
          '\nurl: ${httpClient.baseUrl}$url '
          '\nbody: ${json.encode(body)} '
          '\nstatusCode: ${_result.statusCode ?? 0} '
          '\nstatusText: ${_result.statusText} '
          '\nbodyString: ${_result.bodyString} ',
        );
        return _result;
      }
    } finally {}
  }

  Future<KzmApiResult> reqGetMap({
    @required String url,
    @required Map<String, dynamic> query,
    @required Function({@required dynamic data}) map,
    bool changeEndpoint = false,
  }) async {
    httpClient.baseUrl = await kBaseURL;
    final KzmApiResult _result = KzmApiResult(statusCode: 0, statusText: null, result: null);

    if (!await RestServices.checkConnection()) {
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusText = 'reqGetMap, checkConnection is false';
      log('-->> $fName, reqGetMap -->> checkConnection == false');
      return _result;
    }

    Response<dynamic> response;
    try {
      if (changeEndpoint) httpClient.baseUrl = await kCleanURL;
      // log('-->> $fName, reqGetMap ->> baseUrl: ${httpClient.baseUrl}');
      // log('-->> $fName, reqGetMap ->> url: $url');
      // log('-->> $fName, reqGetMap ->> query: $query');
      // log('-->> $fName, reqGetMap ->> headers: ${await headers}');
      response = await get(
        url,
        query: query,
        headers: await headers,
      );
    } catch (e, s) {
      log('-->> $fName, reqGetMap, $url NOT OK!!!', error: e, stackTrace: s);
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusText = 'reqGetMap, get error: $e, stackTrace: $s';
      return _result;
    } finally {
      if (changeEndpoint) httpClient.baseUrl = await kBaseURL;
    }

    // log(
    //   '\n-------- $fName, GET -------- beg\n'
    //   '{\n'
    //   '"url": "$url",\n'
    //   '"query": $query,\n'
    //   '"response": ${response.bodyString}\n'
    //   '}\n'
    //   '-------- $fName, GET -------- end\n',
    // );

    if (response.isOk) {
      try {
        _result.statusCode = response.statusCode ?? 0;
        _result.statusText = null;
        _result.bodyString = response.bodyString;
        _result.result = map(data: jsonDecode(response.bodyString));
        return _result;
      } catch (e, s) {
        log('-->> $fName, reqGetMap, response.isOk, $url NOT OK!!!', error: e, stackTrace: s);
        log('-->> $fName, reqGetMap -->> response.isNotOk, _result.statusCode: ${_result.statusCode}, possibly it is not in JSON-format');
        _result.statusText = 'reqGetMap, _result preparing error, possibly it is not in JSON-format';
        return _result;
      }
    } else {
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusCode = response.statusCode ?? 0;
      _result.bodyString = response.bodyString;
      _result.statusText = 'reqGetMap, response http code is not Ok';
      log(
        '-->> $fName, reqGetMap -->> response error'
        '\nurl: $url '
        '\nstatusCode: ${_result.statusCode ?? 0} '
        '\nstatusText: ${_result.statusText} '
        '\nbodyString: ${_result.bodyString} ',
      );
      return _result;
    }
  }

  void setBusy({bool busy}) {
    while (Get.isDialogOpen) {
      Get.back();
    }
    if (busy) Get.dialog(const LoaderWidget(isPop: true));
  }

  Future<KzmApiResult> _uploadFile({@required File file}) async {
    httpClient.baseUrl = await kBaseURL;
    final KzmApiResult _result = KzmApiResult(statusCode: 0, statusText: null, result: null);
    final String _fileName = file.path.split('/').last;
    final String _snackBarMessage = 'Ошибка загрузки файла\n"@fName"'.trParams(
      <String, String>{
        'fName': _fileName,
      },
    );
    const int _delay = 3000;

    if (!await RestServices.checkConnection()) {
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusText = 'uploadFile, checkConnection is false';
      log('-->> $fName, uploadFile -->> checkConnection == false');
      return _result;
    }

    http.StreamedResponse response;
    try {
      final String url = '${httpClient.baseUrl}files?name=$_fileName';
      final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(await headers);
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );
      response = await request.send();
    } catch (e, s) {
      log('-->> $fName, uploadFile -->> ', error: e, stackTrace: s);
      await KzmSnackbar(message: _snackBarMessage, milliSeconds: _delay).show();
      _result.statusText = 'uploadFile, send error: $e, stackTrace: $s';
      return _result;
    }

    if (!(200 <= response.statusCode && response.statusCode < 300)) {
      _result.bodyString = await response.stream.bytesToString();
      log(
        '-->> $fName, uploadFile -->> response error'
        '\nstatusCode: ${response.statusCode ?? 0} '
        '\nstatusText: '
        '\nbodyString: ${_result.bodyString} ',
      );
      await KzmSnackbar(message: _snackBarMessage, milliSeconds: _delay).show();
      _result.statusCode = response.statusCode ?? 0;
      _result.statusText = 'uploadFile, response http code is not Ok';
      return _result;
    }

    try {
      final dynamic data = jsonDecode(await response.stream.bytesToString());
      _result.statusCode = response.statusCode ?? 0;
      _result.statusText = null;
      _result.result = KzmUploadedFileResponse.fromMap(json: data as Map<String, dynamic>);
    } catch (e, s) {
      log('-->> $fName, uploadFile -->> _result preparing error', error: e, stackTrace: s);
      await KzmSnackbar(message: _snackBarMessage, milliSeconds: _delay).show();
      _result.statusText = 'uploadFile, _result preparing error';
      return _result;
    }

    return _result;
  }

  Future<List<SysFileDescriptor>> uploadFiles({@required List<SysFileDescriptor> files}) async {
    final List<SysFileDescriptor> _tmp = <SysFileDescriptor>[];
    KzmApiResult resp;
    for (int i = 0; i < files.length; i++) {
      if ((files[i].id ?? '').isEmpty) {
        resp = await _uploadFile(file: files[i].file);
        if ((resp.result != null) && (resp.result is KzmUploadedFileResponse)) {
          _tmp.add(files[i]..id = (resp.result as KzmUploadedFileResponse).id);
          // files[i].id = (resp.result as KzmUploadedFileResponse).id;
        }
      } else {
        _tmp.add(files[i]);
      }
    }
    return _tmp;
  }

  Future<KzmApiResult> reqPutMap({
    @required String url,
    @required Map<String, dynamic> body,
    @required Function({@required dynamic data}) map,
    bool checkConnection = true,
    bool changeEndpoint = false,
  }) async {
    httpClient.baseUrl = await kBaseURL;
    //remove if not necessary
    // await Future<void>.delayed(const Duration(milliseconds: 200));

    final KzmApiResult _result = KzmApiResult(statusCode: 0, statusText: null, result: null);
    if (checkConnection && (!await RestServices.checkConnection())) {
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusText = 'reqPutMap, checkConnection is false';
      log('-->> $fName, reqPutMap -->> checkConnection == false');
      return _result;
    }

    Response<dynamic> response;
    try {
      if (changeEndpoint) httpClient.baseUrl = await kCleanURL;
      response = await put(
        url,
        json.encode(body),
        headers: await headers,
      );
    } catch (e, s) {
      log('-->> $fName, reqPutMap, $url NOT OK!!!', error: e, stackTrace: s);
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusText = 'reqPutMap, post error: $e, stackTrace: $s';
      return _result;
    } finally {
      if (changeEndpoint) httpClient.baseUrl = await kBaseURL;
    }

    // log(
    //   '\n-------- $fName, PUT -------- beg\n'
    //   '{\n'
    //   '"url": "$url",\n'
    //   '"body": ${json.encode(body)},\n'
    //   '"response": ${response.bodyString}\n'
    //   '}\n'
    //   '-------- $fName, PUT -------- end\n',
    // );

    if (response.isOk) {
      try {
        _result.statusCode = response.statusCode ?? 0;
        _result.statusText = null;
        _result.bodyString = response.bodyString;
        _result.result = map(data: json.decode(response.bodyString));
        return _result;
      } catch (e, s) {
        log('-->> $fName, reqPutMap, $url NOT OK!!!', error: e, stackTrace: s);
        log('-->> $fName, reqPutMap -->> response.isNotOk, _result.statusCode: ${_result.statusCode}, possibly it is not in JSON-format');
        log('-->> $fName, reqPutMap -->> response.bodyString: ${response.bodyString}');
        _result.statusText = 'reqPutMap, _result preparing error, possibly it is not in JSON-format';
        return _result;
      }
    } else {
      // await KzmSnackbar(message: 'Ошибка обращения к серверу'.tr, autoHide: true).show();
      _result.statusCode = response.statusCode ?? 0;
      _result.bodyString = response.bodyString;
      _result.statusText = 'reqPutMap, response http code is not Ok';
      log(
        '-->> $fName, reqPutMap -->> response error'
        '\nurl: $url '
        '\nbody: ${json.encode(body)} '
        '\nstatusCode: ${response.statusCode ?? 0} '
        '\nstatusText: ${response.statusText} '
        '\nbodyString: ${response.bodyString} ',
      );
      return _result;
    }
  }
}
