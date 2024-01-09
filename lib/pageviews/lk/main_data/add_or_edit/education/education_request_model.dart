import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_person_education.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/address/education_request_model.dart';

class EducationRequestModel extends AbstractBpmModel<EducationRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = EducationRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as EducationRequest;
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
      () => ChangeNotifierProvider<EducationRequestModel>.value(
        value: this,
        child: EducationRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: EducationRequest(id: id), view: 'portal.my-profile') as EducationRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = EducationRequest();
      await getPersonGroupId();
      request = await RestServices.getNewBpmRequestDefault(entity: request) as EducationRequest;
      request.id = null;
      request.files ??= <FileDescriptor>[];
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );
      final TsadvPersonEducation education = await _services.getEntity<TsadvPersonEducation>(
        entityName: 'tsadv\$PersonEducation',
        id: id,
        fromMap: (Map<String, dynamic> e) => TsadvPersonEducation.fromMap(e),
      );
      request.school = education.school;
      request.educationType = education.educationType;
      request.specialization = education.specialization;
      request.diplomaNumber = education.diplomaNumber;
      request.faculty = education.faculty;
      request.startYear = education.startYear;
      request.endYear = education.endYear;
      request.qualification = education.qualification;
      request.formStudy = education.formStudy;

      request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
      company = await RestServices.getCompanyByPersonGroupId();
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<EducationRequestModel>.value(
        value: this,
        child: EducationRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<EducationRequest>> getRequests() async => null;

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
    if (request.educationType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.educationType}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.specialization == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.educationSpecialization}" ${S.current.notFilled}').show();
      return false;
    }
    if (request.startYear == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.educationStartYear}" ${S.current.notFilled}').show();
      return false;
    }
    if (request.formStudy == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.educationFormStudy}" ${S.current.notSelected}').show();
      return false;
    }
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
