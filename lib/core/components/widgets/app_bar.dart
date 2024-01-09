import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/layout/widgets.dart';

class KzmAppBar extends AppBar {
  KzmAppBar({
    @required BuildContext context,
    bool settings = false,
    bool showMenu = false,
    Widget title,
    bool centerTitle,
    PreferredSizeWidget bottom,
    List<Widget> actions,
    Widget leading,
  }) : super(
          elevation: 0.0,
          flexibleSpace: appBarBg(context),
          leading: leading ?? IconButton(
            color: Styles.appCorporateColor,
            disabledColor: Styles.appBrightGrayColor,
            icon: KzmIcons.back,
            onPressed: () => Get.back(),
            // onPressed: null,
          ),
          title: title ?? BrandLogo(),
          actions: (actions == null)
              ? <Widget>[
                  if (settings)
                    IconButton(
                      onPressed: () => Get.toNamed(KzmPages.settings),
                      icon: KzmIcons.settingsSolid,
                    ),
                  if (showMenu)
                    Builder(
                      builder: (BuildContext context) => IconButton(
                        icon: KzmIcons.menu,
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                          // Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                ]
              : actions,
          centerTitle: centerTitle ?? Platform.isIOS,
          bottom: bottom,
        );
}
