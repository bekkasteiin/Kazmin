
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence_for_recall.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:provider/provider.dart';

class AbsenceRecallWidget extends StatefulWidget {
  const AbsenceRecallWidget();

  @override
  State<AbsenceRecallWidget> createState() => _AbsenceRecallWidgetState();
}

class _AbsenceRecallWidgetState extends State<AbsenceRecallWidget> {
  @override
  Widget build(BuildContext context) {
    final AbsenceForRecallModel model = Provider.of<AbsenceForRecallModel>(context, listen: false);
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: RefreshIndicator(
        onRefresh: () => model.getRequests(update: true).then((_) => setState(() {})),
        child: ListView(
          children: <Widget>[
            pageTitle(title: S.current.absenceForRecall),
            FutureBuilder<List<AbsenceForRecall>>(
              future: model.getRequests(),
              builder: (BuildContext context, AsyncSnapshot<List<AbsenceForRecall>> snapshot) {
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
                          .map((AbsenceForRecall e) {
                        return KzmCard(
                          selected: () async {
                            await model.openRequest(e);
                          },
                          maxLinesTitle: 2,
                          title: e?.employee?.instanceName ?? '',
                          subtitle: '${formatShortly(e.dateFrom)} - ${formatShortly(e.dateTo)}',
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

