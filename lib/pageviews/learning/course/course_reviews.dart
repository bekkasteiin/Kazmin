import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:star_rating/star_rating.dart';

class CourseReviews extends StatelessWidget {
  final Course course;

  const CourseReviews({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestServices.getCourseReviewsByCourseId(course.id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return const CupertinoActivityIndicator();
        } else {
          return Column(
            children: snapshot.data
                .map(
                  (CourseReview e) {
                    return ListTile(
                      title: Text(e.personGroup.instanceName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.text),
                          StarRating(
                            mainAxisAlignment: MainAxisAlignment.start,
                            length: 5,
                            rating: e.rate,
                            between: 1.0,
                            starSize: 15.0,
                            onRaitingTap: (_) {},
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                )
                .toList()
                .cast<Widget>(),
          );
        }
      },
    );
  }
}
