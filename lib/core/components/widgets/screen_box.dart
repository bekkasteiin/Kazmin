import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KzmScreenBox extends StatelessWidget {
  final Widget child;
  final int appBarHeight;

  const KzmScreenBox({@required this.child, @required this.appBarHeight}) : super();

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQueryData.fromWindow(window).padding.top;
    return Container(
      padding: appBarHeight == 0 ? EdgeInsets.only(top: topPadding) : EdgeInsets.zero,
      width: Get.width,
      height: Get.height - appBarHeight - (appBarHeight == 0 ? 0 : topPadding),
      child: child,
    );
  }
}
