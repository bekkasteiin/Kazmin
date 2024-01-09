import 'package:flutter/material.dart';
import 'package:kzm/core/models/trainin_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TrainingCalendarDataSource extends CalendarDataSource {
  TrainingCalendarDataSource(List<TrainingCalendar> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].courseSchedule.startDate as DateTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].courseSchedule.endDate as DateTime;
  }

  @override
  String getSubject(int index) {
    return appointments[index].courseSchedule.instanceName as String;
  }

  @override
  Color getColor(int index) {
    if (index % 9 == 0) {
      return Colors.blueAccent;
    }

    if (index % 8 == 0) {
      return Colors.deepPurpleAccent;
    }

    if (index % 7 == 0) {
      return Colors.pinkAccent;
    }

    if (index % 6 == 0) {
      return Colors.cyan;
    }

    if (index % 5 == 0) {
      return Colors.grey;
    }

    if (index % 4 == 0) {
      return Colors.green;
    }

    if (index % 3 == 0) {
      return Colors.teal;
    }

    if (index % 2 == 0) {
      return Colors.purple;
    }

    return Colors.orangeAccent;
    // return getColor(index);
  }

  @override
  bool isAllDay(int index) {
    return true;
  }

// Color getColorByIndex(int index) {
//   if(index % 2 == 0){
//     return Colors.blueAccent;
//   }
//   return Colors.orangeAccent;
// }
}