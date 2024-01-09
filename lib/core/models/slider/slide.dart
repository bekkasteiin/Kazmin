import 'dart:convert';

class SliderInfoRequest {
  SliderInfoRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.image,
    this.url,
    this.order,
  });

  String entityName;
  String instanceName;
  String id;
  Image image;
  String url;
  int order;

  factory SliderInfoRequest.fromJson(String str) => SliderInfoRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SliderInfoRequest.fromMap(Map<String, dynamic> json) => SliderInfoRequest(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    image: json['image'] == null ? null : Image.fromMap(json['image']),
    url: json['url'],
    order: json['order'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'image': image == null ? null : image.toMap(),
    'url': url,
    'order': order,
  };
}

class Image {
  Image({
    this.entityName,
    this.instanceName,
    this.id,
    this.extension,
    this.name,
    this.createDate,
  });

  String entityName;
  String instanceName;
  String id;
  String extension;
  String name;
  DateTime createDate;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    extension: json['extension'],
    name: json['name'],
    createDate: json['createDate'] == null ? null : DateTime.parse(json['createDate']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'extension': extension,
    'name': name,
    'createDate': createDate == null ? null : createDate.toIso8601String(),
  };
}
