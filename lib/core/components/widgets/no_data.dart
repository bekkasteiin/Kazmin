import 'package:flutter/cupertino.dart';

import 'package:kzm/generated/l10n.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KZMNoData extends StatelessWidget {
  // final String text;

  // KZMNoData({this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.current.noData),
    );
  }
}
