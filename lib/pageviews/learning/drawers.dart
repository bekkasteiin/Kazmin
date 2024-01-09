import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course_category.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class MyLearningDrawer extends StatelessWidget {
  final LearningModel model;

  const MyLearningDrawer({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: FutureProvider<List<DicCategory>>(
              create: (BuildContext context) => model.categories,
              initialData: null,
              child: Consumer<List<DicCategory>>(
                builder: (BuildContext context, List<DicCategory> list, Widget child) {
                  return list == null
                      ? const LoaderWidget()
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
                                    model.selectedCategories.contains(i.id) ? model.selectedCategories.remove(i.id) : model.selectedCategories.add(i.id);
                                    model.getFilteredCatalog();
                                    model.rebuild();
                                  },
                                  child: Chip(
                                    label: Text(i.instanceName),
                                    backgroundColor: model.selectedCategories.contains(i.id) ? Theme.of(context).primaryColor : null,
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
