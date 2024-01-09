import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_disability.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/disability/disability_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/disability/disability_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/disability/disability_request_model.dart';

class DisabilityRequestModel extends AbstractBpmModel<DisabilityRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = DisabilityRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as DisabilityRequest;
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
      () => ChangeNotifierProvider<DisabilityRequestModel>.value(
        value: this,
        child: DisabilityRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: DisabilityRequest(id: id)) as DisabilityRequest;
      if (userInfo == null) await getUserInfo();

      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> _personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );
      request.employee = PersonGroup(id: pgId, instanceName: _personExt?.first?.instanceName);

      await getProcessInstanceData(entityId: id);
    } else {
      request = DisabilityRequest();
      await getPersonGroupId();
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> _personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );
      final List<DisabilityRequest> historyData = await _services.getEntityRequestList<DisabilityRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'disability.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => DisabilityRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        request.employee = PersonGroup(id: pgId, instanceName: _personExt?.first?.instanceName);
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request) as DisabilityRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        request.entityData = await _services.getEntity<TsadvDisability>(
          entityName: TsadvDisability.entity,
          view: TsadvDisability.view,
          id: id,
          fromMap: (Map<String, dynamic> e) => TsadvDisability.fromMap(e),
        );
        request.employee = PersonGroup(id: pgId, instanceName: _personExt?.first?.instanceName);
        company = await RestServices.getCompanyByPersonGroupId();
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<DisabilityRequestModel>.value(
        value: this,
        child: DisabilityRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<DisabilityRequest>> getRequests() async => null;

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
    if ((request.entityData?.hasDisability == null) || (!request.entityData.hasDisability)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.disabilityHasDisability}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.disabilityType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.disabilityDisabilityType}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.dateFrom == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateFrom}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.dateTo == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateTo}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData.dateFrom.isAfter(request.entityData.dateTo)) {
      await KzmSnackbar(message: '"${S.current.dateFrom}" ${S.current.notCannotBeEarlier} "${S.current.dateTo}"').show();
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
