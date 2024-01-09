import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class ScheduleOffsetsFormList extends StatelessWidget {
  const ScheduleOffsetsFormList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScheduleRequestModel model = Provider.of<ScheduleRequestModel>(context, listen: false);
    final MyTeamModel teamModel = Provider.of<MyTeamModel>(context);
    model.assignmentGroupId = teamModel.personProfile.assignmentGroupId;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: model.getRequests,
            builder: (BuildContext context, AsyncSnapshot<List<ScheduleOffsetsRequest>> snapshot) {
              if (snapshot.data == null) {
                return Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child: const Center(
                    child: LoaderWidget(),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: snapshot.data.isEmpty
                      ? noData
                      : Column(
                          children: snapshot.data.map((ScheduleOffsetsRequest e) {
                          final String status = e?.status?.instanceName;
                          final String requestDate = formatShortly(e.requestDate);
                          return KzmCard(
                            title: e?.newSchedule?.instanceName ?? '',
                            subtitle: requestDate,
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("№ ${e.requestNumber.toString() ?? ''}"),
                                Text(status ?? ''),
                              ],
                            ),
                            statusColor: e.status.code == 'REJECT'
                                ? Styles.appRejectBtnColor
                                : e.status.code == 'APPROVED'
                                    ? Styles.appSuccessColor
                                    : e.status.code == 'APPROVING'
                                        ? Styles.appDarkYellowColor
                                        : e.status.code == 'DRAFT'
                                            ? Styles.appDarkGrayColor
                                            : Colors.transparent,
                          );
                        }).toList(),),
                );
              }
            },),
      ),
    );
  }
}
