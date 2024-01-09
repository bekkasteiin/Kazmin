
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/components/widgets/input_container.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';

const String fName = 'lib/core/components/widgets/text_input.dart';

class KzmTextInput extends StatefulWidget {
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final List<TextInputFormatter> inputFormatters;
  final String caption;
  final String hintText;
  final void Function(KzmAnswerData) onChanged;
  final bool showCursor;
  final bool readOnly;
  final bool isRequired;
  final String initValue;
  final int maxLines;
  final double height;
  final bool isActive;
  final bool isLoading;

  const KzmTextInput({
    @required this.keyboardType,
    @required this.prefixIcon,
    @required this.maxLines,
    this.caption,
    this.hintText,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.showCursor,
    this.readOnly = false,
    this.isRequired = false,
    this.initValue,
    this.height,
    this.isActive = true,
    this.isLoading = false,
  }) : assert((height == null && maxLines == 1) || (height != null && maxLines == null));

  @override
  State<KzmTextInput> createState() => _KzmTextInputState();
}

class _KzmTextInputState extends State<KzmTextInput> {
  final TextEditingController _textController = TextEditingController();
  bool initValSettled = false;

  @override
  Widget build(BuildContext context) {
    if ((!initValSettled) && (widget.initValue != null)) {
      setState(() {
        _textController.text = widget.initValue;
      });
      initValSettled = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.caption != null) KzmFieldCaption(caption: widget.caption, isRequired: widget.isRequired),
        KzmInputContainer(
          isLoading: widget.isLoading,
          isActive: widget.isActive,
          height: widget.height,
          alignment: (widget.maxLines == null) ? Alignment.topLeft : null,
          padding: ((widget.prefixIcon != null) || (widget.isLoading))
              ? null
              : (widget.maxLines == null)
                  ? paddingHorizontal(top: Styles.appDoubleMargin)
                  : paddingHorizontal(),
          child: widget.isLoading
              ? null
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        enabled: widget.isActive,
                        maxLines: widget.maxLines,
                        textAlignVertical: TextAlignVertical.center,
                        style: Styles.textFieldTS,
                        onChanged: (String val) {
                          if (widget.onChanged != null) {
                            widget.onChanged(KzmAnswerData(value: val, add: val != null && val.isNotEmpty));
                          }
                        },
                        keyboardType: widget.keyboardType,
                        inputFormatters: widget.inputFormatters,
                        showCursor: widget.showCursor,
                        readOnly: widget.readOnly,
                        controller: _textController,
                        decoration: InputDecoration(
                          suffixIcon: widget.suffixIcon,
                          isCollapsed: true,
                          prefixIcon: widget.prefixIcon,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.hintText ?? (widget.isActive ? 'Заполните'.tr : ''),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
