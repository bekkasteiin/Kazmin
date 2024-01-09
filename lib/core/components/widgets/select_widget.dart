import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';

class SelectsWidget extends StatefulWidget {
  dynamic select;
  String title;
  List<AbstractDictionary> list;
  Widget child;

  SelectsWidget({Key key, this.select, this.list, this.title, this.child}) : super(key: key);

  @override
  State<SelectsWidget> createState() => _SelectsWidgetState();
}

class _SelectsWidgetState extends State<SelectsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: size.height * (0.5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.w),
            child: Container(
              height: 5.h,
              width: size.width / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: Styles.appBrightBlueColor.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Styles.appWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              widget.title,
              style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: widget.child
            ),
          ),
        ],
      ),
    );
  }
}

class SelectItem extends StatelessWidget {
  final String title;
  final bool current;
  const SelectItem(this.title, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: current ? Styles.appBrightBlueColor.withOpacity(0.5) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title ?? '',
          style: Styles.mainTS
              .copyWith(fontSize: 14, color: Styles.appDarkBlackColor),
        ),
        trailing: current
            ? const Icon(
                Icons.check_circle_outline,
                color: Colors.blueAccent,
              )
            : null,
      ),
    );
  }
}
