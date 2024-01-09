

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/course_schedule.dart';
import 'package:kzm/pageviews/learning/course_schedules/course_schedule_item.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class CourseScheduleGL extends StatelessWidget {
  final LearningModel model;
  final List<CourseSchedule> list;
  const CourseScheduleGL({@required this.list, @required this.model, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyGroupedListView<CourseSchedule, DateTime>(
      elements: list,
      order: StickyGroupedListOrder.DESC,
      groupBy: (CourseSchedule element) => DateTime(element.startDate.year, element.startDate.month),
      groupComparator: (DateTime value1, DateTime value2) => value2.compareTo(value1),
      itemComparator: (CourseSchedule element1, CourseSchedule element2) => element1.startDate.compareTo(element2.startDate),
      floatingHeader: true,
      // itemScrollController: controller,
      // initialScrollIndex: model.initialScrollIndex,
      groupSeparatorBuilder: (CourseSchedule element) => SizedBox(
        height: 40.w,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 130.w,
            decoration: BoxDecoration(
              color: Styles.appPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(16.w)),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                dateFormatMonthYear(element.startDate),
                // '${element.startDate.month}, ${element.startDate.year}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      indexedItemBuilder: (_, CourseSchedule element, int index) {
        return SafeArea(
          top: false,
          bottom: model.courseSchedules.first.id == element.id,
          child: CourseScheduleItem(
            element: element,
            model: model,
          ),
        );
      },
      // addSemanticIndexes: false,
    );
  }
}

