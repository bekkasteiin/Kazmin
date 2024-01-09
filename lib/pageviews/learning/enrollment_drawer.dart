import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course_category.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class EnrollmentDrawer extends StatelessWidget {
  final LearningModel model;

  const EnrollmentDrawer({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: FutureProvider(
              create: (BuildContext context) => model.enrollments,
              initialData: null,
              child: Consumer<List<DicCategory>>(
                builder: (BuildContext context, List<DicCategory> list, Widget child) {
                  return list == null
                      ? const CupertinoActivityIndicator()
                      : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 20,
                    alignment: WrapAlignment.center,
                    children: list
                        .map(
                          (DicCategory i) => GestureDetector(
                        onTap: () {
                          model.enrollmentsSelectedCategories.contains(i.id)
                              ? model.enrollmentsSelectedCategories.remove(i.id)
                              : model.enrollmentsSelectedCategories.add(i.id);
                          model.getFilteredEnrollments();
                          model.rebuild();
                        },
                        child: Chip(
                          label: Text(i.instanceName),
                          backgroundColor:
                          model.enrollmentsSelectedCategories.contains(i.id)
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                    )
                        .toList(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
