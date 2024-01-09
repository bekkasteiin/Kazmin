// To parse this JSON data, do
//
//     final myTeamNew = myTeamNewFromMap(jsonString);

import 'dart:convert';
import 'dart:developer';

const String fName = 'lib/core/models/my_team/my_team.dart';

class MyTeamNew {
  MyTeamNew({
    this.entityName,
    this.instanceName,
    this.id,
    this.gradeName,
    this.personGroupId,
    this.positionGroupId,
    this.organizationNameLang1,
    this.hasChild,
    this.fullName,
    this.positionNameLang1,
    this.linkEnabled,
    this.children,
  });

  String entityName;
  String instanceName;
  String id;
  String gradeName;
  String personGroupId;
  String positionGroupId;
  String organizationNameLang1;
  bool hasChild;
  String fullName;
  String positionNameLang1;
  bool linkEnabled;
  List<MyTeamNew> children;

  factory MyTeamNew.fromJson(String str) => MyTeamNew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyTeamNew.fromMap(Map<String, dynamic> json) {
    // log('-->> $fName, fromMap ->> json: $json');
    return MyTeamNew(
      children: json['children'] == null ? null : List<MyTeamNew>.from(json['children'].map((x) => MyTeamNew.fromMap(x))),
      entityName: json['_entityName'],
      instanceName: json['_instanceName'],
      id: json['id'],
      gradeName: json['gradeName'],
      personGroupId: json['personGroupId'],
      positionGroupId: json['positionGroupId'],
      organizationNameLang1: json['organizationNameLang1'],
      hasChild: json['hasChild'],
      fullName: json['fullName'],
      positionNameLang1: json['positionNameLang1'],
      linkEnabled: json['linkEnabled'],
    );
  }

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    'children': children == null
        ? null
        : List<dynamic>.from(children.map((MyTeamNew x) => x.toMap())),
    '_instanceName': instanceName,
    'id': id,
    'gradeName': gradeName,
    'personGroupId': personGroupId,
    'positionGroupId': positionGroupId,
    'organizationNameLang1': organizationNameLang1,
    'hasChild': hasChild,
    'fullName': fullName,
    'positionNameLang1': positionNameLang1,
    'linkEnabled': linkEnabled,
  };

  Map<String, dynamic> toMapForTree() => {
    'children': children == null
        ? []
        : List<MyTeamNew>.from(children.map((MyTeamNew x) => x.toMapForTree())),
    'id': id,
    'positionGroupId': positionGroupId,
    'hasChild': hasChild,
    'title': fullName,
  };
}
