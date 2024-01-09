
import 'package:flutter/material.dart';

// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/yellow_button.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';

const String fName = 'lib/layout/widgets.dart';

class BrandLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 100,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'))),
      ),
    );
  }
}

class DialogRow extends StatelessWidget {
  final String title;
  final String content;

  const DialogRow({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? ''),
          Text(content ?? ''),
        ],
      ),
    );
  }
}

class KzmButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final bool disabled;
  final bool outlined;
  final bool muted;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double height;
  final Color bgColor;
  final Color textColorForOutline;
  final Color borderColor;

  const KzmButton({
    @required this.child,
    @required this.onPressed,
    this.bgColor,
    this.disabled = false,
    this.outlined = false,
    this.muted = false,
    this.padding,
    this.margin,
    this.textColorForOutline,
    this.borderColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        padding: padding != null ? MaterialStateProperty.all(padding) : MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w)),
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getForegroundColor(),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        side: _getSide(),
        minimumSize: MaterialStateProperty.all(
          Size(double.minPositive, height ?? 40),
        ),
      ),
      child: child,
    );
  }

  MaterialStateProperty<Color> _getBackgroundColor() {
    Color color;
    if (muted) {
      color = Styles.appDarkGrayColor;
    } else if (outlined) {
      if (disabled) {
        color = Styles.appBrightGrayColor;
      } else {
        color = Styles.appWhiteColor;
      }
    } else {
      if (disabled) {
        color = Styles.appBrightGrayColor;
      } else {
        color = bgColor ?? Styles.appDarkBlueColor;
      }
    }
    return MaterialStateProperty.all(color);
  }

  MaterialStateProperty<Color> _getForegroundColor() {
    Color color;
    if (muted) {
      if (disabled) {
        color = Styles.appWhiteColor;
      } else {
        color = Styles.appDarkBlueColor;
      }
    } else if (outlined) {
      if (disabled) {
        color = Styles.appDarkGrayColor;
      } else {
        color = textColorForOutline ?? Styles.appDarkBlackColor;
      }
    } else {
      if (disabled) {
        color = Styles.appDarkGrayColor;
      } else {
        color = Styles.appWhiteColor;
      }
    }

    return MaterialStateProperty.all(color);
  }

  MaterialStateProperty<BorderSide> _getSide() {
    Color color;
    if (muted) {
      color = Styles.appDarkBlueColor;
    } else if (disabled) {
      color = Styles.appDarkGrayColor;
    } else if (outlined) {
      color = borderColor ?? Styles.appDarkGrayColor;
    } else {
      color = bgColor ?? Styles.appDarkBlueColor;
    }
    return MaterialStateProperty.all(BorderSide(color: color, width: 2));
  }
}

class KzmCheckboxListTile extends StatefulWidget {
  final Widget title;
  final Widget subTitle;
  final bool value;
  final Function(bool) onChanged;

  const KzmCheckboxListTile({
    @required this.title,
    @required this.value,
    Key key,
    this.onChanged,
    this.subTitle,
  }) : super(key: key);

  @override
  State<KzmCheckboxListTile> createState() => _KzmCheckboxListTileState();
}

class _KzmCheckboxListTileState extends State<KzmCheckboxListTile> {
  bool val;

  @override
  void initState() {
    val = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.trailing,
      title: widget.title,
      value: val,
      onChanged: (bool newVal) {
        setState(() {
          val = newVal;
          widget.onChanged(val);
        });
      },
      subtitle: widget.subTitle,
      // checkColor: Styles.appDarkBlueColor,
      // activeColor: Styles.appDarkYellowColor,
      activeColor: Styles.appDarkBlueColor,
    );
  }
}

class CancelAndSaveButtons extends StatelessWidget {
  final Function onTapCancel;
  final Function onTapSave;
  final void Function() onTapSaveRequest;
  final void Function() onTapGetReport;
  final String cancelText;
  final String saveText;
  final bool disabled;
  final int saveX;
  final bool hideCancel;
  final bool showSaveRequestButton;
  final bool showGetReportButton;

