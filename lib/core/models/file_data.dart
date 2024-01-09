import 'dart:io';

import 'package:flutter/cupertino.dart';

class KzmFileData {
  String id;
  final File file;

  KzmFileData({@required this.file, this.id = ''});
}
