import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmCheckBox extends StatefulWidget {
  final String text;
  final bool initValue;
  final bool currValue;
  final bool editable;
  final bool isRequired;
  final Function(bool) onChanged;

  const KzmCheckBox({
    @required this.text,
    @required this.initValue,
    @required this.onChanged,
    this.editable = true,
    this.isRequired = false,
    this.currValue,
  });

  @override
  State<KzmCheckBox> createState() => _KzmCheckBoxState();
}

class _KzmCheckBoxState extends State<KzmCheckBox> {
  bool _val;

  void setVal({@required bool value}) => setState(() {
        _val = value;
        widget.onChanged(value);
      });

  @override
  void initState() {
    _val = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currValue != null) _val = widget.currValue;
    return GestureDetector(
      onTap: () => (widget.editable) ? setVal(value: !_val) : null,
      child: Padding(
        // padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
        padding: EdgeInsets.only(top: 16.w),
        child: SizedBox(
          // width: double.infinity,
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Text.rich(
          //       TextSpan(
          //         text: widget.isRequired ? '* ' : '',
          //         style: Styles.mainTS.copyWith(color: Styles.appErrorColor),
          //         children: <TextSpan>[
          //           TextSpan(
          //             text: widget.text ?? '',
          //             style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
          //           )
          //         ],
          //       ),
          //     ),
          //     SizedBox(height: Styles.appStandartMargin),
          //     Checkbox(
          //       value: _val,
          //       activeColor: Styles.appCorporateColor,
          //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //       splashRadius: 0,
          //       visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
          //       onChanged: (bool v) => (widget.editable) ? setVal(value: v) : null,
          //     ),
          //   ],
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text.rich(
                  TextSpan(
                    text: widget.isRequired ? '* ' : '',
                    style: Styles.mainTS.copyWith(color: Styles.appErrorColor),
                    children: [
                      TextSpan(
                        text: widget.text ?? '',
                        style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                      ),
                    ],
                  ),
                ),
              ),
              Checkbox(
                value: _val,
                activeColor: Styles.appCorporateColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 0,
                visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                onChanged: (bool v) => (widget.editable) ? setVal(value: v) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
