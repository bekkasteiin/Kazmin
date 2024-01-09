import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class KzmTileSecondary extends StatelessWidget {
  final TileData data;
  final bool isDrawer;
  final LearningModel model;

  const KzmTileSecondary({Key key, this.data, this.isDrawer = false, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 2 - 25;
    return buildCard(size, context);
  }

  Widget buildCard(double size, context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Styles.appWhiteColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Styles.appDarkBlackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(3, 2), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () => tap(),
        child: SizedBox(
          height: size / 1.3,
          width: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                data.svgIcon,
                height: 36.67,
              ),
              const SizedBox(height: 11),
              Container(
                width: size,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    data.name,
                    style: Styles.mainTxtTheme.overline.copyWith(color: Styles.appDarkBlueColor, fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> tap() async {
    data.url == '/init' || data.url == '/login' ? await Get.offAndToNamed(data.url) : Get.toNamed(data.url, arguments: model);
  }
}
