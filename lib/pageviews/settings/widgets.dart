import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';

class Item {
  IconData iconData;
  String title;
  Widget toPage;
  Color color;

  Item(this.iconData, this.title, this.toPage, this.color) {
    iconData ??= Icons.description;
    title ??= 'Title';
    toPage ??= Container();
    color ??= Styles.appPrimaryColor;
  }
}

class KzmMenuItem extends StatelessWidget {
  final Item item;
  final Function onTap;
  final Widget child;

  const KzmMenuItem({Key key, this.item, this.onTap, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.to(item.toPage ?? Container()),
      child: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              width: 0.5.w,
              color: Colors.black,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              color: item.color,
              padding: EdgeInsets.all(8.w),
              child: Icon(
                item.iconData,
                color: item.color.computeLuminance() > 0.5
                    ? Colors.black
                    : CupertinoTheme.of(context).scaffoldBackgroundColor,
                size: 25,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                constraints: BoxConstraints.tightForFinite(height: 36.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title,
                          style: CupertinoTheme.of(context).textTheme.textStyle,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        child ??
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                              color: Colors.black,
                            ),
                        SizedBox(width: 8.w,)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
