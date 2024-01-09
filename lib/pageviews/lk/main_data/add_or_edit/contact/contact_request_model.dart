import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_person_contact.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/contact/contact_request_model.dart';

class PersonContactRequestModel extends AbstractBpmModel<PersonContactRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = PersonContactRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonContactRequest;
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
    request.startDate = DateTime.now();
    request.endDate = DateTime(9999,12,31);
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonContactRequestModel>.value(
        value: this,
        child: PersonContactRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: PersonContactRequest(id: id), view: 'personContactRequest-for-integration') as PersonContactRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = PersonContactRequest();
      request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonContactRequest;
      request.id = null;
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );

      final TsadvPersonContact personContact = await _services.getEntity<TsadvPersonContact>(
        entityName: 'tsadv\$PersonContact',
        id: id,
        fromMap: (Map<String, dynamic> e) => TsadvPersonContact.fromMap(e),
      );
      request.personContact = personContact;
      request.contactValue = personContact.contactValue;
      request.startDate = personContact.startDate;
      request.endDate = personContact.endDate;
      request.phoneType = personContact.type;

      await getPersonGroupId();
      request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
      company = await RestServices.getCompanyByPersonGroupId();
    }
    setBusy(false);

    Get.to(
      () => ChangeNotifierProvider<PersonContactRequestModel>.value(
        value: this,
        child: PersonContactRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<PersonContactRequest>> getRequests() async => null;

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
    if ((request.startDate == null) || (request.startDate.year == 9999 && request.startDate.month == 12 && request.startDate.day == 31)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.personContactStartDate}" ${S.current.notSelected}').show();
      return false;
    }
    // if ((request.endDate == null) || (request.endDate.year == 9999 && request.endDate.month == 12 && request.endDate.day == 31)) {
    //   await KzmSnackbar(message: '${S.current.field} "${S.current.personContactEndDate}" ${S.current.notSelected}').show();
    //   return false;
    // }
    if (request.phoneType == null) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.personContactPhoneType}" ${S.current.notFilled}').show();
      return false;
    }
    if ((request.contactValue == null) || (request.contactValue.trim().isEmpty)) {
      await KzmSnackbar(message: '${S.current.field} "${S.current.personContactContactValue}" ${S.current.notFilled}').show();
      return false;
    }
    if (request.startDate.isAfter(request.endDate)) {
      await KzmSnackbar(message: S.current.personContactStartAfterEndDate).show();
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
