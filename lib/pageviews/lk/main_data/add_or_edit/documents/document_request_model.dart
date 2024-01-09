import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_person_document.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/person/person_document.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/add_or_edit/documents/document_request_model.dart';

class PersonDocumentRequestModel extends AbstractBpmModel<PersonDocumentRequest> {
  final KzmPrivateOfficeServices _services = Get.find<KzmPrivateOfficeServices>();

  List<String> companies;
  bool isIssuingAuthorityRequired = true;

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = PersonDocumentRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonDocumentRequest;
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
    companies = await RestServices().getCompaniesByPersonGroupId();
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonDocumentRequestModel>.value(
        value: this,
        child: PersonDocumentRequestFormEdit(),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: PersonDocumentRequest(id: id)) as PersonDocumentRequest;
      if (userInfo == null) await getUserInfo();
      request.employee = PersonGroup(id: request?.employee?.id, instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = PersonDocumentRequest();
      final List<PersonDocumentRequest> historyData = await _services.getEntityRequestList<PersonDocumentRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'editedPersonDocument.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => PersonDocumentRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        // request = await RestServices.getEntity(entity: request) as PersonDocumentRequest;
        await getPersonGroupId();
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
        setBusy(false);
        Get.to(
          () => ChangeNotifierProvider<PersonDocumentRequestModel>.value(
            value: this,
            child: PersonDocumentRequestFormEdit(),
          ),
        );
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request) as PersonDocumentRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        final Box<dynamic> a = await HiveUtils.getSettingsBox();
        final String pgId = a.get('pgId').toString();
        final DateTime _dt = DateTime.now();
        final List<BasePersonExt> personExt = await _services.getPersonExt(
          startDate: formatFullRestNotMilSec(_dt),
          endDate: formatFullRestNotMilSec(_dt),
        );
        request.employee = PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
        final TsadvPersonDocument personDocument = await _services.getEntity<TsadvPersonDocument>(
          entityName: 'tsadv\$PersonDocument',
          id: id,
          fromMap: (Map<String, dynamic> e) => TsadvPersonDocument.fromMap(e),
        );
        request.documentType = DicAbsenceType.fromJson(personDocument?.documentType?.toJson());
        request.issuingAuthority = DicAbsenceType.fromJson(personDocument?.issuingAuthority?.toJson());
        request.issuedBy = personDocument?.issuedBy;
        request.issueDate = DateTime.parse(personDocument?.issueDate);
        request.expiredDate = DateTime.parse(personDocument?.expiredDate);
        request.documentNumber = personDocument.documentNumber;
        request.editedPersonDocument = PersonDocument(id: personDocument?.id);
        company = await RestServices.getCompanyByPersonGroupId();
        companies = await RestServices().getCompaniesByPersonGroupId();
        isIssuingAuthorityRequired = !(request?.documentType?.foreigner ?? false);
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<PersonDocumentRequestModel>.value(
        value: this,
        child: PersonDocumentRequestFormEdit(),
      ),
    );
  }

  @override
  Future<List<PersonDocumentRequest>> getRequests() async => null;

  @override
  Future<void> saveRequest() async {
    try {
      setBusy(true);
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
        entity: request,
      );
      if (request.id == null) {
        KzmSnackbar(message: S.current.saveRequestError).show();
      }
    } catch (e) {
      KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<bool> checkValidateRequest() async {
    if (request.documentType == null) {
      await KzmSnackbar(message: S.current.documentTypeNotSelected).show();
      setBusy(false);
      return false;
    }
    if (isIssuingAuthorityRequired) {
      if (request.issuingAuthority == null) {
        await KzmSnackbar(message: S.current.issuingAuthorityNotSelected).show();
        setBusy(false);
        return false;
      }
    }
    if (request.issueDate == null) {
      await KzmSnackbar(message: S.current.validFromDateNotSelected).show();
      setBusy(false);
      return false;
    }
    if (request.expiredDate == null) {
      await KzmSnackbar(message: S.current.validToDateNotSelected).show();
      setBusy(false);
      return false;
    }
    if (request.issueDate.isAfter(request.expiredDate)) {
      await KzmSnackbar(message: S.current.issueDateAfterExpiredDate).show();
      setBusy(false);
      return false;
    }
    if ((request.documentNumber == null) || (request.documentNumber.trim().isEmpty)) {
      await KzmSnackbar(message: S.current.documentNumberNotSelected).show();
      setBusy(false);
      return false;
    }
    if ((request.files == null) || (request.files.isEmpty)) {
      await KzmSnackbar(message: S.current.filesNotSelected).show();
      setBusy(false);
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
