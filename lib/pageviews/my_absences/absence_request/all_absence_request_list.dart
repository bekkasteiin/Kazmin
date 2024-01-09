import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/all_absence.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:provider/provider.dart';

class AllAbsencesRequestList extends StatelessWidget {
  const AllAbsencesRequestList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbsenceRequestModel absenceRequestModel = Provider.of<AbsenceRequestModel>(context, listen: false);
    // ignore: always_specify_types
    return FutureProvider(
      create: (BuildContext context) => absenceRequestModel.allRequest,
      initialData: null,
      child: Scaffold(
        body: Consumer<List<AllAbsenceRequest>>(
          builder: (BuildContext context, List<AllAbsenceRequest> list, Widget child) {
            return list == null
                ? const LoaderWidget()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.w, bottom: 24.w),
                      child: Column(
                        children: list.map(
                          (AllAbsenceRequest e) {
                            final String dates = '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)}';
                            final int absenceDays = e?.absenceDays;
                            final String data = absenceDays != null ? '  ($absenceDays)' : '';
                            // log('-->> $fName, build ->> status: ${e.status.toJSON()}');
                            return KzmCard(
                              selected: () => absenceRequestModel.openAllAbsenceByName(
                                context: context,
                                allAbsence: e,
                              ),
                              title: e?.type?.instanceName ?? '',
                              maxLinesTitle: 3,
                              subtitle: dates + data,
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '№ ${e.requestNumber.toString() ?? ''}',
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    e.status.instanceName ?? '',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              statusColor: getColorByStatusCode(e?.status?.code),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => absenceRequestModel.getRequestDefaultValue(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
