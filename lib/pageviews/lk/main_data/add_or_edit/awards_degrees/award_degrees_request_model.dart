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
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/contact/award_degrees_request_model.dart';

class AwardDegreesRequestModel extends AbstractBpmModel<AwardDegreesRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = AwardDegreesRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as AwardDegreesRequest;
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
      () => ChangeNotifierProvider<AwardDegreesRequestModel>.value(
        value: this,
        child: AwardDegreesRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    await getUserInfo();
    if (isRequestID) {
      setBusy(true);
      request = await RestServices.getEntity(entity: AwardDegreesRequest(id: id), view: 'personAwardsDegreesRequest.edit') as AwardDegreesRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
      setBusy(false);

      Get.to(
        () => ChangeNotifierProvider<AwardDegreesRequestModel>.value(
          value: this,
          child: AwardDegreesRequestFormEdit(),
        ),
      );
    }
  }

  @override
  Future<List<AwardDegreesRequest>> getRequests() async => null;

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
    if (request.entityData?.type == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.awardsDegreesType}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.kind == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.awardsDegreesKind}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.startDate == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateFrom}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData?.endDate == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateTo}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.entityData.startDate.isAfter(request.entityData.endDate)) {
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
