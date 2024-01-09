import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';

class FieldBones extends StatelessWidget {
  final String placeholder;
  final String textValue;
  final bool isTextField;
  final bool isRequired;
  dynamic _selector;
  final bool needMaxLines;
  final bool iconAlignEnd;
  final bool isMinWidthTiles;
  final IconData icon;
  final Color iconColor;
  final int maxLinesSubTitle;
  dynamic _iconTap;
  final onChanged;
  final onSaved;
  final onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final onEditingComplete;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final double height;
  final bool showCounterText;
  final validate;
  final bool dateField;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget leading;
  final TextEditingController textController;
  final bool editable;

  FieldBones({
    dynamic selector,
    dynamic iconTap,
    @required this.placeholder,
    this.isTextField = false,
    this.textValue,
    this.inputFormatters,
    this.icon,
    this.iconColor,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.needMaxLines = false,
    this.textController,
    this.isRequired = false,
    this.showCounterText = false,
    this.maxLinesSubTitle,
    this.keyboardType,
    this.validate,
    this.hintText,
    this.maxLines,
    this.leading,
    this.maxLength,
    this.dateField = false,
    this.height,
    this.iconAlignEnd = false,
    this.isMinWidthTiles = false,
    this.editable = true,
  }) {
    _selector = editable ? selector : null;
    _iconTap = editable ? iconTap : null;
  }

  @override
  Widget build(BuildContext context) {
    Widget secondChild;
    final bool needToShowDialog = needMaxLines && !isTextField && icon == null;
    if (needToShowDialog) {
      secondChild = buildIconButton(context, needToShowDialog);
    }
    // print((isTextField ));
    secondChild ??= icon == null
        ? const SizedBox(
            width: 30,
          )
        : buildIconButton(context, false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Container(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Text.rich(
              TextSpan(
                text: isRequired ? '* ' : '',
                style: Styles.mainTS.copyWith(
                  // fontSize: 12,
                  color: Styles.appErrorColor,
                ),
                children: [
                  TextSpan(
                    text: placeholder ?? '',
                    style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                  )
                ],
              ),
            ),
          ),
          //field
          InkWell(
            onTap: _selector == null ? null : _selector as Function(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.0.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Styles.appBorderColor,
                  width: 1,
                ),
                color: !editable || (!isTextField && _iconTap == null && _selector == null) ? Styles.appBrightGrayColor.withOpacity(0.6) : null,
                borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
                // color: isTextField ? appWhiteColor : appGrayColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Center(child: leading),
                    )
                  else
                    dateField
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Center(child: calendarWidgetForFormFiled),
                          )
                        : Column(),
                  Expanded(
                    // width:
                    // !isMinWidthTiles ? MediaQuery.of(context).size.width-110 : 130,
                    child: !isTextField ? buildTile() : buildTextFormField(context),
                  ),
                  secondChild,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTile() {
    final Widget text2 = Text(
      textValue ?? (hintText ?? (dateField
                  ? '__ ___, _____'
                  : '')),
      style: Styles.mainTS.copyWith(fontSize: 15.w, color: textValue == null ? Styles.appDarkGrayColor : Styles.appDarkBlackColor),
      maxLines: maxLinesSubTitle ?? 2,
    );
    return SizedBox(
      height: height,
      child: text2,
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.w,
          ),
          fillColor: isTextField ? CupertinoColors.systemBackground : Theme.of(context).scaffoldBackgroundColor,
          hintText: hintText ?? '',
          isDense: true,
          // counterText: !showCounterText ? "" : null,
          border: InputBorder.none,),
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines,
      validator: validate,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.always,
      initialValue: textValue,
      style: TextStyle(fontSize: 15.w),
      controller: textValue != null && controller == null && !isTextField ? null : controller,
      enabled: editable,
      maxLength: maxLength,
      buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
          (showCounterText && maxLength != null) ? Text('$currentLength/$maxLength') : null,
      readOnly: false,
    );
  }

  InkWell buildIconButton(BuildContext context, bool needToShowDialog) {
    return InkWell(
      onTap: _iconTap == null ? null : _iconTap as Function(),
      child: Container(
        decoration: _iconTap == null
            ? BoxDecoration(
                color: !editable ? null : CupertinoColors.systemBackground,
                borderRadius: BorderRadius.circular(10.w),
              )
            : null,
        child: Icon(
          needToShowDialog ? Icons.message : icon ?? Icons.arrow_forward_ios,
          color: iconColor,
          size: 20.w,
        ),
      ),
    );
  }
}

class FieldBonesOld extends StatelessWidget {
  final String placeholder;
  final String textValue;
  final bool isTextField;
  final bool isRequired;
  final selector;
  final bool needMaxLines;
  final IconData icon;
  final Color iconColor;
  final bool iconAlignEnd;
  final bool isMinWidthTiles;
  final int maxLinesSubTitle;
  final iconTap;
  final onChanged;
  final onSaved;
  final onFieldSubmitted;
  final onEditingComplete;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final bool showCounterText;
  final validate;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextEditingController textController;

