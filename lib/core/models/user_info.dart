import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromMap(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toMap());

class UserInfo {
  String id;
  String imageId;
  String login;
  String name;
  String password;
  String pin;
  String firstName;
  String middleName;
  String lastName;
  String position;
  String email;
  String timeZone;
  String language;
  String instanceName;
  String locale;

  UserInfo(
      {this.id,
      this.login,
      this.imageId,
      this.name,
      this.firstName,
      this.middleName,
      this.lastName,
      this.position,
      this.email,
      this.timeZone,
      this.language,
      this.instanceName,
      this.locale,
      this.password,
      this.pin,});

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json['id'],
        login: json['login'],
        name: json['name'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        position: json['position'],
        email: json['email'],
        timeZone: json['timeZone'],
        language: json['language'],
        instanceName: json['_instanceName'],
        locale: json['locale'],
        password: json['password'],
        pin: json['pin'],
        imageId: json['imageId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'login': login,
        'imageId': imageId,
        'name': name,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'position': position,
        'email': email,
        'timeZone': timeZone,
        'language': language,
        '_instanceName': instanceName,
        'locale': locale,
        'password': password,
        'pin': pin,
      };
}
