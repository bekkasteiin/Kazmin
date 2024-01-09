import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/cached_image.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/learning/my_study_plan/my_study_plan_view.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CompulsoryCourses extends StatelessWidget {
  const CompulsoryCourses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearningModel()),
      ],
      child: Consumer<LearningModel>(
        builder: (BuildContext context, LearningModel leanringModel, _) => Scaffold(
          appBar: KzmAppBar(context: context, centerTitle: true),
          body: Consumer<AdaptationViewModel>(
            builder: (BuildContext context, AdaptationViewModel model, _) {
              return FutureBuilder<List<Course>>(
                future: model.getAdaptationCourses,
                builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          pageTitle(
                            title: S.current.newEmployeesRequiredCoursesAccordingToCourseMatrix,
                          ),
                          ...snapshot.data
                              .map(
                                (Course e) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        child: CachedImage(
                                          Kinfolk.getFileUrl(e?.logo?.id ?? '') as String,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              e.name,
                                              style: Styles.mainTS,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              '${e.educationPeriod} ${S.current.days} ',
                                              maxLines: 2,
                                              style: Styles.advertsText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          CupertinoButton(
                            child: Text(S.current.newEmployeesGotoLearningPlan),
                            onPressed: () => Get.to(
                              const MyStudyPlanView(),
                              arguments: leanringModel,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
