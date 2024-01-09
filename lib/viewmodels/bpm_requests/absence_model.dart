import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/base_model.dart';

class AbsenceModel extends BaseModel {
  List<AbsenceRequest> absenceList;

  Future<List<AbsenceRequest>> get absences async => absenceList ??= await RestServices.getMyAbsences();
}