  const CancelAndSaveButtons({
    Key key,
    @required this.onTapCancel,
    @required this.onTapSave,
    this.onTapSaveRequest,
    this.onTapGetReport,
    this.cancelText,
    this.disabled = false,
    this.saveText,
    this.saveX,
    this.hideCancel = false,
    this.showSaveRequestButton = false,
    this.showGetReportButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 8.w),
        child: Column(
          children: <Row>[
            if (!disabled)
              Row(
                children: <Widget>[
                  if (showSaveRequestButton)
                    Expanded(
                      // flex: disabled ? 1 : 2,
                      child: KzmOutlinedYellowButton(
                        enabled: true,
                        caption: S.current.save,
                        onPressed: onTapSaveRequest,
                      ),
                    ),
                  if (showSaveRequestButton && showGetReportButton) SizedBox(width: Styles.appStandartMargin),
                  if (showGetReportButton)
                    Expanded(
                      // flex: disabled ? 1 : 2,
                      child: KzmOutlinedYellowButton(
                        enabled: true,
                        caption: S.current.report,
                        onPressed: onTapGetReport,
                      ),
                    ),
                ],
              ),
            Row(
              children: <Widget>[
                if (hideCancel)
                  const SizedBox()
                else
                  Expanded(
                    flex: disabled ? 1 : 2,
                    child: KzmButton(
                      outlined: true,
                      borderColor: Styles.appDarkGrayColor,
                      onPressed: onTapCancel,
                      child: Text(
                        cancelText ?? S.current.cancel,
                        style: Styles.mainTxtTheme.button.copyWith(
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                  ),
                if (hideCancel)
                  const SizedBox()
                else
                  SizedBox(
                    width: disabled ? 0 : 16,
                  ),
                if (!disabled)
                  Expanded(
                    flex: saveX ?? 3,
                    child: KzmButton(
                      //disabled: disabled,
                      onPressed: onTapSave,
                      child: Text(
                        saveText ?? S.current.save,
                        style: Styles.mainTxtTheme.button.copyWith(
                          color: Styles.appWhiteColor,
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KzmFileDescriptorsWidget extends StatelessWidget {
  final Function onTap;
  final Column list;
  final bool isRequired;
  final bool editable;

  const KzmFileDescriptorsWidget({Key key, this.onTap, this.list, this.isRequired = false, this.editable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16, bottom: 7),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            decoration: BoxDecoration(border: Border.all(color: Styles.appBorderColor), borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: isRequired ? '* ' : '',
                        style: Styles.mainTS.copyWith(
                          color: Styles.appErrorColor,
                        ),
                        children: [
                          TextSpan(
                            text: S.current.attachments,
                            style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                          )
                        ],
                      ),
                    ),
                    if (editable) IconButton(
                            onPressed: onTap,
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Styles.appDarkBlueColor,
                            ),) else Column(),
                  ],
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
                list
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class KzmFileTile extends StatelessWidget {
  final String fileName;
  final Function onTap;
  final FileDescriptor fileDescriptor;

  const KzmFileTile({Key key, this.fileName, this.onTap, this.fileDescriptor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.appBrightBlueColor,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: fileDescriptor != null ? () => PickerFileServices.downloadFile(fileDescriptor) : null,
              child: Text(
                fileName,
                softWrap: true,
                style: Styles.mainTS.copyWith(fontSize: Styles.appSubtitleFontSize, height: 1.5),
              ),
            ),
          ),
          if (onTap != null) Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: onTap,
                    child: Icon(Icons.cancel, size: 18, color: Styles.appDarkGrayColor),
                  ),
                ) else Container()
        ],
      ),
    );
  }
}

class KzmExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool initiallyExpanded;
  final CrossAxisAlignment crossAxisAlignment;

  const KzmExpansionTile({
    this.title,
    this.children,
    this.subtitle,
    this.initiallyExpanded = false,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Styles.appDarkBlueColor)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: crossAxisAlignment,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
        ),
        subtitle: subtitle != null
            ? Padding(
                padding: EdgeInsets.only(top: Styles.appStandartMargin),
                child: Text(
                  subtitle,
                  style: Styles.mainTS.copyWith(fontSize: 11.0.sp),
                ),
              )
            : null,
        children: children,
      ),
    );
  }
}

class KzmCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final Color statusColor;
  final Color bgColor;
  final double statusBorderWidth;
  final VoidCallback selected;
  final int maxLinesTitle;
  final Widget subtitleWidget;
  final bool showArrowIcon;

  const KzmCard({
    Key key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.statusColor,
    this.bgColor,
    this.maxLinesTitle,
    this.statusBorderWidth,
    this.subtitleWidget,
    this.selected,
    this.showArrowIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10),
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.w))),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor ?? Styles.appWhiteColor,
            border: Border(
              left: BorderSide(width: statusColor == null ? 0 : statusBorderWidth ?? 5.w, color: statusColor ?? Colors.transparent),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
            title: Text(
              title,
              maxLines: maxLinesTitle ?? 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.mainTS.copyWith(
                color: Styles.appDarkBlackColor,
                fontSize: Styles.appDefaultFontSizeHeader,
              ),
            ),
            subtitle: subtitleWidget ??
                (subtitle != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.w),
                        child: Text(
                          subtitle,
                          style: Styles.mainTS.copyWith(
                            fontSize: Styles.appAdvertsFontSize,
                            color: Styles.appDarkGrayColor,
                          ),
                        ),
                      )
                    : null),
            trailing: trailing,
            leading: leading,
            onTap: selected != null ? () => selected() : null,
          ),
        ),
      ),
    );
  }
}
