import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/pageviews/learning/course/enrollment/course_content.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CourseEnrollment extends StatefulWidget {
  @override
  _CourseEnrollmentState createState() => _CourseEnrollmentState();
}

class _CourseEnrollmentState extends State<CourseEnrollment> {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    const double size = 150.0;
    const EdgeInsets insets = EdgeInsets.symmetric(horizontal: 8);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: defaultAppBar(context),
        appBar: KzmAppBar(context: context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: insets,
                child: Text(
                  model.selectedCourse.instanceName,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              FutureProvider<bool>(
                create: (_) => model.getCourse(model.selectedCourse.id),
                initialData: null,
                child: Consumer<bool>(
                  builder: (BuildContext context, bool data, _) {
                    return data == null
                        ? const CupertinoActivityIndicator()
                        : Column(
                            children: model.selectedCourse.sections
                                .map(
                                  (Section e) => Card(
                                    child: ListTile(
                                      title: Text(e.instanceName),
                                      subtitle: Text(e?.format?.instanceName ?? ''),
                                      trailing: model.checkAttempt(e)
                                          ? const Icon(Icons.check_box)
                                          : const Icon(Icons.check_box_outline_blank),
                                      onTap: () async {
                                        model.index = 0;
                                        model.answersForCheck = {};
                                        Get.to(
                                          ChangeNotifierProvider.value(
                                            value: model,
                                            child: CourseContent(e),
                                          ),
                                          preventDuplicates: false,
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
