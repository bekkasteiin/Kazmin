import 'package:flutter/cupertino.dart';

class KzmApiResult {
  int statusCode;
  String statusText;
  String bodyString;
  dynamic result;

  bool get isOk => 200 <= statusCode && statusCode < 300;

  KzmApiResult({
    @required this.statusCode,
    @required this.statusText,
    this.bodyString,
    this.result,
  });
}
