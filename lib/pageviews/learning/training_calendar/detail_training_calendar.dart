import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/trainin_calendar.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';

class DetailTrainingCalendar extends StatelessWidget {
  final TrainingCalendar appointment;

  const DetailTrainingCalendar({this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: ListView(
        children: <Widget>[
          contentShadow(
            children: <Widget>[
              FieldBones(
                placeholder: S.current.name,
                textValue: appointment.courseSchedule.instanceName,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FieldBones(
                      placeholder: S.current.courseStartDate,
                      textValue: formatShortly(appointment.courseSchedule.startDate),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: FieldBones(
                      placeholder: S.current.courseTime,
                      textValue: formatTime(appointment.courseSchedule.startDate),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FieldBones(
                      placeholder: S.current.courseEndDate,
                      textValue: formatShortly(appointment.courseSchedule.endDate),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: FieldBones(
                      placeholder: S.current.courseTime,
                      textValue: formatTime(appointment.courseSchedule.endDate),
                    ),
                  ),
                ],
              ),
              FieldBones(
                placeholder: S.current.courseDurationHours ?? '',
                textValue: appointment.courseSchedule.duration?.toString() ?? '',
              ),
              FieldBones(
                placeholder: S.current.courseAddress,
                textValue: appointment.courseSchedule.address ?? '',
              ),
              FieldBones(
                placeholder: S.current.trainer,
                textValue: appointment.courseSchedule.trainer?.employee?.fullName ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
