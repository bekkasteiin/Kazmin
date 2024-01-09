import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/learning/drawers.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:star_rating/star_rating.dart';

class CatalogList extends StatefulWidget {
  @override
  _CatalogListState createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;

    // TextEditingController controller = new TextEditingController();
    // List <Course> courseList;
    //
    // void filterSearchResults(String query, List<Course> list) {
    //   List<Course> searchList = [];
    //   searchList.addAll(list);
    //   if(query.isNotEmpty) {
    //     List<Course> listData = [];
    //     searchList.forEach((item) {
    //       if(item.instanceName.contains(query)) {
    //         listData.add(item);
    //       }
    //     });
    //     setState(() {
    //       list.clear();
    //       list.addAll(listData);
    //       controller.text = query;
    //       return;
    //     });
    //     } else {
    //       setState(() {
    //         list.clear();
    //         list.addAll(courseList);
    //         controller.text = query;
    //         return;
    //       });
    //   }
    // }
    return ValueListenableProvider<List<Course>>.value(
      value: model.coursesForCatalog,
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          actions: const <FilterButton>[
            FilterButton()
          ],
        ),
        endDrawer: MyLearningDrawer(model: model),
        body: SingleChildScrollView(
          child: Consumer<List<Course>>(
            builder: (BuildContext context, List<Course> list, Widget child) {

              return list == null || list.isEmpty
                  ? SizedBox(height: 8.w, width: 8.w, child: const LoaderWidget())
                  : Column(
                    children: list.map(
                      (Course e) {
                        final double size = 50.0.w;
                        // ignore: prefer_function_declarations_over_variables

                        return ListTile(
                          onTap: () => model.openCourse(e),
                          leading: SizedBox(
                            height: size,
                            width: size,
                            child: const Icon(Icons.cast_for_education),
                          ),
                          title: Text(e.instanceName),
                          subtitle: FutureBuilder<List<CourseReview>>(
                            future: RestServices.getCourseReviewsByCourseId(e.id),
                            builder: (BuildContext context, AsyncSnapshot<List<CourseReview>> snapshot) {
                              if (snapshot.data == null) {
                                return SizedBox(height: 4.w, width: 4.w, child: const LoaderWidget());
                              } else {
                                return StarRating(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  length: 5,
                                  // ignore: avoid_dynamic_calls
                                  rating: snapshot.data.fold(
                                        0.0,
                                        // ignore: always_specify_types
                                        (previousValue, CourseReview element) {
                                          // ignore: join_return_with_assignment
                                          previousValue += element.rate ?? 0.0;
                                          return previousValue;
                                        },
                                      ) /
                                      snapshot.data.length as double,
                                  between: 1.0,
                                  starSize: 15.0,
                                  onRaitingTap: (_) => model.openCourse(e),
                                  color: Colors.grey,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ).toList(),
                  );
            },
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {

  const FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_alt),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}
