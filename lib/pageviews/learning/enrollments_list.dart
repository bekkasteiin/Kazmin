import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/pageviews/learning/course/course_info.dart';
import 'package:kzm/pageviews/learning/enrollment_drawer.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class EnrollmentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;
    return ValueListenableProvider<List<Course>>.value(
      value: model.enrollmentsForShow,
      child: Scaffold(
        // appBar: defaultAppBar(context, actions: [
        //       FilterButton(
        //         model: model,
        //       )
        // ]),
        appBar: KzmAppBar(
          context: context,
          actions: <FilterButton>[
            FilterButton(model: model),
          ],
        ),
        endDrawer: EnrollmentDrawer(
          model: model,
        ),
        body: SingleChildScrollView(
          child: Consumer<List<Course>>(
            builder: (BuildContext context, List<Course> list, Widget child) {
              return list == null || list.isEmpty
                  ? const CupertinoActivityIndicator()
                  : SingleChildScrollView(
                      child: Column(
                        children: list.map(
                          (Course e) {
                            const double size = 50.0;
                            return ListTile(
                                onTap: () {
                                  model.selectedCourse = e;
                                  Get.to(ChangeNotifierProvider.value(
                                    value: model,
                                    child: CourseInfo(),
                                  ),);
                                },
                                leading: const SizedBox(
                                  height: size,
                                  width: size,
                                  child: Icon(Icons.cast_for_education),
                                ),
                                title: Text(
                                  e.instanceName,
                                ),
                                subtitle: e.isOnline != null ? Text(e.isOnline ? 'online' : 'offline') : const Text(''),);
                          },
                        ).toList(),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final LearningModel model;

  const FilterButton({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_alt),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}
