import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:kzm/core/models/entities/other/person_profile.dart';
//import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_model.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/view/dismissal_requests_view.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

const String fName = 'lib/pageviews/hr_requests/dismissal/view/dismissal_view.dart';

class DismissalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<DismissalModel>>[
        ChangeNotifierProvider<DismissalModel>(create: (_) => DismissalModel()),
      ],
      child: Consumer<CertificateModel>(
        builder: (BuildContext context, CertificateModel counter, _) {
          final DismissalModel model = context.read<DismissalModel>();
          return ScreenTypeLayout(
            mobile: DismissalRequestsView(model: model),
            tablet: DismissalRequestsView(model: model),
          );
        },
      ),
    );
  }
}