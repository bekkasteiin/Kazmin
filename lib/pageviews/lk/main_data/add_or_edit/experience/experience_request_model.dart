import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_person_experience.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/experience/experience_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/experience/experience_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/experience/experience_request_model.dart';

class ExperienceRequestModel extends AbstractBpmModel<ExperienceRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = ExperienceRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as ExperienceRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    final DateTime _dt = DateTime.now();
    final List<BasePersonExt> personExt = await _services.getPersonExt(
      startDate: formatFullRestNotMilSec(_dt),
      endDate: formatFullRestNotMilSec(_dt),
    );
    await getPersonGroupId();
    request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
    request.personProfile = await RestServices.getPersonProfileByPersonGroupId(pgId: pgId);
    company = await RestServices.getCompanyByPersonGroupId();
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<ExperienceRequestModel>.value(
        value: this,
        child: ExperienceRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: ExperienceRequest(id: id), view: 'personExperienceRequest-Edit') as ExperienceRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      request.personProfile = await RestServices.getPersonProfileByPersonGroupId(pgId: request?.employee?.id);
      await getProcessInstanceData(entityId: id);
    } else {
      request = ExperienceRequest();
      await getPersonGroupId();
      request = await RestServices.getNewBpmRequestDefault(entity: request) as ExperienceRequest;
      request.id = null;
      request.files ??= <FileDescriptor>[];
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );

      final TsadvPersonExperience experience = await _services.getEntity<TsadvPersonExperience>(
        entityName: 'tsadv\$PersonExperience',
        id: id,
        fromMap: (Map<String, dynamic> e) => TsadvPersonExperience.fromMap(e),
        view: request.getView,
      );

      request.company = experience.company;
      request.location = experience.location;
      request.endMonth = experience.endMonth;
      request.startMonth = experience.startMonth;
      request.job = experience.job;
      request.personExperience = id;

      request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
      request.personProfile = await RestServices.getPersonProfileByPersonGroupId(pgId: pgId);
      company = await RestServices.getCompanyByPersonGroupId();
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<ExperienceRequestModel>.value(
        value: this,
        child: ExperienceRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<ExperienceRequest>> getRequests() async => null;

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
    if ((request.company == null) || (request.company.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.experienceCompany}" ${S.current.notFilled}').show();
      return false;
    }
    if ((request.job == null) || (request.job.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.experienceJob}" ${S.current.notFilled}').show();
      return false;
    }
    if (request.startMonth == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.experienceStartDate}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.startMonth.isAfter(request.personProfile.hireDate) || (request.startMonth == request.personProfile.hireDate)) {
      await KzmSnackbar(message: '${S.current.experienceStartAfterHireDate} (${formatFullNotMilSec(request.personProfile.hireDate)})').show();
      return false;
    }
    if (request.endMonth == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.experienceEndDate}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.endMonth.isAfter(request.personProfile.hireDate) || (request.endMonth == request.personProfile.hireDate)) {
      await KzmSnackbar(message: '${S.current.experienceEndAfterHireDate} (${formatFullNotMilSec(request.personProfile.hireDate)})').show();
      return false;
    }
    if (request.startMonth.isAfter(request.endMonth)) {
      await KzmSnackbar(message: S.current.experienceStartAfterEndDate).show();
      return false;
    }
    if ((request.location == null) || (request.location.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.experienceLocation}" ${S.current.notFilled}').show();
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
