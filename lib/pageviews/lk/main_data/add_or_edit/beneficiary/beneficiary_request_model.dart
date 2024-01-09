import 'dart:io';

import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_beneficiary.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_form_edit.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName =
    'lib/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request_model.dart';

class BeneficiaryRequestModel extends AbstractBpmModel<BeneficiaryRequest> {
  final KzmPrivateOfficeServices _services =
      Get.find<KzmPrivateOfficeServices>();
  bool isFile = false;
  bool isEditableText = true;

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = BeneficiaryRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request)
        as BeneficiaryRequest;
    request.id = null;
    request.files = <FileDescriptor>[];

    final DateTime _dt = DateTime.now();
    final List<BasePersonExt> personExt = await _services.getPersonExt(
      startDate: formatFullRestNotMilSec(_dt),
      endDate: formatFullRestNotMilSec(_dt),
    );
    await getPersonGroupId();
    request.employee =
        PersonGroup(id: pgId, instanceName: personExt?.first?.instanceName);
    company = await RestServices.getCompanyByPersonGroupId();
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<BeneficiaryRequestModel>.value(
        value: this,
        child: BeneficiaryRequestFormEdit(),
      ),
    );
  }

  bool get isKATORequired => request?.entityData?.country?.id == kzCountryID;

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    setBusy(true);
    await getUserInfo();
    if (isRequestID) {
      request = await RestServices.getEntity(entity: BeneficiaryRequest(id: id), view: 'beneficiaryRequest-for-integration')
          as BeneficiaryRequest;
      if (userInfo == null) await getUserInfo();
      request.entityData.firstName = request.firstName;
      request.entityData.lastName = request.lastName;
      request.entityData.middleName = request.middleName;
      request.entityData.firstNameLatin = request.firstNameLatin;
      request.entityData.lastNameLatin = request.lastNameLatin;
      request.entityData.birthDate = request.birthDate;
      request.entityData.workLocation = request.workLocation;
      request.entityData = request.entityData;
      request.employee = PersonGroup(
          id: request?.employee?.id,
          instanceName: request?.employee?.instanceName);
      await getProcessInstanceData(entityId: id);
    } else {
      request = BeneficiaryRequest();
      await getPersonGroupId();
      final DateTime _dt = DateTime.now();
      final List<BasePersonExt> _personExt = await _services.getPersonExt(
        startDate: formatFullRestNotMilSec(_dt),
        endDate: formatFullRestNotMilSec(_dt),
      );
      final List<BeneficiaryRequest> historyData =
          await _services.getEntityRequestList<BeneficiaryRequest>(
        entity: request.getEntityName,
        view: request.getView,
        property: 'beneficiary.id',
        id: id,
        fromMap: (Map<String, dynamic> e) => BeneficiaryRequest.fromMap(e),
      );
      if (historyData.isNotEmpty) {
        request = historyData.first;
        request.employee = PersonGroup(
            id: pgId, instanceName: _personExt?.first?.instanceName);
        await getUserInfo();
        await getProcessInstanceData(entityId: request.id);
      } else {
        request = await RestServices.getNewBpmRequestDefault(entity: request)
            as BeneficiaryRequest;
        request.id = null;
        request.files ??= <FileDescriptor>[];
        request.entityData = await _services.getEntity<TsadvBeneficiary>(
          entityName: TsadvBeneficiary.entity,
          view: TsadvBeneficiary.view,
          id: id,
          fromMap: (Map<String, dynamic> e) => TsadvBeneficiary.fromMap(e),
        );
        company = await RestServices.getCompanyByPersonGroupId();
        request.employee = PersonGroup(
            id: pgId, instanceName: _personExt?.first?.instanceName);

        request.entityData.firstName =
            request.entityData?.personGroupChild?.person?.firstName ?? '';
        request.entityData.lastName =
            request.entityData?.personGroupChild?.person?.lastName ?? '';
        request.entityData.middleName =
            request.entityData?.personGroupChild?.person?.middleName ?? '';
        request.entityData.firstNameLatin =
            request.entityData?.personGroupChild?.person?.firstNameLatin ?? '';
        request.entityData.lastNameLatin =
            request.entityData?.personGroupChild?.person?.lastNameLatin ?? '';
        request.entityData.birthDate =
            request.entityData?.personGroupChild?.person?.dateOfBirth;
        request.firstName =
            request.entityData?.personGroupChild?.person?.firstName ?? '';
        request.lastName =
            request.entityData?.personGroupChild?.person?.lastName ?? '';
        request.middleName =
            request.entityData?.personGroupChild?.person?.middleName ?? '';
        request.firstNameLatin =
            request.entityData?.personGroupChild?.person?.firstNameLatin ?? '';
        request.lastNameLatin =
            request.entityData?.personGroupChild?.person?.lastNameLatin ?? '';
        request.birthDate =
            request.entityData?.personGroupChild?.person?.dateOfBirth;
        request.workLocation =
            request.entityData?.workLocation;
      }
    }
    setBusy(false);
    Get.to(
      () => ChangeNotifierProvider<BeneficiaryRequestModel>.value(
        value: this,
        child: BeneficiaryRequestFormEdit(update: true),
      ),
    );
  }

  @override
  Future<List<BeneficiaryRequest>> getRequests() async => null;

  @override
  Future<void> saveRequest() async {
    try {
      setBusy(true);
      request.id = await RestServices.createAndReturnId(
        entityName: request.getEntityName,
        entity: request,
      );
      setBusy(false);

    } catch (e) {
      await KzmSnackbar(message: S.current.saveRequestError).show();
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<bool> checkValidateRequest() async {
     return request.entityData.id != null
        ? checkValidateUpdateRequest()
        : checkValidateEditRequest();
  }

  Future<bool> checkValidateUpdateRequest() async {
    if (request.entityData?.relationshipType == null) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryRelationshipType}" ${S.current.notSelected}')
          .show();
      return false;
    }
    if ((request.entityData?.personGroupChild?.person?.lastName == null) ||
        (request.entityData.personGroupChild.person.lastName.trim().isEmpty)) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryLastName}" ${S.current.notFilled}')
          .show();
      return false;
    }
    if ((request.entityData?.personGroupChild?.person?.firstName == null) ||
        (request.entityData.personGroupChild.person.firstName.trim().isEmpty)) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryFirstName}" ${S.current.notFilled}')
          .show();
      return false;
    }
    if ((request.entityData?.personGroupChild?.person?.lastNameLatin == null) ||
        (request.entityData.personGroupChild.person.lastNameLatin
            .trim()
            .isEmpty)) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryLastNameLatin}" ${S.current.notFilled}')
          .show();
      return false;
    }
    if ((request.entityData?.personGroupChild?.person?.firstNameLatin ==
            null) ||
        (request.entityData.personGroupChild.person.firstNameLatin
            .trim()
            .isEmpty)) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryFirstNameLatin}" ${S.current.notFilled}')
          .show();
      return false;
    }
    if (request.entityData.personGroupChild.person.dateOfBirth == null) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryBirthDate}" ${S.current.notSelected}')
          .show();
      return false;
    }
    if ((request.files == null) || (request.files.isEmpty)) {
      await KzmSnackbar(message: S.current.filesNotSelected).show();
      return false;
    }

    return true;
  }

  Future<bool> checkValidateEditRequest() async {
    if (request.entityData?.relationshipType == null) {
      await KzmSnackbar(
              message:
                  '${S.current.field} "${S.current.beneficiaryRelationshipType}" ${S.current.notSelected}')
          .show();
      return false;
    }
    if(isEditableText){
      if ((request.entityData?.lastName == null) ||
          (request.entityData.lastName.trim().isEmpty)) {
        await KzmSnackbar(
            message:
            '${S.current.field} "${S.current.beneficiaryLastName}" ${S.current.notFilled}')
            .show();
        return false;
      }
      if ((request.entityData?.firstName == null) ||
          (request.entityData.firstName.trim().isEmpty)) {
        await KzmSnackbar(
            message:
            '${S.current.field} "${S.current.beneficiaryFirstName}" ${S.current.notFilled}')
            .show();
        return false;
      }
      if ((request.entityData?.lastNameLatin == null) ||
          (request.entityData.lastNameLatin.trim().isEmpty)) {
        await KzmSnackbar(
            message:
            '${S.current.field} "${S.current.beneficiaryLastNameLatin}" ${S.current.notFilled}')
            .show();
        return false;
      }
      if ((request.entityData?.firstNameLatin == null) ||
          (request.entityData.firstNameLatin.trim().isEmpty)) {
        await KzmSnackbar(
            message:
            '${S.current.field} "${S.current.beneficiaryFirstNameLatin}" ${S.current.notFilled}')
            .show();
        return false;
      }
      if (request.entityData.birthDate == null) {
        await KzmSnackbar(
            message:
            '${S.current.field} "${S.current.beneficiaryBirthDate}" ${S.current.notSelected}')
            .show();
        return false;
      }
    }

    if(isFile){
      if ((request.files == null) || (request.files.isEmpty)) {
        await KzmSnackbar(message: S.current.filesNotSelected).show();
        return false;
      }
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
