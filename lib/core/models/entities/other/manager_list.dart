import 'dart:convert';

class ManagerList {
  String fullName;

  ManagerList({
    this.fullName,
  });

  factory ManagerList.fromJson(String str) {
    return ManagerList.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory ManagerList.fromMap(Map<String, dynamic> json) {
    return ManagerList(
      fullName: json['fullName']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
