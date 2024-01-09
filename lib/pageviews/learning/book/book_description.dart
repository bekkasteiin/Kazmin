import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kzm/core/models/book/book.dart';

class BookDescription extends StatefulWidget {
  final BookRequest book;

  const BookDescription(this.book);


  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    String description = widget?.book?.bookDescriptionLang1;
    description ??= '';
    return GestureDetector(
      onTap: (){
        setState(() {
          isFull = !isFull;
        });
      },
      child: Html(
        data: isFull
            ? description
            : ('${description.substring(0, description.length ~/ 12)}...'),
      ),
    );
  }
}
