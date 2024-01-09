import 'package:flutter/cupertino.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:shimmer/shimmer.dart';

class KzmShimmer extends StatelessWidget {
  final Widget child;

  const KzmShimmer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerLightColor,
      child: child ?? Container(color: Styles.shimmerBaseColor),
    );
  }
}
