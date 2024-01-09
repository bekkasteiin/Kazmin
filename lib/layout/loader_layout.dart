import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

class LoaderWidget extends StatelessWidget {
  final bool isPop;

  const LoaderWidget({
    Key key,
    this.isPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isPop ? Styles.appWhiteColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(
                radius: 10,
              )
            /*: CircularProgressIndicator(
                strokeWidth: 5.0,
                color: Styles.appPrimaryColor,
                backgroundColor: Styles.appWhiteColor,
                // valueColor:
              ),*/
            : const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Styles.appCorporateColor,
                backgroundColor: Colors.transparent,
                // valueColor:
              ),
      ),
    );
  }
}
