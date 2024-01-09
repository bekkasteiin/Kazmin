
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/text.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/common_item.dart';

class KzmBottomSheetValues extends StatefulWidget {
  final List<KzmCommonItem> items;
  final bool isCupertinoStyle;
  final int initValIndex;

  final Function({@required KzmCommonItem val}) onSelect;

  const KzmBottomSheetValues({
    @required this.items,
    @required this.onSelect,
    this.isCupertinoStyle = false,
    this.initValIndex = 0,
  });

  @override
  _KzmBottomSheetValuesState createState() => _KzmBottomSheetValuesState();
}

class _KzmBottomSheetValuesState extends State<KzmBottomSheetValues> {
  final double _itemHeight = 64.w;
  final double _bottomSheetHeight = Get.height / 3;
  final double _cupertinoItemExtent = 40.w;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isCupertinoStyle) {
        _scrollController.animateTo(
          (_itemHeight + Styles.appStandartMargin) * widget.initValIndex,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      }
      widget.onSelect(val: widget.items[widget.initValIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Container(
            padding: paddingLR,
            height: _bottomSheetHeight,
            child: (widget.isCupertinoStyle)
                ? CupertinoPicker.builder(
                    childCount: widget.items.length,
                    itemExtent: _cupertinoItemExtent,
                    scrollController: FixedExtentScrollController(initialItem: widget.initValIndex),
                    itemBuilder: (BuildContext context, int index) => Center(
                      child: Padding(
                        padding: paddingLR,
                        child: KzmText(
                          text: widget.items[index].text,
                          isExpanded: false,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onSelectedItemChanged: (int index) => widget.onSelect(val: widget.items[index]),
                  )
                : ListView.separated(
                    controller: _scrollController,
                    itemCount: widget.items.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(height: Styles.appStandartMargin),
                    itemBuilder: (BuildContext context, int index) => GestureDetector(
                      child: SizedBox(
                        height: _itemHeight,
                        child: Center(
                          child: Padding(
                            padding: paddingLR,
                            child: KzmText(
                              text: widget.items[index].text,
                              isExpanded: false,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        widget.onSelect(val: widget.items[index]);
                        Get.back();
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
