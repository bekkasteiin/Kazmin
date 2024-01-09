import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/rvd/assignment_schedule.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/my_team/time_management/schedule_request/shedule_offsets_form_list.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class ScheduleOffsetsFormWidget extends StatefulWidget {
  final MyTeamModel model;

  const ScheduleOffsetsFormWidget({Key key, this.model}) : super(key: key);

  @override
  _ScheduleOffsetsFormWidgetState createState() => _ScheduleOffsetsFormWidgetState();
}

class _ScheduleOffsetsFormWidgetState extends State<ScheduleOffsetsFormWidget> with TickerProviderStateMixin {
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

  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        _currentIndex = _controller.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final ScheduleRequestModel model = Provider.of<ScheduleRequestModel>(context);
    final MyTeamModel teamModel = Provider.of<MyTeamModel>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TabBar(
                controller: _controller,
                isScrollable: true,
                tabs: [
                  Tab(text: S.current.shiftSchedule),
                  Tab(text: S.current.shiftScheduleRequest),
                ],
                // isScrollable: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    scheduleWidget(model: model, teamModel: teamModel),
                    const ScheduleOffsetsFormList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget scheduleWidget({ScheduleRequestModel model, MyTeamModel teamModel}) {
    model.assignmentGroupId = teamModel.personProfile.assignmentGroupId;
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: model.getAssignmentSchedules(),
              builder: (BuildContext context, AsyncSnapshot<List<AssignmentSchedule>> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    margin: EdgeInsets.only(top: 20.w),
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: snapshot.data.map((AssignmentSchedule e) {
                        final String dates = '${formatShortly(e.startDate)} - ${formatShortly(e.endDate)}';
                        return KzmCard(
                          title: e.schedule?.instanceName ?? '',
                          subtitle: dates,
                        );
                      }).toList(),
                    ),
                  );
                }
              },),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await model.getRequestDefaultValue().then(
                (_) => setState(() {
                  _controller.index = 1;
                }),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
