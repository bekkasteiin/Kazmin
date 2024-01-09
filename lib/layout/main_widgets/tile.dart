
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/tile_data.dart';

import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/layout/main_widgets/tile.dart';

class KzmTile extends StatefulWidget {
  final TileData data;
  final bool isDrawer;

  const KzmTile({Key key, this.data, this.isDrawer = false}) : super(key: key);

  @override
  State<KzmTile> createState() => _KzmTileState();
}

class _KzmTileState extends State<KzmTile> {
  final NotificationModel notifications = Provider.of<NotificationModel>(navigatorKey.currentContext);
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 3 - 18;
    if (widget.data.name != null) {
      return widget.isDrawer
          ? ListTile(
              // leading: SvgPicture.asset(data.svgIcon, height: 24.0.w),
              title: Text(
                widget.data.name,
                maxLines: 2,
                style: Styles.mainTS,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
              trailing: SvgPicture.asset(
                widget.data.svgIcon,
                height: 32.0.w,
                color: Styles.appCorporateColor,
              ),
              onTap: (){
                tap();
              } ,
              contentPadding: EdgeInsets.only(left: 8.w, right: 8.w),
              horizontalTitleGap: 16.w,
            )
          : buildCard(size, context);
    }
    return SizedBox(
      width: size,
      height: size,
      child: const Center(
        child: LoaderWidget(),
      ),
    );
  }

  Card buildCard(double size, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      color: Styles.appWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: Styles.appBorderColor), borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius)),
      child: InkWell(
        onTap: () => tap(),
        child: Container(
          height: size,
          width: size,
          padding: EdgeInsets.only(top: size / 6, bottom: size / 6, left: size / 16, right: size / 16),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                widget.data.svgIcon,
                height: size / 3.6,
                width: size / 3.6,
                color: Styles.appCorporateColor,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Text>[
                    Text(
                      widget.data.name,
                      style: Styles.cardTS,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> tap() async {
    print(widget.data.name);
    print(widget.data.url);
    widget.data.url == KzmPages.init || widget.data.url == KzmPages.login ? await Get.offAndToNamed(widget.data.url) : await Get.toNamed(widget.data.url) /*.then((value) => null)*/;
  }
}
