import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/rvd/absence_rvd_request.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_rvd_model.dart';
import 'package:provider/provider.dart';

class AbsenceRvdFormList extends StatelessWidget {
  const AbsenceRvdFormList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbsenceRvdModel model = Provider.of<AbsenceRvdModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: model.getRequests,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) return const Center(child: LoaderWidget());
            return Padding(
              padding: EdgeInsets.all(4.0.w),
              child: Column(
                children: model.allRequestList.map((AbsenceRvdRequest e) {
                  return KzmCard(
                    title: e.type?.instanceName ?? '',
                    subtitle: formatShortly(e.requestDate),
                    selected: () async {
                      await model.openRequestById(e.id);
                    },
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("№ ${e.requestNumber.toString() ?? ''}"),
                        Text(e.status?.instanceName ?? ''),
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
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
