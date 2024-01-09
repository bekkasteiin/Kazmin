import 'package:flutter/material.dart';

class KzmTab extends Tab {
  KzmTab({
    @required String text,
  }) : super(
          child: Text(text, textAlign: TextAlign.center),
        );
}
