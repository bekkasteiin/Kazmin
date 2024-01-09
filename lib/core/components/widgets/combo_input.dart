import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/bottom_sheet_values.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/components/widgets/hint_text.dart';
import 'package:kzm/core/components/widgets/input_container.dart';
import 'package:kzm/core/components/widgets/text.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const String fName = 'lib/core/components/widgets/combo_input.dart';

class KzmComboInput extends StatefulWidget {
  final String caption;
  final bool isRequired;
  final List<KzmCommonItem> items;
  final bool isCupertinoStyle;
  final bool isActive;
  final bool isLoading;
  final KzmCommonItem initVal;

  final void Function({@required KzmCommonItem val}) onChanged;

  const KzmComboInput({
    @required this.caption,
    @required this.items,
    @required this.onChanged,
    this.initVal,
    this.isRequired = false,
    this.isActive = true,
    this.isCupertinoStyle = true,
    this.isLoading = false,
  });

  @override
  State<KzmComboInput> createState() => _KzmComboInputState();
}

class _KzmComboInputState extends State<KzmComboInput> {
  KzmCommonItem _val;

  @override
  void initState() {
    _val = widget.initVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bool isNotEmpty = widget.items != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KzmFieldCaption(caption: widget.caption, isRequired: widget.isRequired),
        KzmInputContainer(
          isLoading: widget.isLoading,
          isActive: widget.isActive,
          padding: widget.isLoading ? null : paddingHorizontal(),
          child: widget.isLoading
              ? null
              : GestureDetector(
                  onTap: widget.isActive
                      ? () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (_) => KzmBottomSheetValues(
                              initValIndex: _val == null ? 0 : widget.items.indexOf(_val),
                              isCupertinoStyle: widget.isCupertinoStyle,
                              items: widget.items,
                              onSelect: ({KzmCommonItem val}) {
                                widget.onChanged(val: val);
                                setState(() => _val = val);
                              },
                            ),
                          );
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (_val == null) KzmHintText(hint: 'Выберите'.tr) else KzmText(text: _val.text),
                      KzmIcons.down,
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
