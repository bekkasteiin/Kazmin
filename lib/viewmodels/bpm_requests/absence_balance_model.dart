import 'dart:io';
import 'package:kzm/core/models/absence/absence_balance.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';

class AbsenceBalanceModel extends AbstractBpmModel<AbsenceVacationBalance> {
  double myBalance = 0.0;


  @override
  Future<bool> checkValidateRequest() async {
    return true;
  }

  @override
  Future<void> getRequestDefaultValue() async {}

  @override
  Future<List<AbsenceVacationBalance>> getRequests() async {
    doubleBalanceDays;
    requestList = await RestServices.getAbsenceVacationBalance();
    requestList.sort((a, b)=>b.dateTo.compareTo(a.dateTo));
   return requestList;
  }

  Future<double> get doubleBalanceDays async {
    final dynamic rest = await RestServices.getVacationBalanceDays(
          absenceDate: DateTime.now(),
        );
        return myBalance = double.parse(double.parse((rest as String).replaceAll(RegExp('W+'), '')).toStringAsFixed(2));
  }




  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {}

  @override
  Future saveRequest() async {}

  @override
  Future saveFilesToEntity({File picker, List<File> multiPicker}) {
    // TODO: implement saveFilesToEntity
    throw UnimplementedError();
  }

  @override
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  Future<void> openRequest() async {}

  @override
  Future<void> onRefreshList() {
    // TODO: implement onRefreshList
    throw UnimplementedError();
  }
}
