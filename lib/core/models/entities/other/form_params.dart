import 'dart:convert';

class FormParams {
  String name;
  String value;
  String valueSource;

  FormParams({
    this.name,
    this.value,
    this.valueSource,
  });

  factory FormParams.fromJson(String str) {
    return FormParams.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory FormParams.fromMap(Map<String, dynamic> json) {
    return FormParams(
      name: json['name']?.toString(),
      value: json['value']?.toString(),
      valueSource: json['valueSource']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'valueSource': valueSource,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
