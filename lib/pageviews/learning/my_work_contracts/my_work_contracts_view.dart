import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person_learning_contract.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class MyWorkContractsView extends StatelessWidget {
  const MyWorkContractsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;

    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: ListView(
        children: [
          pageTitle(title: S.current.myWorkContracts, fontSize: 16.w),
          FutureBuilder<List<PersonLearningContract>>(
            future: model.getMyWorkContracts(),
            builder: (BuildContext context, AsyncSnapshot<List<PersonLearningContract>> snapshot) {
              if (snapshot.data == null) {
                return const LoaderWidget();
              }
              return Column(
                children: [
                  ...snapshot.data.map((PersonLearningContract e) {
                    return KzmCard(
                      title: e.courseScheduleEnrollment.courseSchedule.instanceName,
                      subtitle: formatShortly(e.termOfService),
                      selected: () => model.openPersonLearningContract(e),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            e.courseScheduleEnrollment.totalCost != null
                                ? (double.tryParse(model.balanceCalculation(e)) < 0 ? 0.toString() : model.balanceCalculation(e))
                                : '',
                            style: Styles.mainTS,
                          ),
                          // Text(
                          //   e.courseScheduleEnrollment.status,
                          //   style: Styles.mainTS.copyWith(
                          //     fontSize: Styles.appAdvertsFontSize,
                          //     color: Styles.appDarkGrayColor,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }).toList()
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
