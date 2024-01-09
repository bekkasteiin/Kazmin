import 'package:collection/collection.dart';
import 'package:kzm/core/models/recognition/my_recognition.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/base_model.dart';

class RecognitionModel extends BaseModel {
  List<MyRecognition> myRecognition;
  Map<String, List<MyRecognition>> groupQuestion;

  Future<List<MyRecognition>> get recognition async {
    myRecognition = await RestServices.getRecognitionList();
    myRecognition.sort((a, b) => b.startDate.compareTo(a.startDate));
    groupQuestion =
        groupBy(myRecognition, (MyRecognition obj) => obj.medal.langName3);

    return myRecognition;
  }
}
