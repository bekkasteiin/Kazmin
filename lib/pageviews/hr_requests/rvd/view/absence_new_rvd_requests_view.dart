import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_request.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/hr_requests/rvd/view/absence_new_rvd_requests_view.dart';

class AbsenceNewRvdRequestsView extends StatefulWidget {
  final AbsenceNewRvdModel model;

  const AbsenceNewRvdRequestsView({Key key, this.model}) : super(key: key);

  @override
  State<AbsenceNewRvdRequestsView> createState() => _AbsenceNewRvdRequestsViewState();
}


class _AbsenceNewRvdRequestsViewState extends State<AbsenceNewRvdRequestsView> {


  @override
  void initState() {
    // list();
    widget.model.refreshData = refreshData;
    super.initState();
  }

  void refreshData() {
    widget.model.getRequests().then((List<AbsenceNewRvdRequest> value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final AbsenceNewRvdModel model = context.read<AbsenceNewRvdModel>();
    final Future<List<AbsenceNewRvdRequest>> future = model.getRequests();
    return Scaffold(
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(context: context),
      body: FutureBuilder<List<AbsenceNewRvdRequest>>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<List<AbsenceNewRvdRequest>> _) {
          if (_.connectionState == ConnectionState.waiting) return const Center(child: LoaderWidget());
          // log('-->> $fName, build ->> count: ${_.data.length}');
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: Styles.appDoubleMargin, bottom: Styles.appDoubleMargin),
              child: Column(
                children: <Widget>[
                  pageTitle(title: S.current.rvd),
                  SizedBox(height: Styles.appDoubleMargin),
                  ..._.data.map((AbsenceNewRvdRequest e) {
                    // log('-->> $fName, AbsenceNewRvdRequest ->> e.requestNumber: ${e.requestNumber}, code: ${e.status?.code}');
                    return KzmCard(
                      statusColor: getColorByStatusCode(e.status?.code),
                      title: '${e.requestNumber} ${e.employee?.instanceName}',
                      subtitleWidget: Padding(
                        padding: EdgeInsets.only(top: Styles.appStandartMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Text>[
                            Text(e.absenceType?.instanceName, style: Styles.sendMessageFilesList),
                            Text('${formatFullNumeric(e.timeOfStarting)} - ${formatFullNumeric(e.timeOfFinishing)}', style: Styles.sendMessageFilesList),
                          ],
                        ),
                      ),
                      trailing: KzmIcons.next,
                      selected: () async {
                        // _model.request = e;
                        // // await _model.myLanguages;
                        // // await _model.myCertificateTypes;
                        // // await _model.myReceivingTypes;
                        // await _model.getUserInfo();
                        await model.openRequestById(e.id);
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await model.getRequestDefaultValue();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
