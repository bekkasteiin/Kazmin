import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/text_input.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';

const String fName = 'lib/core/components/widgets/select_users.dart';

class KzmAskText extends StatelessWidget {
  final String caption;
  final String text;
  final void Function({@required String data}) onChanged;

  const KzmAskText({
    @required this.caption,
    @required this.onChanged,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          KzmTextInput(
            height: Styles.appTextFieldMultilineHeight,
            maxLines: null,
            caption: caption,
            initValue: text,
            prefixIcon: null,
            keyboardType: null,
            onChanged: (KzmAnswerData val) {
              onChanged(data: val.value);
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          KzmOutlinedBlueButton(
            caption: 'ОК'.tr,
            enabled: true,
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
