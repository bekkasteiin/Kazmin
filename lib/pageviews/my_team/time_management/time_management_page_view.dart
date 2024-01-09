import 'package:flutter/material.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_team/time_management/absence/absence_list.dart';
import 'package:kzm/pageviews/my_team/time_management/all_absence_request/all_absence_widget.dart';
import 'package:kzm/pageviews/my_team/time_management/rvd_request/absence_rvd_form_widget.dart';
import 'package:kzm/pageviews/my_team/time_management/schedule_request/schedule_offsets_form_widget.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class TimeManagementPageView extends StatefulWidget {
  @override
  _TimeManagementPageViewState createState() => _TimeManagementPageViewState();
}

class _TimeManagementPageViewState extends State<TimeManagementPageView> with TickerProviderStateMixin {
  TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    _controller.addListener(_handleTabSelection);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

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
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: S.current.absence),
            Tab(text: S.current.leaveRequest),
            Tab(text: S.current.shiftSchedule),
            const Tab(text: 'Утвержденные РВД, Сверхуроч.,Врем.перевод'),
          ],
          isScrollable: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height2 * 0.76,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    AbsenceListTeam(_controller),
                    AllAbsenceWidget(),
                    ScheduleOffsetsFormWidget(
                      model: model,
                    ),
                    AbsenceRvdForWidget(
                      model: model,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget absenceWidget({MyTeamModel model}) {
  //
  // }
}
