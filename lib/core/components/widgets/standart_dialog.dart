import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmStandartDialog {
  final BuildContext context;
  final Widget content;

  KzmStandartDialog({
    @required this.context,
    @required this.content,
  });

  Future<void> show() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: paddingLRBT,
          contentPadding: paddingLRBT,
          content: content,
        );
      },
    );
  }
}
