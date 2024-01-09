import 'package:flutter/material.dart';
import 'package:kzm/core/models/linked_user.dart';

class UserInfoByIIN {
  final String personID;
  final String mobilePhone;
  String nationalIdentifier = '';
  KzmLinkedUser linkedUser;
  String login = '';
  bool smsSent = false;

  UserInfoByIIN({
    @required this.personID,
    @required this.mobilePhone,
  });

  factory UserInfoByIIN.fromJSON(Map<String, dynamic> json) {
    return UserInfoByIIN(
      personID: (json['id'] ?? '').toString(),
      mobilePhone: (json['mobilePhone'] ?? '').toString(),
    );
  }

  bool get isEmpty => personID.isEmpty;
}
