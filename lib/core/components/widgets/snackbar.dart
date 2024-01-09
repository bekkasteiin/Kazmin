
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';

const String fName = 'lib/core/components/widgets/snackbar.dart';

class KzmSnackbar {
  final String message;
  final bool autoHide;
  final int milliSeconds;
  Duration short;
  final Duration long = const Duration(days: 1);

  KzmSnackbar({
    @required this.message,
    this.autoHide = true,
    this.milliSeconds = 1500,
  }) {
    short = Duration(milliseconds: milliSeconds);
  }

  Future<void> show() async {
    // while (Get.isSnackbarOpen || Get.isDialogOpen) {
    //   Get.back();
    // }
    Get.rawSnackbar(
      backgroundColor: Styles.appGrayColor,
      messageText: Container(
        alignment: Alignment.center,
        child: Text(message, style: Styles.cardTS, textAlign: TextAlign.center),
      ),
      snackPosition: SnackPosition.TOP,
      duration: autoHide ? short : long,
      isDismissible: false,
      padding: EdgeInsets.all(Styles.appQuadMargin),
      snackStyle: SnackStyle.GROUNDED,
    );
    await Future<Duration>.delayed(autoHide ? short : long);
  }
}
