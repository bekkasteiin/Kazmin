import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/trainin_calendar.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/learning/training_calendar/detail_training_calendar.dart';
import 'package:kzm/pageviews/learning/training_calendar/training_calendar_dc.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TrainingCalendarView extends StatefulWidget {
  const TrainingCalendarView({Key key}) : super(key: key);

  @override
  _TrainingCalendarViewState createState() => _TrainingCalendarViewState();
}

class _TrainingCalendarViewState extends State<TrainingCalendarView> {
  List<TrainingCalendar> trainingCalendar;

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      final TrainingCalendar appointment = calendarTapDetails.appointments[0] as TrainingCalendar;
      Navigator.push(
        context,
        MaterialPageRoute<MaterialPageRoute<dynamic>>(
          builder: (BuildContext context) => DetailTrainingCalendar(appointment: appointment),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: FutureBuilder<List<TrainingCalendar>>(
        future: model.getTrainingCalendar(),
        builder: (BuildContext context, AsyncSnapshot<List<TrainingCalendar>> snapshot) {
          if (snapshot.data == null) {
            return const LoaderWidget();
          }
          return SfCalendar(
            onTap: calendarTapped,
            view: CalendarView.month,
            // onViewChanged: _viewChanged,
            showDatePickerButton: true,
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Styles.appBrightBlueColor,
            ),
            dataSource: TrainingCalendarDataSource(model.trainingCalendars),
            firstDayOfWeek: 1,
            // allowedViews: const <CalendarView>[
            //   // CalendarView.day,
            //   CalendarView.week,
            //   CalendarView.month,
            // ],
            timeSlotViewSettings: const TimeSlotViewSettings(
              // startHour: 9,
              // endHour: 10,
              nonWorkingDays: <int>[DateTime.sunday, DateTime.saturday],
            ),
            monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              showTrailingAndLeadingDates: false,
              agendaItemHeight: 40.w,

              // appointmentDisplayCount: 6
              // showTrailingAndLeadingDates: false,
            ),
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Styles.appDarkBlueColor, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
              shape: BoxShape.rectangle,
            ),
            cellBorderColor: Styles.appPrimaryColor,
            showNavigationArrow: true,
          );
        },
      ),
    );
  }
}
