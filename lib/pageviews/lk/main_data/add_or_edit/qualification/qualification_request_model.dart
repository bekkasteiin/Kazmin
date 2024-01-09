import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_person_qualification.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class QualificationRequestModel extends AbstractBpmModel<QualificationRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = QualificationRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as QualificationRequest;
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
      () => ChangeNotifierProvider<QualificationRequestModel>.value(
        value: this,
        child: QualificationRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: QualificationRequest(id: id)) as QualificationRequest;
      // log('-->> $fName, openRequestById -->> getEntity: ${request.toJson()}');
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = QualificationRequest();
      await getPersonGroupId();
      final List<QualificationRequest> historyData = await _services.getEntityRequestList<QualificationRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'personQualification.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => QualificationRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request) as QualificationRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        final DateTime _dt = DateTime.now();
        final List<BasePersonExt> personExt = await _services.getPersonExt(
          startDate: formatFullRestNotMilSec(_dt),
          endDate: formatFullRestNotMilSec(_dt),
        );
        final TsadvPersonQualification qualification = await _services.getEntity<TsadvPersonQualification>(
          entityName: 'tsadv\$PersonQualification',
          view: 'personQualification-view',
          id: id,
          fromMap: (Map<String, dynamic> e) => TsadvPersonQualification.fromMap(e),
        );
        request.courseName = qualification.courseName;
        request.diploma = qualification.diploma;
        request.educationDocumentType = qualification.educationDocumentType;
        request.educationalInstitutionName = qualification.educationalInstitutionName;
        request.endDate = qualification.endDate;
        request.expiryDate = qualification.expiryDate;
        request.issuedDate = qualification.issuedDate;
        request.profession = qualification.profession;
        request.qualification = qualification.qualification;
        request.startDate = qualification.startDate;

        request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
        company = await RestServices.getCompanyByPersonGroupId();
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<QualificationRequestModel>.value(
        value: this,
        child: QualificationRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<QualificationRequest>> getRequests() async => null;

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
        // }
      }
    } catch (e) {
      await KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<bool> checkValidateRequest() async {
    // if ((request.educationalInstitutionName == null) || (request.educationalInstitutionName.trim().isEmpty)) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.qualificationEducationalInstitutionName}" ${S.current.notFilled}').show();
    //   return false;
    // }
    // if (request.startDate == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.personContactStartDate}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if ((request.endDate != null) && request.startDate.isAfter(request.endDate)) {
    //   await KzmSnackbar(message: S.current.experienceStartAfterEndDate).show();
    //   return false;
    // }
    // if ((request.qualification == null) || (request.qualification.trim().isEmpty)) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.qualificationQualification}" ${S.current.notFilled}').show();
    //   return false;
    // }
    if (request.educationDocumentType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.educationDocumentType}" ${S.current.notSelected}').show();
      return false;
    }
    // if (request.expiryDate == null) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.educationExpiryDate}" ${S.current.notSelected}').show();
    //   return false;
    // }
    // if ((request.files == null) || (request.files.isEmpty)) {
    //   await KzmSnackbar(message: S.current.filesNotSelected).show();
    //   return false;
    // }

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
