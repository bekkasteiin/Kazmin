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

import '../ovd_model.dart';
import '../ovd_request.dart';

const String fName = 'lib/pageviews/hr_requests/ovd/view/ovd_requests_view.dart';

class OvdRequestsView extends StatefulWidget {
  final OvdModel model;

  const OvdRequestsView({Key key, this.model}) : super(key: key);

  @override
  State<OvdRequestsView> createState() => _OvdRequestsViewState();
}

class _OvdRequestsViewState extends State<OvdRequestsView> {
  @override
  void initState() {
    // list();
    widget.model.refreshData = refreshData;
    super.initState();
  }

  void refreshData() {
    widget.model.getRequests().then((List<OvdRequest> value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final OvdModel model = context.read<OvdModel>();
    final Future<List<OvdRequest>> future = model.getRequests();
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: FutureBuilder<List<OvdRequest>>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<List<OvdRequest>> _) {
          if (_.connectionState == ConnectionState.waiting) return const Center(child: LoaderWidget());
          // log('-->> $fName, build ->> count: ${_.data.length}');
          // log('-->> $fName, build ->> data: ${_.data}');
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: Styles.appDoubleMargin, bottom: Styles.appDoubleMargin),
              child: Column(
                children: <Widget>[
                  pageTitle(title: S.current.ovd),
                  SizedBox(height: Styles.appDoubleMargin),
                  ..._.data.map((OvdRequest e) {
                    // log('-->> $fName, OvdRequest ->> e.requestNumber: ${e.requestNumber}, code: ${e.status?.code}');
                    return KzmCard(
                      statusColor: getColorByStatusCode(e.status?.code),
                      title: '${e.requestNumber} ${e.personGroup?.instanceName}',
                      subtitleWidget: Padding(
                        padding: EdgeInsets.only(top: Styles.appStandartMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Text>[
                            // Text(e.absenceType?.instanceName, style: Styles.sendMessageFilesList),
                            Text(
                              '${formatFullNumeric(e.startDate.add(Duration(hours: e.startTime.hour, minutes: e.startTime.minute, seconds: e.startTime.second)))} - ${formatFullNumeric(e.endDate.add(Duration(hours: e.endTime.hour, minutes: e.endTime.minute, seconds: e.endTime.second)))}',
                              style: Styles.sendMessageFilesList,
                            ),
                          ],
                        ),
                      ),
                      trailing: KzmIcons.next,
                      selected: () async {
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
