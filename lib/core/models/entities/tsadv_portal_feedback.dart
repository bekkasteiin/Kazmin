import 'dart:convert';

class TsadvPortalFeedback {
  String entityName;
  String instanceName;
  String email;
  String id;
  int version;

  TsadvPortalFeedback({
    this.entityName,
    this.instanceName,
    this.email,
    this.id,
    this.version,
  });

  factory TsadvPortalFeedback.fromJson(String str) {
    return TsadvPortalFeedback.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory TsadvPortalFeedback.fromMap(Map<String, dynamic> json) {
    return TsadvPortalFeedback(
      entityName: json['_entityName']?.toString(),
      instanceName: json['_instanceName']?.toString(),
      email: json['email']?.toString(),
      id: json['id']?.toString(),
      version: json['version'] == null ? null : int.parse(json['version'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_entityName': entityName,
      '_instanceName': instanceName,
      'email': email,
      'id': id,
      'version': version,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
