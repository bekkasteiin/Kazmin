import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/adaptation/other_periods.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

class AdaptationPeriodWidget extends StatefulWidget {
  const AdaptationPeriodWidget({Key key}) : super(key: key);

  @override
  _AdaptationPeriodWidgetState createState() => _AdaptationPeriodWidgetState();
}

class _AdaptationPeriodWidgetState extends State<AdaptationPeriodWidget> {
  @override
  Widget build(BuildContext context) {
    final AdaptationViewModel model = Provider.of<AdaptationViewModel>(context, listen: false);
    return SizedBox(
      child: Column(
        children: [
          pageTitle(title: S.current.currentAdaptationPlanPeriod),
          FutureBuilder<AdaptationPlan>(
            future: model.getCurrentAdaptationPlan,
            builder: (BuildContext context, AsyncSnapshot<AdaptationPlan> snapshot) {
              return SizedBox(
                height: 60,
                child: snapshot.hasError
                    ? const SizedBox()
                    : snapshot.hasData
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${formatShortly(snapshot.data.dateFrom)} - ${formatShortly(snapshot.data.dateTo)}',
                                style: Styles.mainTS,
                              ),
                              CupertinoButton(
                                child: Text(S.current.otherAdaptationPeriods),
                                onPressed: () {
                                  Get.to(
                                    ChangeNotifierProvider<AdaptationViewModel>.value(
                                      value: model,
                                      child: const OtherAdaptationPeriods(),
                                    ),
                                  );
                                },
                              )
                            ],
                          )
                        : const CupertinoActivityIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
