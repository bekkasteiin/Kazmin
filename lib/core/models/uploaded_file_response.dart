import 'package:flutter/cupertino.dart';

class KzmUploadedFileResponse {
  final String id;
  final String name;
  final int size;

  const KzmUploadedFileResponse({
    @required this.id,
    @required this.name,
    @required this.size,
  });

  factory KzmUploadedFileResponse.fromMap({@required Map<String, dynamic> json}) {
    return KzmUploadedFileResponse(
      id: json['id'].toString(),
      name: json['name'].toString(),
      size: int.parse(json['size'].toString()),
    );
  }
}
