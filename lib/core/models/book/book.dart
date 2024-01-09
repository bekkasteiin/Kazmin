// To parse this JSON data, do
//
//     final bookRequest = bookRequestFromMap(jsonString);

import 'dart:convert';

class BookRequest {
  BookRequest({
    this.entityName,
    this.instanceName,
    this.id,
    this.language,
    this.bookDescriptionLang1,
    this.averageScore,
    this.reviews,
    this.authorLang1,
    this.pdf,
    this.bookNameLang1,
  });

  String entityName;
  String instanceName;
  String id;
  String language;
  String bookDescriptionLang1;
  num averageScore;
  List<Review> reviews;
  String authorLang1;
  Pdf pdf;
  String bookNameLang1;

  factory BookRequest.fromJson(String str) => BookRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookRequest.fromMap(Map<String, dynamic> json) => BookRequest(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    language: json['language'],
    bookDescriptionLang1: json['bookDescriptionLang1'],
    averageScore: json['averageScore'],
    reviews: json['reviews'] == null ? null : List<Review>.from(json['reviews'].map((x) => Review.fromMap(x))),
    authorLang1: json['authorLang1'],
    pdf: json['pdf'] == null ? null : Pdf.fromMap(json['pdf']),
    bookNameLang1: json['bookNameLang1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'language': language,
    'bookDescriptionLang1': bookDescriptionLang1,
    'averageScore': averageScore,
    'reviews': reviews == null ? null : List<dynamic>.from(reviews.map((Review x) => x.toMap())),
    'authorLang1': authorLang1,
    'pdf': pdf == null ? null : pdf.toMap(),
    'bookNameLang1': bookNameLang1,
  };
}

class Pdf {
  Pdf({
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

  factory Pdf.fromJson(String str) => Pdf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pdf.fromMap(Map<String, dynamic> json) => Pdf(
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

class Review {
  Review({
    this.entityName,
    this.id,
    this.rating,
    this.reviewText,
  });

  String entityName;
  String id;
  num rating;
  String reviewText;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    entityName: json['_entityName'],
    id: json['id'],
    rating: json['rating'],
    reviewText: json['reviewText'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    'id': id,
    'rating': rating,
    'reviewText': reviewText,
  };
}
