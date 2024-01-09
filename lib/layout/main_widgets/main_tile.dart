
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/tile_data.dart';

class KzmMainTile extends StatefulWidget {
  final TileData data;
  final Function onTap;
  final int counter;

  const KzmMainTile({@required this.data, this.counter, this.onTap});

  @override
  State<KzmMainTile> createState() => _KzmMainTileState();
}

class _KzmMainTileState extends State<KzmMainTile> {
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 3 - 18;
    return buildCard(size, context);
  }

  Card buildCard(double size, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      color: Styles.appWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Styles.appBorderColor),
        borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
      ),
      child: InkWell(
        onTap: (){
          tap();
          setState(() {});
        },
        child: Container(
          height: size / 2,
          padding: EdgeInsets.only(top: size / 8, bottom: size / 8, left: size / 16, right: size / 16),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SvgPicture.asset(
                  widget.data.svgIcon,
                  height: size / 3,
                  width: size / 3,
                  color: Styles.appCorporateColor,
                ),
              ),
              Text(
                widget.data.name,
                style: Styles.cardTS,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              const Spacer(),
              if ((widget.counter ?? 0) > 0) Text((widget.counter ?? 0).toString(), style: Styles.mainCardTSCounter),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Icon(Icons.navigate_next_rounded, color: Styles.appDarkGrayColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> tap() async {
    if (widget.onTap != null) {
      widget.onTap();
    }
    widget.data.url == KzmPages.init || widget.data.url == KzmPages.login
        ? await Get.offAndToNamed(widget.data.url)
        : await Get.toNamed(widget.data.url);
  }
}
