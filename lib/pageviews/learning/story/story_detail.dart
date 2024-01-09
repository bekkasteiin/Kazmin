import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class StoryDetail extends StatelessWidget {
  final Course course;

  const StoryDetail({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context, listen: false);
    String courseTrainer = '';
    if (course != null && course.courseTrainers.isNotEmpty) {
      for (final CourseTrainer element in course.courseTrainers) {
        if (courseTrainer.trim().isNotEmpty) {
          courseTrainer += ', \n';
        }
        // ignore: use_string_buffers
        courseTrainer += element?.trainer?.instanceName ?? '';
      }
    }
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        child: contentShadow(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16.w,
              ),
              FieldBones(
                placeholder: 'Курс',
                textValue: model.currentLearningHistory.course,
              ),
              FieldBones(
                placeholder: S.current.status,
                textValue: model.currentLearningHistory.enrollmentStatus,
              ),
              FieldBones(
                placeholder: S.current.startDate,
                textValue: formatShortly(model.currentLearningHistory.startDate),
              ),
              FieldBones(
                placeholder: S.current.endDate,
                textValue: formatShortly(model.currentLearningHistory.endDate),
              ),
              FieldBones(
                placeholder: 'Длительность (часы)',
                textValue: course?.educationDuration?.toString() ?? '',
              ),
              // FieldBones(
              //   placeholder: S.current.adress,
              //   textValue: course?.description,
              // ),
              // if (course != null && course.courseTrainers.isNotEmpty)
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Тренер',
              //         style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
              //       ),
              //       SizedBox(
              //         height: 7.w,
              //       ),
              //       ...course.courseTrainers.map((CourseTrainer e) => Text(e.trainer.instanceName)).toList(),
              //     ],
              //   ),
              FieldBones(
                placeholder: 'Тренер',
                textValue: courseTrainer,
                maxLinesSubTitle: 10,
              ),
              FieldBones(
                placeholder: S.current.category,
                textValue: course.category.instanceName,
              ),
              if (model.currentLearningHistory.certificate != null)
                SizedBox(
                  width: double.infinity,
                  child: KzmButton(
                    bgColor: Styles.appSuccessColor,
                    child: Text(S.current.showCertificate),
                    onPressed: () => model.downloadCertificateOrBook(model.currentLearningHistory.certificate),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
