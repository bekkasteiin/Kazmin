import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/certificate/certificate.dart';
import 'package:kzm/core/models/person/person_profile.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/certificate/certificate_form_edit.dart';
import 'package:kzm/pageviews/certificate/certificate_info.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/viewmodels/bpm_requests/certificate_model.dart';

class CertificateModel extends AbstractBpmModel<CertificateRequest> {
  bool isVcmCompany = false;
  List<AbstractDictionary> languages;
  List<AbstractDictionary> certificateTypes;
  List<AbstractDictionary> receivingTypes;
  AbstractDictionary onHandReceivingType;
  PersonProfile personProfile;

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;

    if (request.requestNumber == null ||
        request.status == null ||
        request.requestDate == null ||
        request.certificateType == null ||
        request.receivingType == null ||
        request.language == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }

    if (request.receivingType?.code == 'ON_HAND') {
      if (request.numberOfCopy == null) {
        setBusy(false);
        GlobalNavigator().errorBar(title: translation.fillRequiredFields);
        return false;
      }
    }

    return true;
  }

  @override
  Future<void> getRequestDefaultValue() async {
    request = await RestServices.getNewCertificateRequest(
        entityName: EntityNames.certificateRequest);
    request.id = null;
    await getPersonGroupId();
    final PersonGroup personGroup = PersonGroup();
    personGroup.id = pgId;
    request.personGroup = personGroup;
    await getPersonCompany();
    await myLanguages;
    await myCertificateTypes;
    await myReceivingTypes;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: CertificateFormView(),
        ),
      ),
    );
  }

  @override
  Future<List<CertificateRequest>> getRequests() async {
    requestList = await RestServices.getMyCertificates();
    return requestList;
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    await getUserInfo();
    request = CertificateRequest();
    setBusy(true);
    request.id = id;
    request = await RestServices.getEntity(entity: request) as CertificateRequest;
    await myLanguages;
    await myCertificateTypes;
    await myReceivingTypes;
    if (userInfo == null) {
      await getUserInfo();
    }
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<CertificateModel>.value(
          value: this,
          child: CertificateInfoPage(),
        ),
      ),
    );
  }

  Future get myLanguages async {
    languages ??= await RestServices.getLanguages();
    return languages;
  }

  Future get myCertificateTypes async {
    certificateTypes ??= await RestServices.getCertificateType();
    return certificateTypes;
  }

  Future get myReceivingTypes async {
    receivingTypes ??= await RestServices.getReceivingType();
    return receivingTypes;
  }

  Future getPersonCompany() async {
    company = await RestServices.getCompanyByPersonGroupId();
    if (company?.code == 'VCM') {
      await ifCompanyIsVcm();
    }
  }

  Future ifCompanyIsVcm() async {
    isVcmCompany = true;
    onHandReceivingType = await RestServices.getSingleDictionaryByCode(
      entityName: 'tsadv_DicReceivingType',
      code: 'ON_HAND',
    );
    request?.receivingType = onHandReceivingType;
  }

  Future getReceivingType() async {
    receivingTypes = await RestServices.getReceivingType();
    return receivingTypes;
  }

  @override
  Future saveRequest() async {
    // DateTime t1 = DateTime.now();
    // log('-->> $fName, saveRequest ->> $t1 start');
    setBusy(true);
    final S translation = S.current;

    if (request.id == null) {
      request.id = await RestServices.createAndReturnId(
          entityName: EntityNames.certificateRequest, entity: request);
      if (request.id != null) {
        setBusy(false);
      } else {
        setBusy(false);
        GlobalNavigator().errorBar(title: 'При сохранение заявки ошибка');
      }
    } else {
      setBusy(false);
    }
    // t1 = DateTime.now();
    // log('-->> $fName, saveRequest ->> $t1 end');
  }

  @override
  Future saveFilesToEntity({File picker, List<File> multiPicker}) {
    // TODO: implement saveFileToEntity
    throw UnimplementedError();
  }

  Future<void> saveForScanVersion() async {
    final bool validate = await checkValidateRequest();
    if (!validate) {
      return;
    } else {
      // kzmLog(fName: fName, func: 'saveForScanVersion', text: 'start');
      await saveRequest();
      GlobalNavigator.pop();
      GlobalNavigator.successSnackbar();
    }
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
