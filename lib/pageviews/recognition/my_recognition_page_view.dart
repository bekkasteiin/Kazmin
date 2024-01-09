import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';

class MyRecognitionPageView extends StatefulWidget {
  MainList list;
  MyRecognitionPageView({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  State<MyRecognitionPageView> createState() => _MyRecognitionPageViewState();
}

class _MyRecognitionPageViewState extends State<MyRecognitionPageView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          bottom: TabBar(
            isScrollable: false,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      widget.list.image,
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(widget.list.recognition[0].medal.getLangText(context)?? '')
                  ],
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: ListView.separated(
          itemCount: widget.list.recognition?.length ?? 0,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext _, int index) {
            var item = widget.list.recognition[index];
            return ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.issueDate,
                          style: Styles.mainTS.copyWith(
                            color: Styles.appDarkBlackColor,
                            fontSize: Styles.appDefaultFontSizeHeader,
                          ),
                        ),
                        Text(
                          formatFullNotMilSec(item.startDate) ?? '',
                          style: Styles.mainTS.copyWith(
                            color: Styles.appDarkBlackColor,
                            fontSize: Styles.appDefaultFontSizeHeader,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.pinStatus,
                          style: Styles.mainTS.copyWith(
                            color: Styles.appDarkBlackColor,
                            fontSize: Styles.appDefaultFontSizeHeader,
                          ),
                        ),
                        Text(
                          item.isActive ? S.current.valid : S.current.notValid,
                          style: Styles.mainTS.copyWith(
                            color: Styles.appDarkBlackColor,
                            fontSize: Styles.appDefaultFontSizeHeader,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.category,
                              style: Styles.mainTS.copyWith(
                                color: Styles.appDarkBlackColor,
                                fontSize: Styles.appDefaultFontSizeHeader,
                              ),
                            ),
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                item.awardType?.instanceName ?? '',
                                textAlign: TextAlign.end,
                                style: Styles.mainTS.copyWith(
                                  color: Styles.appDarkBlackColor,
                                  fontSize: Styles.appDefaultFontSizeHeader,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.criterion,
                              style: Styles.mainTS.copyWith(
                                color: Styles.appDarkBlackColor,
                                fontSize: Styles.appDefaultFontSizeHeader,
                              ),
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                item.criteria?.instanceName ?? '',
                                textAlign: TextAlign.end,
                                style: Styles.mainTS.copyWith(
                                  color: Styles.appDarkBlackColor,
                                  fontSize: Styles.appDefaultFontSizeHeader,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.expireDate,
                              style: Styles.mainTS.copyWith(
                                color: Styles.appDarkBlackColor,
                                fontSize: Styles.appDefaultFontSizeHeader,
                              ),
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                formatFullNotMilSec(item.endDate) ?? '',
                                textAlign: TextAlign.end,
                                style: Styles.mainTS.copyWith(
                                  color: Styles.appDarkBlackColor,
                                  fontSize: Styles.appDefaultFontSizeHeader,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.pinUpgrade,
                              style: Styles.mainTS.copyWith(
                                color: Styles.appDarkBlackColor,
                                fontSize: Styles.appDefaultFontSizeHeader,
                              ),
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                item.upgradedMedal?.getLangText(context) ?? '',
                                textAlign: TextAlign.end,
                                style: Styles.mainTS.copyWith(
                                  color: Styles.appDarkBlackColor,
                                  fontSize: Styles.appDefaultFontSizeHeader,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h,),

                      ],
                    ),
                  ),
                ]);
          },
          separatorBuilder: (BuildContext context, int index) => Container(
            height: 1,
            color: Styles.appBorderColor,
          ),
        )),
      ),
    );
  }
}
