import 'package:flutter/material.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/my_team/time_management/rvd_request/absence_rvd_form_list.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_rvd_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class AbsenceRvdForWidget extends StatefulWidget {
  final MyTeamModel model;

  const AbsenceRvdForWidget({Key key, this.model}) : super(key: key);

  @override
  _AbsenceRvdForWidgetState createState() => _AbsenceRvdForWidgetState();
}

class _AbsenceRvdForWidgetState extends State<AbsenceRvdForWidget> with TickerProviderStateMixin {
  TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        _currentIndex = _controller.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height2 = MediaQuery.of(context).size.height;
    final MyTeamModel model = Provider.of<MyTeamModel>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                controller: _controller,
                // ignore: always_specify_types
                tabs: const [
                  Tab(text: 'Утвержденные РВД,Сверхуроч.,Врем.перевод'),
                  Tab(text: 'Заявка на РВД,Сверхуроч.,Врем.перевод'),
                ],
                isScrollable: true,
              ),
              SizedBox(
                height: height2 * 0.7,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    absenceRvdWidget(model: model),
                    const AbsenceRvdFormList(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget absenceRvdWidget({MyTeamModel model}) {
    final AbsenceRvdModel absenceRvdModel = Provider.of<AbsenceRvdModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: model.absenceList.map((Absence e) {
              return
                  // true
                  e.type.workOnWeekend || e.type.overtimeWork || e.type.temporaryTransfer
                      ? KzmCard(
                          title: e.type?.instanceName,
                          subtitle: e.instanceName,
                        )
                      : Container();
            }).toList(),
          ),
        ),
      ),
      // ignore: require_trailing_commas
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await absenceRvdModel.getRequestDefaultValue().then(
                (value) => setState(() {
                  _controller.index = 1;
                }),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
