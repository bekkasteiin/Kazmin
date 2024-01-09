import 'dart:convert';
import 'dart:developer';

// import 'package:kinfolk/kinfolk.dart';
// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
// import 'package:kinfolk/service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/src/response.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/service/auth.dart';
// import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:kzm/core/service/oauth2/oauth2.dart' as oauth2;

const String fName = 'lib/core/service/kinfolk/service/rest_helper.dart';

class RestHelper {
  Future getSingleModelRest({
    @required String serviceOrEntityName,
    @required String methodName,
    @required Types type,
    String body,
    @required Function(Map<String, dynamic> json) fromMap,
  }) async {
    final String urlStr = Kinfolk.createRestUrl(serviceOrEntityName, methodName, type);
    final oauth2.Client client = await Authorization().client;
    final Uri url = Uri.parse(urlStr);

    // log('-->> $fName, getSingleModelRest ->> url: $url');
    // log('-->> $fName, getSingleModelRest ->> body: $body');

    Response response;

    if (body != null) {
      response = await getPostResponse(url: url, body: body, client: client);
    } else {
      response = await getGetResponse(url: url, client: client);
    }

    final String respBody = response.body;
    if (respBody.runtimeType == String && respBody.isEmpty) return null;

    final source = jsonDecode(respBody);
    assert(source is Map, 'Response is ${source.toString()}');

    return fromMap(source);
  }

  Future getSingleValueRest({
    @required String serviceOrEntityName,
    @required String methodName,
    @required Types type,
    String body,
  }) async {
    final String urlStr = Kinfolk.createRestUrl(serviceOrEntityName, methodName, type);
    final oauth2.Client client = await Authorization().client;
    final Uri url = Uri.parse(urlStr);

    Response response;

    if (body != null) {
      response = await getPostResponse(url: url, body: body, client: client);
    } else {
      response = await getGetResponse(url: url, client: client);
    }

    final String respBody = response.body;
    if (respBody.runtimeType == String && respBody.isEmpty) return null;

    final source = jsonDecode(respBody);

    return source;
  }

  Future getListModelRest({
    @required String serviceOrEntityName,
    @required String methodName,
    @required Types type,
    String body,
    @required Function(Map<String, dynamic> json) fromMap,
    CubaEntityFilter filter,
  }) async {
    final Uri url = Uri.parse(Kinfolk.createRestUrl(serviceOrEntityName, methodName, type));
    final oauth2.Client client = await Authorization().client;

    Response response;

    // log('-->> $fName, getListModelRest ->> url: $url');
    // log('-->> $fName, getListModelRest ->> body: $body');
    // log('-->> $fName, getListModelRest ->> filter: ${filter?.toJson()}');
    if (filter != null) {
      assert(type == Types.entities, 'Filter can be used only with Types.entities');
      response = await getPostResponse(url: url, body: filter.toJson(), client: client);
    } else {
      if (body != null) {
        response = await getPostResponse(url: url, body: body, client: client);
      } else {
        response = await getGetResponse(url: url, client: client);
      }
    }
    final String respBody = response.body;
    if (respBody.runtimeType == String && respBody.isEmpty) return null;

    final source = jsonDecode(respBody);
    assert(source is List, 'Response is' + '\n$respBody');

    return source.map((item) => fromMap(item)).toList();
  }

  Future<Response> getPostResponse({@required url, @required body, @required oauth2.Client client}) async {
    // log('-->> $fName, getPostResponse ->> url: $url');
    // log('-->> $fName, getPostResponse ->> body: $body');
    // log('-->> $fName, getPostResponse ->> headers: ${Kinfolk.appJsonHeader}');
    // log('-->> $fName, getPostResponse ->> client credentials: ${client.credentials.toJson()}');

    return await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
  }

  Future<Response> getGetResponse({@required url, @required oauth2.Client client}) async => await client.get(url, headers: Kinfolk.appJsonHeader);
}
