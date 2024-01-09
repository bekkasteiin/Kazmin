import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_address.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/address/address_request_model.dart';

class AddressRequestModel extends AbstractBpmModel<AddressRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  bool get isKATORequired => request?.country?.id == kzCountryID;

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    // historyExists = false;
    request = AddressRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as AddressRequest;
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
      () => ChangeNotifierProvider<AddressRequestModel>.value(
        value: this,
        child: AddressRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: AddressRequest(id: id)) as AddressRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = AddressRequest();
      await getPersonGroupId();
      final List<AddressRequest> historyData = await _services.getEntityRequestList<AddressRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'baseAddress.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => AddressRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request) as AddressRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        final DateTime _dt = DateTime.now();
        final List<BasePersonExt> personExt = await _services.getPersonExt(
          startDate: formatFullRestNotMilSec(_dt),
          endDate: formatFullRestNotMilSec(_dt),
        );
        final TsadvAddress address = await _services.getEntity<TsadvAddress>(
          entityName: 'tsadv\$Address',
          id: id,
          fromMap: (Map<String, dynamic> e) => TsadvAddress.fromMap(e),
        );
        request.baseAddress = TsadvAddress.fromJson(address?.toJson());
        request.addressType = address?.addressType;
        request.postalCode = address?.postalCode;
        request.country = address?.country;
        request.kato = address?.kato;
        request.streetType = address?.streetType;
        request.streetName = address?.streetName;
        request.building = address?.building;
        request.block = address?.block;
        request.flat = address?.flat;
        request.addressForExpats = address?.addressForExpats;
        request.addressKazakh = address?.addressKazakh;
        request.addressEnglish = address?.addressEnglish;
        request.comment = address?.comment;

        request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
        company = await RestServices.getCompanyByPersonGroupId();
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<AddressRequestModel>.value(
        value: this,
        child: AddressRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<AddressRequest>> getRequests() async => null;

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
          KzmSnackbar(message: S.current.saveRequestError).show();
        }
      // }
    } catch (e) {
      KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<bool> checkValidateRequest() async {
    if (request.startDate == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateFrom}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.endDate == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.dateTo}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.startDate.isAfter(request.endDate)) {
      await KzmSnackbar(message: '"${S.current.dateFrom}" ${S.current.notCannotBeEarlier} "${S.current.dateTo}"').show();
      return false;
    }
    if (request.addressType == null) {
      KzmSnackbar(message: '${S.current.field} "${S.current.addressType}" ${S.current.notSelected}').show();
      return false;
    }
    if (request.country == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.addressCountry}" ${S.current.notSelected}').show();
      return false;
    }
    if (isKATORequired) {
      if (request.kato == null) {
        await KzmSnackbar(message: '${S.current.field} "${S.current.addressKATOCode}" ${S.current.notSelected}').show();
        return false;
      }
    }
    if (request.streetType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.addressStreetType}" ${S.current.notSelected}').show();
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
