import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/vacation_schedule/vacation_schedule_request.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/vacation_schedule_model.dart';
import 'package:provider/provider.dart';

class VacationScheduleList extends StatefulWidget {
  const VacationScheduleList({Key key}) : super(key: key);

  @override
  _VacationScheduleListState createState() => _VacationScheduleListState();
}

class _VacationScheduleListState extends State<VacationScheduleList> {
  @override
  Widget build(BuildContext context) {
    final VacationScheduleRequestModel model =
        Provider.of<VacationScheduleRequestModel>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          await model.myVacations;
          setState(() {

          });
        },
        child: ListView(
          children: [
            FutureBuilder<List<VacationScheduleRequest>>(
              future: model.myVacations,
              builder: (BuildContext context,
                  AsyncSnapshot<List<VacationScheduleRequest>> snapshot) {
                if (snapshot.data == null) return const Center(child: LoaderWidget());
                final List<VacationScheduleRequest> list = snapshot.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.w, bottom: 24.w),
                    child: Column(
                      children: list.map((VacationScheduleRequest e) {
                        final String date =
                            '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)} (${e.absenceDays})';
                        return KzmCard(
                          statusColor: e.revision
                          ? Styles.appActiveFocusBorderColor
                          : e.approved
                          ? Styles.appSuccessColor
                          : Styles.appDarkGrayColor,
                          title: '№ ${e.requestNumber.toString()}',
                          subtitle: date,
                          trailing: Text(

                            e.approved
                            ? S.current.alreadyAgreed
                            : e.revision
                            ? S.current.outcomeRevision
                            : S.current.notAgreed,
                            textAlign: TextAlign.center,
                          ),
                          selected: () async {
                            await model.openRequest(e).then(
                                  (_) => setState(
                                    () {
                                      model.myVacations;
                                    },
                                  ),
                                );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.appPrimaryColor,
        onPressed: () async {
          await model.getRequestDefaultValue().then(
                (value) => setState(() {
                  model.myVacations;
                }),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
