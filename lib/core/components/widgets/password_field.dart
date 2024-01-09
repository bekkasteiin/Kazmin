import 'package:flutter/material.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmPasswordInput extends StatefulWidget {
  final String hintText;
  final void Function(String) onChanged;

  const KzmPasswordInput({@required this.hintText, @required this.onChanged});

  @override
  _KzmPasswordInputState createState() => _KzmPasswordInputState();
}

class _KzmPasswordInputState extends State<KzmPasswordInput> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Styles.appTextFieldHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Styles.appBorderColor),
        borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              style: Styles.textFieldTS,
              onChanged: widget.onChanged,
              obscureText: isObsecure,
              decoration: InputDecoration(
                isCollapsed: true,
                prefixIcon: KzmIcons.lock,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() => isObsecure = !isObsecure);
                  },
                  child: isObsecure ? KzmIcons.greyEye : KzmIcons.colorEye,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: Text(widget.hintText, overflow: TextOverflow.ellipsis).data,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
