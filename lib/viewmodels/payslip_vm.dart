import 'package:kzm/core/models/person_payslip.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/base_model.dart';

class PayslipVM extends BaseModel {
  List<PersonPayslip> list;


  Future<List<PersonPayslip>> getPayslips({bool update = false}) async {
    list = await RestServices.getPayslip();
    setBusy(false);
    return list ?? [];
  }
}
