import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmOutlinedWhiteButton extends StatelessWidget {
  final String caption;
  final bool enabled;
  final bool infinityWidth;
  final void Function() onPressed;
  final bool shimmer;

  const KzmOutlinedWhiteButton({
    @required this.caption,
    @required this.enabled,
    this.infinityWidth,
    this.onPressed,
    this.shimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    final Text text = Text(
      caption,
      style: TextStyle(
        color: enabled ? Styles.appCorporateColor : Styles.appDarkGrayColor,
      ),
    );
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Styles.appBackgroundColor,
        minimumSize: Size((infinityWidth ?? true) ? double.infinity : 0, Styles.appButtonHeight),
      ),
      onPressed: enabled ? onPressed : null,
      child: shimmer ? KzmShimmer(child: text) : text,
    );
  }
}
