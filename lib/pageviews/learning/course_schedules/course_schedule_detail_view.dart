import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CourseScheduleDetailView extends StatelessWidget {
  const CourseScheduleDetailView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LearningModel model =
    Provider.of<LearningModel>(context, listen: false);
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
                placeholder: S.current.course,
                textValue: model.currentCourseSchedule.nameLang1,
              ),
              FieldBones(
                placeholder: S.current.status,
                textValue: model.currentCourseSchedule.statusRu,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FieldBones(
                      placeholder: S.current.courseStartDate,
                      textValue:
                      formatShortly(model.currentCourseSchedule.startDate),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: FieldBones(
                      placeholder: S.current.courseTime,
                      textValue:
                      formatTime(model.currentCourseSchedule.startDate),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FieldBones(
                      placeholder: S.current.courseEndDate,
                      textValue:
                      formatShortly(model.currentCourseSchedule.endDate),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: FieldBones(
                      placeholder: S.current.courseTime,
                      textValue:
                      formatTime(model.currentCourseSchedule.endDate),
                    ),
                  ),
                ],
              ),
              FieldBones(
                placeholder: S.current.registrationIsOpenUntil ?? '',
                textValue:
                formatShortly(model.currentCourseSchedule.registrationIsOpenUntil),
              ),
              FieldBones(
                placeholder: '${S.current.durability} (часы)',
                textValue:
                model.currentCourseSchedule.duration?.toString() ?? '',
              ),
              FieldBones(
                placeholder: S.current.trainer,
                textValue:
                model.currentCourseSchedule.fullNameNumberCyrillic ?? '',
              ),
              FieldBones(
                placeholder: S.current.courseAddress?.toString() ?? '',
                textValue:
                model.currentCourseSchedule.addressRu ?? '',
              ),
              FieldBones(
                placeholder: S.current.placesLeft,
                textValue: model.currentCourseSchedule.placesLeft <= 0
                    ? '0'
                    : model.currentCourseSchedule.placesLeft?.toString() ?? '',
              ),
              SizedBox(
                height: 32.w,
              ),
              SizedBox(
                width: double.infinity,
                child: KzmButton(
                  bgColor: Styles.appSuccessColor,
                  disabled: model.currentCourseSchedule.status != null ||
                      model.currentCourseSchedule.placesLeft <= 0,
                  onPressed: model.currentCourseSchedule.status == null
                      ? () async {
                    await model.courseScheduleRequested();
                  }
                      : null,
                  child: Text(
                    model.currentCourseSchedule.status == null &&
                        model.currentCourseSchedule.placesLeft <= 0
                        ? 'Нет мест.'
                        : model.currentCourseSchedule.statusRu,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
