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
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class PersonalDataRequestModel extends AbstractBpmModel<PersonalDataRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {}

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    request = PersonalDataRequest();
    final DateTime dt = DateTime.now();
    final List<BasePersonExt> _tmp = await _services.getPersonExt(
      startDate: formatFullRestNotMilSec(dt),
      endDate: formatFullRestNotMilSec(dt),
    );
    final List<PersonalDataRequest> historyData = await _services.getEntityRequestList<PersonalDataRequest>(
      entity: request.getEntityName,
      view: request.getView,
      property: 'personGroup.id',
      id: await _services.personGroupId,
      fromMap: (Map<String, dynamic> e) => PersonalDataRequest.fromMap(e),
    );
    if (historyData.isNotEmpty) {
      request = historyData.first;
      request = await _services.getPersonalDataRequestByID(id: request.id);
      request.personExt = _tmp.first;
      request.profile = await _services.getPersonProfile();
      await getUserInfo();
      await getProcessInstanceData(entityId: request.id);
    } else {
      request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonalDataRequest;
      request.id = null;
      request.files ??= <FileDescriptor>[];
      request.personExt = _tmp.first;
      request.profile = await _services.getPersonProfile();
      await getPersonGroupId();
      request.employee = PersonGroup(id: pgId, instanceName: request.personExt?.instanceName);
      request.firstName = request.personExt?.firstName;
      request.firstNameLatin = request.personExt?.firstNameLatin;
      request.maritalStatus = request.personExt?.maritalStatus;
      request.lastName = request.personExt?.lastName;
      request.lastNameLatin = request.personExt?.lastNameLatin;
      request.middleName = request.personExt?.middleName;
      request.middleNameLatin = request.personExt?.middleNameLatin;
      // company = await RestServices.getCompanyByPersonGroupId();
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonalDataRequestModel>.value(
        value: this,
        child: PersonalDataRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<PersonalDataRequest>> getRequests() async => null;

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
    if ((request.lastName == null) || (request.lastName.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.lastName}" ${S.current.notFilled}').show();
      return false;
    }
    if ((request.firstName == null) || (request.firstName.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.personName}" ${S.current.notFilled}').show();
      return false;
    }
    if ((request.lastNameLatin == null) || (request.lastNameLatin.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.lastNameLatin}" ${S.current.notFilled}').show();
      return false;
    }
    if ((request.firstNameLatin == null) || (request.firstNameLatin.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.personNameLatin}" ${S.current.notFilled}').show();
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
