import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/models/documents_familitarization.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/base_model.dart';

class AdaptationViewModel extends BaseModel {
  List<AdaptationPlan> plans = [];
  AdaptationPlan currentAdaptation;
  List<GetDocumentListResponse> getDocumentList;
  List<DocumentsFamiliarization> introductoryDocumentsList;
  Future<AdaptationPlan> get getCurrentAdaptationPlan async {
    plans.clear();
    plans.addAll(await RestServices.getAdaptationPlans());

    currentAdaptation ??= plans.last;
    rebuild();
    return currentAdaptation;
  }

  Future<List<AdaptationTask>> get getTasks async =>
      RestServices.getMyAdaptationTask(currentAdaptation.id);

  Future<List<PersonGroup>> get getMyAdaptationTeam =>
      RestServices.getMyAdaptationTeam();

  Future<List<GetDocumentListResponse>> getCompulsoryDocuments() async {
    // ignore: join_return_with_assignment
    getDocumentList  = await RestServices.getDocumentListResponse();
    introductoryDocumentsList = await RestServices.getIntroductoryDocuments();
    for (final DocumentsFamiliarization element in introductoryDocumentsList) {
      final GetDocumentListResponse el = getDocumentList.firstWhere((GetDocumentListResponse e) => e.documentFamiliarization.id == element.id, orElse: ()=>null);
      if(el != null) {
        element.acknowledgement = true;
      }
    }
    // getDocumentList.forEach((element) {
    //   final el = introductoryDocumentsList.firstWhere((e) => e.id == element.documentFamiliarization.id, orElse: ()=> null);
    //   if(el != null) {
    //
    //   }
    // });
    return getDocumentList;
  }

  Future<List<Course>> get getAdaptationCourses =>
      RestServices.getAdaptationCourses(currentAdaptation.id);

  Future<void> addToKnown(DocumentsFamiliarization e) async {
    setBusy(true);
    final UserInfo userInfo = await HiveUtils.getUserInfo();
    try{
      await RestServices.createAndReturnId(
        entityName: 'tsadv_ListOfAcknowledgement',
        entityMap: {
          'documentFamiliarization': {
            '_entityName': 'tsadv_DocumentsFamiliarization',
            'id': e.id,
          },
          'user': {
            '_entityName': 'tsadv\$UserExt',
            'id': userInfo.id,
          },
          'acknowledgement': true,
        },
      );
      // (await HiveService.getBox('documentsFamiliarization') as Box).put(id, id);
      // await RestServices.checkDocFamilization();
      await getCompulsoryDocuments();
      setBusy(false);
      GlobalNavigator.pop();
    }catch(e){
      print(e);
    }
  }
}
