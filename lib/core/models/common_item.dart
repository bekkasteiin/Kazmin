import 'dart:convert';

import 'package:flutter/cupertino.dart';

class KzmCommonItem {
  String text;
  final String id;

  KzmCommonItem({@required this.id, this.text = ''});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is KzmCommonItem && runtimeType == other.runtimeType && text == other.text && id == other.id;

  @override
  int get hashCode => text.hashCode ^ id.hashCode;

  factory KzmCommonItem.fromJson(String str) {
    return KzmCommonItem.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory KzmCommonItem.fromMap(Map<String, dynamic> json) {
    return KzmCommonItem(
      id: json['id']?.toString(),
      text: json['text']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
