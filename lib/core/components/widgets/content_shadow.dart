import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmContentShadow extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final bool hideMargin;
  final double bottomPadding;
  final double topPadding;
  final EdgeInsets margin;
  final Widget action;

  const KzmContentShadow({
    this.child,
    this.title,
    this.subtitle,
    this.hideMargin = false,
    this.bottomPadding,
    this.topPadding,
    this.margin,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            // margin: hideMargin ? EdgeInsets.zero : margin ?? const EdgeInsets.all(16.0),
            // padding: EdgeInsets.only(bottom: bottomPadding ?? 16, top: topPadding ?? 0, left: 16, right: 16),
            margin: hideMargin ? EdgeInsets.zero : margin ?? EdgeInsets.all(16.w),
            padding: EdgeInsets.only(
              bottom: bottomPadding ?? 16.w,
              top: topPadding ?? 0,
              left: 16.w,
              right: 16.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 24,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Padding(
                    // padding: const EdgeInsets.only(top: 16, bottom: 8),
                    padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            title,
                            softWrap: true,
                            style: Styles.mainTS.copyWith(
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (action != null)
                          Padding(
                            padding: EdgeInsets.only(left: Styles.appStandartMargin),
                            child: action,
                          )
                        else
                          SizedBox(height: Styles.appTextFieldIconSize),
                      ],
                    ),
                  )
                else
                  Column(),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      subtitle,
                      style: Styles.mainTS.copyWith(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  Column(),
                // if (subtitle == null && title == null) const SizedBox(height: 10) else Column(),
                if (subtitle == null && title == null) SizedBox(height: 10.w) else Column(),
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
