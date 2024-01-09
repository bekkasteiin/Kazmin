// To parse this JSON data, do
//
//     final dicBookCategory = dicBookCategoryFromMap(jsonString);

import 'dart:convert';

class DicBookCategory {
  DicBookCategory({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue3,
    this.books,
    this.langValue2,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  String langValue3;
  List<Book> books;
  String langValue2;
  String langValue1;

  factory DicBookCategory.fromJson(String str) => DicBookCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DicBookCategory.fromMap(Map<String, dynamic> json) => DicBookCategory(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    langValue3: json['langValue3'],
    books: json['books'] == null ? null : List<Book>.from(json['books'].map((x) => Book.fromMap(x))),
    langValue2: json['langValue2'],
    langValue1: json['langValue1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'langValue3': langValue3,
    'books': books == null ? null : List<dynamic>.from(books.map((Book x) => x.toMap())),
    'langValue2': langValue2,
    'langValue1': langValue1,
  };
}

class Book {
  Book({
    this.entityName,
    this.instanceName,
    this.id,
    this.image,
    this.pdf,
    this.bookNameLang1,
    this.category,
  });

  String entityName;
  String instanceName;
  String id;
  Image image;
  Image pdf;
  String bookNameLang1;
  Category category;

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    image: json['image'] == null ? null : Image.fromMap(json['image']),
    pdf: json['pdf'] == null ? null : Image.fromMap(json['pdf']),
    bookNameLang1: json['bookNameLang1'],
    category: json['category'] == null ? null : Category.fromMap(json['category']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'image': image == null ? null : image.toMap(),
    'pdf': pdf == null ? null : pdf.toMap(),
    'bookNameLang1': bookNameLang1,
    'category': category == null ? null : category.toMap(),
  };
}

class Category {
  Category({
    this.entityName,
    this.instanceName,
    this.id,
  });

  String entityName;
  String instanceName;
  String id;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
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
