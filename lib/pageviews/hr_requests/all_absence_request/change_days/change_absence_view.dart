import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/change_days_request.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:provider/provider.dart';

class ChangeAbsenceWidget extends StatefulWidget {
  const ChangeAbsenceWidget();

  @override
  State<ChangeAbsenceWidget> createState() => _ChangeAbsenceWidgetState();
}

class _ChangeAbsenceWidgetState extends State<ChangeAbsenceWidget> {
  @override
  Widget build(BuildContext context) {
    final ChangeAbsenceModel model = Provider.of<ChangeAbsenceModel>(context, listen: false);
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: RefreshIndicator(
        onRefresh: () => model.getRequests(update: true).then((_) => setState(() {})),
        child: ListView(
          children: <Widget>[
            pageTitle(title: S.current.changeAbsenceTitle),
            FutureBuilder<List<ChangeAbsenceDaysRequest>>(
              future: model.getRequests(),
              builder: (BuildContext context, AsyncSnapshot<List<ChangeAbsenceDaysRequest>> snapshot) {
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
                            children: snapshot.data
                                .map((ChangeAbsenceDaysRequest e) {
                                  return KzmCard(
                                    selected: () async {
                                      await model.openRequest(e);
                                    },
                                    maxLinesTitle: 2,
                                    title: e?.employee?.instanceName ?? '',
                                    subtitle: '${formatShortly(e.scheduleStartDate)} - ${formatShortly(e.scheduleEndDate)}',
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
            const SafeArea(child: SizedBox())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          await model.getRequestDefaultValue().then((_) => setState(() {}));
        },
      ),
    );
  }
}
