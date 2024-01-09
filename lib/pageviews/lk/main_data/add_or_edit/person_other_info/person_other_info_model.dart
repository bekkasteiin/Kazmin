import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/military/military_request_model.dart';

class PersonOtherInfoRequestModel extends AbstractBpmModel<PersonOtherInfoRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = PersonOtherInfoRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonOtherInfoRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    final DateTime _dt = DateTime.now();
    final List<BasePersonExt> personExt = await _services.getPersonExt(
      startDate: formatFullRestNotMilSec(_dt),
      endDate: formatFullRestNotMilSec(_dt),
    );
    await getPersonGroupId();
    request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
    company = await RestServices.getCompanyByPersonGroupId();
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonOtherInfoRequestModel>.value(
        value: this,
        child: PersonOtherInfoRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: PersonOtherInfoRequest(id: id)) as PersonOtherInfoRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = PersonOtherInfoRequest();
      await getPersonGroupId();
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> _personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );
      final List<PersonOtherInfoRequest> historyData = await _services.getEntityRequestList<PersonOtherInfoRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'personGroup.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => PersonOtherInfoRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        request.employee = PersonGroup(id: pgId, instanceName: _personExt?.first?.instanceName);
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonOtherInfoRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        request.entityData = await _services.getEntity<BasePersonExt>(
          entityName: BasePersonExt.entity,
          view: BasePersonExt.view,
          id: id,
          fromMap: (Map<String, dynamic> e) => BasePersonExt.fromMap(e),
        );
        request.employee = PersonGroup(id: pgId, instanceName: _personExt?.first?.instanceName);
        company = await RestServices.getCompanyByPersonGroupId();
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonOtherInfoRequestModel>.value(
        value: this,
        child: PersonOtherInfoRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<PersonOtherInfoRequest>> getRequests() async => null;

  @override
  Future<void> saveRequest() async {
    try {
      setBusy(true);
      // if (request.id == null) {
        request.id = await RestServices.createAndReturnId(
          entityName: request.getEntityName,
          entity: request,
        );
      setBusy(false);
        if (request.id == null) {
          await KzmSnackbar(message: S.current.saveRequestError).show();
        }
      // }
    } catch (e) {
      await KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<bool> checkValidateRequest() async {
    // if (request.entityData?.attitudeToMilitary == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryAttitudeToMilitary}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if ((request.entityData?.specialization == null) || (request.entityData.specialization.trim().isEmpty)) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militarySpecialization}" ${S.current.notFilled}').show();
    //   return false;
    // }
    // if (request.entityData?.militaryDocumentType == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryMilitaryDocumentType}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if ((request.entityData?.documentNumber == null) || (request.entityData.documentNumber.trim().isEmpty)) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryDocumentNumber}" ${S.current.notFilled}').show();
    //   return false;
    // }
    // if (request.entityData?.militaryType == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryMilitaryType}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData?.suitabilityToMilitary == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militarySuitabilityToMilitary}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData?.troopsStructure == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryTroopsStructure}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData?.militaryRank == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.militaryMilitaryRank}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData?.dateFrom == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.startDate}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData?.dateTo == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.endDate}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if (request.entityData.dateFrom.isAfter(request.entityData.dateTo)) {
    //   await KzmSnackbar(message: '"${S.current.startDate}" ${S.current.notCannotBeEarlier} "${S.current.endDate}"').show();
    //   return false;
    // }
    if ((request.files == null) || (request.files.isEmpty)) {
      await KzmSnackbar(message: S.current.filesNotSelected).show();
      return false;
    }

    return true;
  }

  @override
  Future<void> saveFilesToEntity({File picker, List<File> multiPicker}) async {
    setBusy(true);
    if (picker != null) {
      final FileDescriptor result = await saveAttach(picker);
      request.files.add(result);
    } else if (multiPicker != null) {
      for (int i = 0; i < multiPicker.length; i++) {
        final FileDescriptor result = await saveAttach(multiPicker[i]);
        request.files.add(result);
      }
    }
    setBusy(false);
  }

  @override
  Future<void> getReport() {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  @override
  Future<void> onRefreshList() {
    // TODO: implement onRefreshList
    throw UnimplementedError();
  }
}