  const FieldBonesOld(
      {Key key,
      @required this.placeholder,
      this.isTextField = false,
      this.textValue,
      this.icon,
      this.iconColor,
      this.iconTap,
      this.controller,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.needMaxLines = false,
      this.textController,
      this.selector,
      this.isRequired = false,
      this.showCounterText = false,
      this.maxLinesSubTitle,
      this.keyboardType,
      this.validate,
      this.hintText,
      this.maxLines,
      this.maxLength,
      this.iconAlignEnd = false,
      this.isMinWidthTiles,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget secondChild;
    final bool needToShowDialog = needMaxLines && !isTextField && icon == null;
    if (needToShowDialog) {
      secondChild = buildIconButton(context, needToShowDialog);
    }
    secondChild ??= icon == null
        ? const SizedBox(
            width: 30,
          )
        : buildIconButton(context, false);
    return InkWell(
      onTap: selector,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: iconAlignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: !isMinWidthTiles ? MediaQuery.of(context).size.width - 110 : 130,
              child: !isTextField ? buildTile() : form(context),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Center(child: secondChild),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTile() {
    final bool isFilled = textValue != null;
    final Container text = Container(
      child: isFilled
          ? Text.rich(TextSpan(
              text: isRequired ? '* ' : '',
              style: Styles.mainTS.copyWith(
                // fontSize: 12,
                color: Colors.redAccent,
              ),
              children: [
                  TextSpan(
                    text: placeholder ?? '',
                    style: Styles.mainTS.copyWith(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  )
                ],),)
          : Text(
              placeholder ?? '',
              style: Styles.mainTS.copyWith(
                fontSize: 18,
                color: isRequired ? Colors.redAccent : null,
              ),
            ),
    );
    final Text text2 = Text(
      textValue ?? '',
      style: Styles.mainTS.copyWith(fontSize: 17),
      maxLines: maxLinesSubTitle ?? 1,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(0, isFilled ? 10 : 10, 0, 0),
      child: !isFilled
          ? text
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                text,
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: needMaxLines && !isTextField
                      ? SizedBox(
                          height: 20,
                          child: SingleChildScrollView(
                            child: text2,
                          ),
                        )
                      : text2,
                ),
              ],
            ),
    );
  }

  Widget form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: isRequired ? '* ' : '',
              style: Styles.mainTS.copyWith(
                // fontSize: 12,
                color: Colors.redAccent,
              ),
              children: [
                TextSpan(
                  text: placeholder ?? '',
                  style: Styles.mainTS.copyWith(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                )
              ],),),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            child: buildTextFormField(context),
          )
        ],
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
          fillColor: isTextField ? CupertinoColors.systemBackground : Theme.of(context).scaffoldBackgroundColor,
          hintText: hintText ?? '',
          isDense: true,
          // counterText: !showCounterText ? "" : null,
          border: InputBorder.none,),
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines,
      validator: validate,
      autovalidateMode: AutovalidateMode.always,
      initialValue: textValue,
      controller: textValue != null && controller == null && !isTextField ? null : controller,
      enabled: isTextField,
      maxLength: maxLength,
      buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) =>
          (showCounterText && maxLength != null) ? Text('$currentLength/$maxLength') : null,
    );
  }

  InkWell buildIconButton(BuildContext context, bool needToShowDialog) {
    return InkWell(
        onTap: iconTap,
        child: Container(
          decoration: iconTap == null
              ? BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(10),
                )
              : const BoxDecoration(),
          padding: const EdgeInsets.all(5),
          child: Icon(
            needToShowDialog ? Icons.message : icon ?? Icons.arrow_forward_ios,
            color: iconColor,
            size: 20,
          ),
        ),);
  }
}

// ignore: non_constant_identifier_names
void DateTimeSelector(
    {@required ValueChanged<DateTime> onDateTimeChanged,
    String localeCode,
    double height,
    DateTime startDate,
    CupertinoDatePickerMode mode,
    DateTime minimumDate,
    DateTime maximumDate,}) {
  showCupertinoModalPopup<void>(
    context: Get.overlayContext,
    builder: (BuildContext context) {
      return Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        height: height ?? 200,
        child: CupertinoDatePicker(
          mode: mode ?? CupertinoDatePickerMode.date,
          use24hFormat: localeCode ?? 'ru' != 'en',
          initialDateTime: startDate ?? DateTime.now(),
          onDateTimeChanged: onDateTimeChanged,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
        ),
      );
    },
  );
}

class FieldRow extends StatelessWidget {
  final String string;
  final Widget child;

  const FieldRow({this.string, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(string), child],
      ),
    );
  }
}

class SelectorField extends StatelessWidget {
  final String value;
  final Color color;
  final IconData icon;
  final dynamic onTap;
  final dynamic onClear;
  final double width;
  final bool mandatory;

  const SelectorField({this.onTap, this.value, this.color, this.icon, this.width, this.onClear, this.mandatory = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: icon == Icons.close
          ? Container(
              width: width ?? 200.w,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3),
                color: Colors.black12,
              ),
              child: Text(
                value ?? '',
                style: TextStyle(
                  color: (color?.computeLuminance() ?? 1) > 0.5 ? Colors.black : Colors.white,
                ),
              ),
            )
          : Container(
              width: width ?? 200,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (value == null || value.isEmpty) && mandatory ? Colors.red : Colors.black,
                  width: 0.3,
                ),
                color: color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      value ?? '',
                      style: TextStyle(
                        color: (color?.computeLuminance() ?? 1) > 0.5 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (icon == Icons.close) const SizedBox() else Icon(icon ?? Icons.keyboard_arrow_down),
                      if (onClear == null) const SizedBox() else SizedBox(
                              width: 18,
                              height: 18,
                              child: InkWell(
                                onTap: onClear,
                                child: const Icon(
                                  Icons.clear,
                                  size: 18,
                                ),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
