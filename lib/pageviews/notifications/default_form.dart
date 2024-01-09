import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/layout/main_layout.dart';
import 'package:kzm/layout/widgets.dart';

class DefaultFormForTask extends StatelessWidget {
  final bool isTask;

  const DefaultFormForTask({Key key, this.isTask = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.cloud_upload_rounded,
                size: 70.w,
                color: Styles.appDarkGrayColor.withOpacity(0.5),
              ),
              Text(
                'Для просмотра этой заявки необходимо пройти на портал',
                style: TextStyle(fontSize: 22, color: Styles.appDarkGrayColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.w),
              Row(
                children: [
                  Expanded(
                    child: KzmButton(
                      child: Text(
                        'Хорошо',
                        style: Styles.mainTS.copyWith(color: Styles.appWhiteColor),
                      ),
                      onPressed: () => !isTask ? Get.to(MainLayout()) : Get.back(),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
