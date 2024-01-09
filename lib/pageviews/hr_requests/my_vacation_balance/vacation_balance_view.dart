
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence_balance.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_balance_model.dart';
import 'package:provider/provider.dart';

class VacationBalanceView extends StatefulWidget {
  const VacationBalanceView();

  @override
  State<VacationBalanceView> createState() => _VacationBalanceViewState();
}

class _VacationBalanceViewState extends State<VacationBalanceView> {
  @override
  Widget build(BuildContext context) {
    final AbsenceBalanceModel model = Provider.of<AbsenceBalanceModel>(context, listen: false);
    final Future<List<AbsenceVacationBalance>> future = model.getRequests();
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: ListView(
        children: <Widget>[
          pageTitle(title: S.current.myVacationAbsenceBalance),
          FutureBuilder<List<AbsenceVacationBalance>>(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<List<AbsenceVacationBalance>> snapshot) {
              if (snapshot.data == null) {
                return Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child: const Center(
                    child: LoaderWidget(),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(4.0.w),
                  child: snapshot.data.isEmpty
                      ? noData
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pageTitle(title: '${S.current.myCurrentAbsenceBalance}:  ${model.myBalance}'),
                          Column(
                    children: snapshot.data.map((AbsenceVacationBalance e){
                          return Container(
                            margin: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Styles.appWhiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), //color of shadow
                                    spreadRadius: 1, //spread radius
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              borderRadius: BorderRadius.circular(8.w)
                            ),
                            child: ExpansionTile(
                              expandedAlignment: Alignment.centerLeft,
                              title: Text(
                                '${formatShortly(e.dateFrom) ?? ''}',
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${S.current.balanceDay}:  ${e.balanceDays?.toPrecision(1) ?? 0.0}'),
                                      SizedBox(height: 4.w,),
                                      Text('${S.current.additionalBalanceDay}:  ${e.additionalBalanceDays?.toPrecision(1) ?? 0.0}'),
                                      SizedBox(height: 4.w,),
                                      Text('${S.current.leftDay}:  ${e.daysLeft?.toPrecision(1) ?? 0.0}'),
                                      SizedBox(height: 4.w,),
                                      Text('${S.current.extraLeftDay}:  ${e.extraDaysLeft?.toPrecision(1) ?? 0.0}'),
                                      SizedBox(height: 4.w,),
                                      Text('${S.current.ecologicalDueDays}:  ${e.ecologicalDueDays?.toPrecision(1) ?? 0.0}'),
                                      SizedBox(height: 4.w,),
                                      Text('${S.current.ecologicalDaysLeft}:  ${e.ecologicalDaysLeft?.toPrecision(1) ?? 0.0}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                    }).toList(),
                  ),
                        ],
                      )
                );
              }
            },
          ),
          const SafeArea(child: SizedBox())
        ],
      ),
    );
  }
}

