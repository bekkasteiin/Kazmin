import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/answers_scrolled_box.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/common_item.dart';

class KzmRadioInput extends StatefulWidget {
  final List<KzmCommonItem> data;
  final Function(KzmAnswerData) onChanged;

  const KzmRadioInput({@required this.data, @required this.onChanged});

  @override
  State<KzmRadioInput> createState() => _KzmRadioInputState();
}

class _KzmRadioInputState extends State<KzmRadioInput> {
  String _val;

  String get val => _val;

  set val(String v) => setState(() {
        _val = v;
        widget.onChanged(KzmAnswerData(value: v, add: true));
      });

  @override
  Widget build(BuildContext context) {
    return KzmAnswersScrolledBox(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < widget.data.length; i++)
            Row(
              children: <Widget>[
                SizedBox(
                  width: Styles.appRadioIconSize,
                  child: Radio<String>(
                    value: widget.data[i].id,
                    groupValue: _val,
                    activeColor: Styles.appCorporateColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                    onChanged: (String v) => val = v,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      onTap: () => val = widget.data[i].id,
                      child: Text(
                        widget.data[i].text,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: val == widget.data[i].id ? FontWeight.bold : FontWeight.normal,
                          fontSize: Styles.appDefaultFontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
