
import 'dart:developer';

import 'package:flutter/cupertino.dart';
// import 'package:kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';

const String fName = 'lib/core/models/advert_model.dart';

class KzmAdModel {
  final String topic;
  final String imageURL;
  final String gotoURL;
  final String newsTextRu;

  KzmAdModel({@required this.topic, @required this.imageURL, @required this.gotoURL, this.newsTextRu});

  factory KzmAdModel.fromMap({@required Map<String, dynamic> json}) {

    // log('-->> $fName, fromMap ->> topic: ${json['_instanceName']}');
    // log('-->> $fName, fromMap ->> imageURL: ${json['imageRu']['id']}');
    // log('-->> $fName, fromMap ->> gotoURL: ${json['urlRu']}');
    // log('-->> $fName, fromMap ->> newsTextRu: ${json['newsTextRu']}');
    return KzmAdModel(
      topic: json['_instanceName'] as String,
      imageURL: json['imageRu']['id'] as String,
      gotoURL: json['urlRu'] as String,
      newsTextRu: json['newsTextRu'] as String,
    );
  }
}
