import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:provider/provider.dart';

class AbsenceList extends StatelessWidget {
  const AbsenceList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LeavingVacationModel leavingVacationModel = Provider.of<LeavingVacationModel>(context, listen: false);

    return FutureProvider<List<AbsenceRequest>>(
      create: (BuildContext context) => Provider.of<AbsenceModel>(context,listen: false).absences,
      initialData: null,
      child: Scaffold(
        body: Consumer<List<AbsenceRequest>>(
          builder: (BuildContext context, List<AbsenceRequest> list, Widget child) {
            return list == null
                ? const LoaderWidget()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.w, bottom: 24.w),
                      child: Column(
                        children: list.map(
                          (AbsenceRequest e) {
                            final String dates = '${formatShortly(e.dateFrom)} - ${formatShortly(e.dateTo)}';
                            final int absenceDays = e?.absenceDays;
                            final String data = absenceDays != null ? '  ($absenceDays)' : '';
                            return KzmCard(
                              title: e?.type?.instanceName ?? '',
                              subtitle: dates + data,
                              trailing: e.type.availableForLeavingVacation
                                  ? IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      onPressed: () {
                                        leavingVacationModel.selectedAbsence = e;
                                        leavingVacationModel.getRequestDefaultValue();
                                      },
                                    )
                                  : null,
                              // statusColor: ,
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
          onPressed: () => Provider.of<AbsenceRequestModel>(context, listen: false).getRequestDefaultValue(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
