import 'package:flutter/material.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:star_rating/star_rating.dart';

class LeaveCourseReview extends StatefulWidget {
  final Course course;

  const LeaveCourseReview({Key key, this.course}) : super(key: key);

  @override
  _LeaveCourseReviewState createState() => _LeaveCourseReviewState();
}

class _LeaveCourseReviewState extends State<LeaveCourseReview> {
  num rating = 0.0;
  Map<String, dynamic> courseReview = {
    'entityName': 'tsadv\$CourseReview',
  };

  @override
  void initState() {
    super.initState();
    courseReview.putIfAbsent(
      'course',
      () => {
        'id': widget.course.id,
        'entityName': 'tsadv\$Course',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    return model.leavedReview
        ? const SizedBox()
        : ListTile(
            title: TextFormField(
              maxLines: null,
              onChanged: (String text) {
                courseReview['text'] = text;
              },
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(
                  mainAxisAlignment: MainAxisAlignment.start,
                  length: 5,
                  rating: courseReview['rate'] ?? 0,
                  between: 1.0,
                  starSize: 25.0,
                  onRaitingTap: (double a) {
                    setState(() {
                      courseReview['rate'] = a.toDouble();
                    });
                  },
                  color: Colors.grey,
                ),
                MaterialButton(
                  child: const Icon(Icons.done),
                  onPressed: () => model.leaveReview(courseReview),
                ),
              ],
            ),
          );
  }
}
