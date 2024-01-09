import 'package:flutter/cupertino.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmInputContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isActive;
  final double height;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  const KzmInputContainer({
    @required this.child,
    @required this.isLoading,
    this.isActive = true,
    this.height,
    this.alignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Styles.appTextFieldHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: isActive ? null : Styles.appGrayColor,
        border: Border.all(color: Styles.appBorderColor),
        borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
      ),
      alignment: alignment,
      child: isLoading ? const KzmShimmer() : child,
    );
  }
}
