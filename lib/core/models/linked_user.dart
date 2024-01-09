import 'package:flutter/material.dart';

class KzmLinkedUser {
  String login;
  bool isActive;

  KzmLinkedUser({
    @required this.login,
    @required this.isActive,
  });

  factory KzmLinkedUser.fromJSON(Map<String, dynamic> json) {
    return KzmLinkedUser(
      login: (json['login'] ?? '').toString(),
      isActive: json['active'] as bool ?? false,
    );
  }
}
