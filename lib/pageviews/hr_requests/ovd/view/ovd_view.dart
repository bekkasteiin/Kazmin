import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:kzm/pageviews/hr_requests/rvd/view/absence_new_rvd_requests_view.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../ovd_model.dart';
import 'ovd_requests_view.dart';

const String fName = 'lib/pageviews/hr_requests/ovd/view/ovd_view.dart';

class OvdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<OvdModel>>[
        ChangeNotifierProvider<OvdModel>(create: (_) => OvdModel()),
      ],
      child: Consumer<CertificateModel>(
        builder: (BuildContext context, CertificateModel counter, _) {
          final OvdModel model = context.read<OvdModel>();
          return ScreenTypeLayout(
            mobile: OvdRequestsView(model: model),
            tablet: OvdRequestsView(model: model),
          );
        },
      ),
    );
  }
}
