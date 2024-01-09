import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/hint_text.dart';
import 'package:kzm/core/components/widgets/text.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/selected_users.dart';

class KzmUserTile extends StatelessWidget {
  final KzmSelectedUsers data;
  final void Function() onDelete;

  const KzmUserTile({
    @required this.data,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KzmText(text: data.user.text, maxLines: 2, isExpanded: false, textAlign: TextAlign.start),
        SizedBox(height: Styles.appDoubleMargin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            KzmHintText(hint: data.role.text, isExpanded: true),
            if (data.canBeDeleted)
              GestureDetector(
                onTap: onDelete,
                child: KzmIcons.sendMessageFilesListDelete,
              ),
          ],
        ),
        Divider(height: Styles.appQuadMargin, thickness: 1),
      ],
    );
  }
}
