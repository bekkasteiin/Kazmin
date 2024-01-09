import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

class OtherAdaptationPeriods extends StatelessWidget {
  const OtherAdaptationPeriods({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdaptationViewModel model = Provider.of<AdaptationViewModel>(context);
    final List<AdaptationPlan> plans = model.plans;
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: ListView(
        children: [
          pageTitle(title: S.current.history),
          ...plans
              .mapIndexed(
                (int index, AdaptationPlan e) => Column(
                  children: <Widget>[
                    if (index != plans.length)
                      Divider(
                        height: 1.w,
                        color: Styles.appBorderColor,
                        thickness: 1.w,
                      ),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${formatShortly(e.dateFrom)} - ${formatShortly(e.dateTo)}',
                            style: Styles.mainTS,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            e.planName,
                            style: Styles.advertsText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                      ),
                      tileColor: Colors.white,
                    ),
                    if (index == plans.length - 1)
                      Divider(
                        height: 1.w,
                        color: Styles.appBorderColor,
                        thickness: 1.w,
                      ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
