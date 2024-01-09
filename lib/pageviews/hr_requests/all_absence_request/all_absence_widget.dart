
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/all_absence.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class AllAbsenceWidget extends StatefulWidget {
  final String enitityName;
  final String title;

  const AllAbsenceWidget(this.enitityName, this.title);

  @override
  State<AllAbsenceWidget> createState() => _AllAbsenceWidgetState();
}

class _AllAbsenceWidgetState extends State<AllAbsenceWidget> {
  @override
  Widget build(BuildContext context) {
    final AbsenceForRecallModel absenceRecallModel = Provider.of<AbsenceForRecallModel>(context, listen: false);
    final ChangeAbsenceModel changeAbsenceModel = Provider.of<ChangeAbsenceModel>(context, listen: false);
    final AbsenceRequestModel absenceRequestModel = Provider.of<AbsenceRequestModel>(context, listen: false);
    final MyTeamModel model = Provider.of<MyTeamModel>(context, listen: false);
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: RefreshIndicator(
        onRefresh: () => model.getAllAbsence(update: true).then((List<AllAbsenceRequest> value) => setState((){})),
        child: ListView(
          children: <Widget>[
            pageTitle(title: widget.title),
            FutureBuilder<List<AllAbsenceRequest>>(
              future: model.getAllAbsence(),
              builder: (BuildContext context, AsyncSnapshot<List<AllAbsenceRequest>> snapshot) {
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
                    child: snapshot.data
                        .where((AllAbsenceRequest element) => element.allAbsenceRequestEntityName == widget.enitityName)
                        .isEmpty
                        ? noData
                        : Column(
                      children: snapshot.data
                          .where((AllAbsenceRequest element) => element.allAbsenceRequestEntityName == widget.enitityName)
                          .map((AllAbsenceRequest e) {
                        return KzmCard(
                          selected: () async {
                            if (e.allAbsenceRequestEntityName == 'tsadv_AbsenceForRecall') {
                              await absenceRecallModel.openRequestById(e.id);
                            } else if (e.allAbsenceRequestEntityName == 'tsadv_ChangeAbsenceDaysRequest') {
                              await changeAbsenceModel.openRequestById(e.id);
                            } else if (e.allAbsenceRequestEntityName == 'tsadv\$AbsenceRequest') {
                              await absenceRequestModel.openRequestById(e.id);
                            } else {
                              print(e.allAbsenceRequestEntityName);
                            }
                          },
                          maxLinesTitle: 2,
                          title: e?.type?.instanceName ?? '',
                          subtitle: '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)}',
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("№ ${e.requestNumber.toString() ?? ''}"),
                              Text(e?.status?.instanceName ?? ''),
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
                      })
                          .toList()
                          .cast<Widget>(),
                    ),
                  );
                }
              },
            ),
            const SafeArea(child:  SizedBox())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          if(widget.enitityName == 'tsadv_ChangeAbsenceDaysRequest'){
            await changeAbsenceModel.getRequestDefaultValue();
          }
        },
      ),
    );
  }
}
