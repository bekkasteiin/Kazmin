import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/learning/course/enrollment/course_enrollment.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CourseContinueEnrollButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    return FutureBuilder(
      future: model.isUserEnrolled(),
      builder: (BuildContext fContext, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const SizedBox();
        }
        if (snapshot.data is bool && snapshot.data) {
          return KzmButton(
            margin: const EdgeInsets.all(5),
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: const Text('Продолжить обучение', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            onPressed: (){
              Get.to(
                ChangeNotifierProvider.value(
                  value: model,
                  child: CourseEnrollment(),
                ),
                preventDuplicates: false,
              );
            },
          );
        }
        if (snapshot.data is String && snapshot.data == 'REQUEST') {
          return const CupertinoButton(
            onPressed: null,
            child: Text('Заявка подана'),
          );
        }
        return model.selectedCourse.selfEnrollment
            ? CupertinoButton(
                child: const Text('Записаться'),
                onPressed: () => model.enrollToCourse(),
              )
            : const SizedBox();
      },
    );
  }
}
