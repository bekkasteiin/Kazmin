import 'dart:developer' as dev;
import 'dart:io';

import 'package:hive/hive.dart';

// import 'package:kinfolk/global_variables.dart';
// import 'package:kinfolk/kinfolk.dart';
// import 'package:kinfolk/service/utils.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';

// import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:kzm/core/service/oauth2/oauth2.dart' as oauth2;

/// @author yeras-is
class Authorization {
  oauth2.Client _client;

  Future<oauth2.Client> get client async {
    if (_client != null) return _client;
    // if _client is null we instantiate it
    _client = await getFromSavedCredentials();
    return _client;
  }

  Future<Object> getAccessToken(String username, String password) async {
    // final Uri authorizationEndpoint = Uri.parse('${GlobalVariables.urlEndPoint}/rest/v2/oauth/token?');
    final Uri authorizationEndpoint = Uri.parse('${GlobalVariables.urlEndPoint}/rest/auth/token?');

    try {
      _client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint,
        username,
        password,
        identifier: GlobalVariables.identifier,
        secret: GlobalVariables.secret,
        additionalHeaders: <String, String>{'Accept-Language': GlobalVariables.lang},
      );
    } on SocketException catch (e) {
      dev.log('Socket Exception', name: libName, error: e);
      return GlobalVariables.connectionTimeCode;
    } on oauth2.AuthorizationException catch (e) {
      dev.log('Auth Exception', name: libName, error: e);
      return GlobalVariables.accessErrorCode;
    } on FormatException catch (e) {
      dev.log('Format Exception', name: libName, error: e);
      return e.message;
    } on HandshakeException catch (e) {
      dev.log('Socket Exception', name: libName, error: e);
      return e.toString();
    }
    GlobalVariables.token = _client.credentials.accessToken;

    final Box box = await Hive.openBox('credentials');
    box.put('json', _client.credentials.toJson());
    return _client;
  }

  Future<Object> getFromSavedCredentials() async {
    final Box box = await HiveService.getBox('credentials');
    final json = box.get('json');

    // If the OAuth2 credentials have already been saved from a previous run, we
    // just want to reload them.
    if (json != null) {
      final oauth2.Credentials credentials = oauth2.Credentials.fromJson(json);
      try {
        _client = oauth2.Client(credentials, identifier: GlobalVariables.identifier, secret: GlobalVariables.secret);
      } on SocketException catch (e) {
        dev.log('Socket Exception', name: libName, error: e);
        return GlobalVariables.connectionTimeCode;
      } on oauth2.AuthorizationException catch (e) {
        dev.log('Auth Exception', name: libName, error: e);
        return GlobalVariables.accessErrorCode;
      } on FormatException catch (e) {
        dev.log('Format Exception', name: libName, error: e);
        return e.message;
      }
      GlobalVariables.token = _client.credentials.accessToken;
      return _client;
    } else {
      return null;
    }
  }

  String getFileUrlByFileDescriptorId(String fileDescriptorId) =>
      '${GlobalVariables.urlEndPoint}/rest/v2/files/$fileDescriptorId?access_token=${GlobalVariables.token}';
}
