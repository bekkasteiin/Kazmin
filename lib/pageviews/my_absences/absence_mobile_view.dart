import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/models/portal_menu_customization.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/my_absences/absence/absence_list.dart';
import 'package:kzm/pageviews/my_absences/absence_request/all_absence_request_list.dart';
import 'package:kzm/pageviews/my_absences/vacation/vacation_schedule_list.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:kzm/viewmodels/bpm_requests/vacation_schedule_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AbsencePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AbsenceModel>(create: (BuildContext context) => AbsenceModel()),
        ChangeNotifierProvider<AbsenceRequestModel>(create: (BuildContext context) => AbsenceRequestModel()),
        ChangeNotifierProvider<ChangeAbsenceModel>(create: (BuildContext context) => ChangeAbsenceModel()),
        ChangeNotifierProvider<LeavingVacationModel>(create: (BuildContext context) => LeavingVacationModel()),
        ChangeNotifierProvider<VacationScheduleRequestModel>(create: (BuildContext context) => VacationScheduleRequestModel()),
      ],
      child: Consumer<AbsenceModel>(
        builder: (BuildContext context, AbsenceModel counter, _) {
          return ScreenTypeLayout(
            mobile: AbsencePage(),
            tablet: AbsencePage(),
          );
        },
      ),
    );
  }
}

class AbsencePage extends StatefulWidget {
  @override
  _AbsencePageState createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final PortalMenuCustomization vacationSchedule = Provider.of<UserViewModel>(context, listen: false)
        .portalMenuCustomization
        .firstWhere((PortalMenuCustomization element) => element.menuItem == 'vacationSchedule.my', orElse: () => null);

    return DefaultTabController(
      length: vacationSchedule != null ? 3 : 2,
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          bottom: TabBar(
            isScrollable: vacationSchedule != null,
            tabs: <Tab>[
              Tab(text: S.current.myAbsences),
              Tab(text: S.current.absenceRequest),
              if (vacationSchedule != null) Tab(text: S.current.vacationSchedule),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const AbsenceList(),
            const AllAbsencesRequestList(),
            if (vacationSchedule != null) const VacationScheduleList(),
          ],
        ),
      ),
    );
  }
}
