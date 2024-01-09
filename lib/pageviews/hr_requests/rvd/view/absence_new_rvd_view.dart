import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:kzm/pageviews/hr_requests/rvd/view/absence_new_rvd_requests_view.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

const String fName = 'lib/pageviews/hr_requests/rvd/view/absence_new_rvd_view.dart';

class AbsenceNewRvdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<AbsenceNewRvdModel>>[
        ChangeNotifierProvider<AbsenceNewRvdModel>(create: (_) => AbsenceNewRvdModel()),
      ],
      child: Consumer<CertificateModel>(
        builder: (BuildContext context, CertificateModel counter, _) {
          final AbsenceNewRvdModel model = context.read<AbsenceNewRvdModel>();
          return ScreenTypeLayout(
            mobile: AbsenceNewRvdRequestsView(model: model),
            tablet: AbsenceNewRvdRequestsView(model: model),
          );
        },
      ),
    );
  }
}
