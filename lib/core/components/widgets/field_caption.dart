import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/components/widgets/text.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmFieldCaption extends StatelessWidget {
  final String caption;
  final bool isRequired;
  final bool isExpanded;
  final bool isLoading;
  final Color captionColor;

  const KzmFieldCaption({
    @required this.caption,
    @required this.isRequired,
    this.isExpanded = true,
    this.isLoading = false,
    this.captionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Styles.appDoubleMargin),
      child: Row(
        children: <Widget>[
          if (isRequired)
            const Text(
              '* ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          else
            const Text(''),
          if (isLoading)
            KzmShimmer(
              child: KzmText(
                text: caption,
                isExpanded: isExpanded,
                textColor: captionColor ?? Styles.appDarkGrayColor,
              ),
            )
          else
            KzmText(
              text: caption,
              isExpanded: isExpanded,
              textColor: captionColor ?? Styles.appDarkGrayColor,
            ),
        ],
      ),
    );
  }
}
