import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/tile_data.dart';

const String fName = 'lib/core/components/widgets/menu_list.dart';

class MenuList extends StatelessWidget {
  final List<TileData> list;
  final dynamic model;

  const MenuList({@required this.list, Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // for (TileData x in list) {
    //   log('-->> $fName, build ->> x: ${x.url} ${x.name}');
    // }
    return SingleChildScrollView(//Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        children: list.mapIndexed((int index, TileData e) {
          // log('-->> $fName, mapIndexed ->> index: $index, e: ${e.name}, ${e.url}');
          return Column(
            children: <Widget>[
              if (index != list.length)
                Divider(
                  height: 1.w,
                  color: Styles.appBorderColor,
                  thickness: 1.w,
                ),
              ListTile(
                title: Text(
                  e.name,
                  style: Styles.mainTS,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.w,
                ),
                tileColor: Colors.white,
                onTap: e?.onTap ?? () async => e.url == '/init' || e.url == '/login' ? await Get.offAndToNamed(e.url) : Get.toNamed(e.url, arguments: model),
              ),
              if (index == list.length - 1)
                Divider(
                  height: 1.w,
                  color: Styles.appBorderColor,
                  thickness: 1.w,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
