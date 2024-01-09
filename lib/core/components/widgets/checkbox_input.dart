import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/answers_scrolled_box.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/common_item.dart';

class KzmCheckBoxInput extends StatefulWidget {
  final List<KzmCommonItem> data;
  final Function(KzmAnswerData) onChanged;

  const KzmCheckBoxInput({@required this.data, @required this.onChanged});

  @override
  State<KzmCheckBoxInput> createState() => _KzmCheckBoxInputState();
}

class _KzmCheckBoxInputState extends State<KzmCheckBoxInput> {
  List<bool> val;

  void setVal({@required bool value, @required int index}) => setState(() {
        val[index] = value;
        widget.onChanged(KzmAnswerData(value: widget.data[index].id, add: value));
      });

  @override
  void initState() {
    val = <bool>[...widget.data.map((KzmCommonItem e) => false)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KzmAnswersScrolledBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < val.length; i++)
            Row(
              children: <Widget>[
                SizedBox(
                  width: Styles.appRadioIconSize,
                  child: Checkbox(
                    value: val[i],
                    activeColor: Styles.appCorporateColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                    onChanged: (bool v) => setVal(value: v, index: i),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      onTap: () => setVal(value: !val[i], index: i),
                      child: Text(
                        widget.data[i].text,
                        style: TextStyle(
                          fontWeight: val[i] ? FontWeight.bold : FontWeight.normal,
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
