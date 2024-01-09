import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmExpansionTileWide extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const KzmExpansionTileWide({
    @required this.title,
    @required this.children,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: KzmFieldCaption(caption: title, isRequired: false),
        subtitle: subtitle != null
            ? Row(
                children: <Expanded>[
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(subtitle, style: Styles.sendMessageFilesList),
                    ),
                  ),
                ],
              )
            : null,
        children: children,
      ),
    );
  }
}
