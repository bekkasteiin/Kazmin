import 'dart:convert';

class BaseResult {
  bool success;
  String errorDescription;

  BaseResult({
    this.success,
    this.errorDescription,
  });

  factory BaseResult.fromJson(String str) =>
      BaseResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BaseResult.fromMap(Map<String, dynamic> json) => BaseResult(
        success: json['success'] ?? json['status'] == 'SUCCESS',
        errorDescription: json['errorDescription'] ?? json['message'],
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'errorDescription': errorDescription,
      };
}
