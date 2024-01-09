import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/collective_payment/collective_model.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/material_assistance/collective_page_edit.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class CollectivePaymentModel extends AbstractBpmModel<CollAgreementPaymentRequest> {
  List<CollAgreementPaymentRequest> localCache = [];

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;

    if (
        request.paymentType == null ||
        request.files == null || request.files.isEmpty) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }else{
      return true;
    }
  }

  @override
  Future<void> getRequestDefaultValue() async {
    setBusy(true);
    request = CollAgreementPaymentRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request)
    as CollAgreementPaymentRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    await getPersonGroupId();
    company = await RestServices.getCompanyByPersonGroupId();
    request.employee = await RestServices.getPersonGroupById(pgId: pgId);

    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: const CollectivePageEdit(),
        ),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    await getUserInfo();
    request = CollAgreementPaymentRequest();
    setBusy(true);
    request.id = id;
    request = await RestServices.getEntity(entity: request) as CollAgreementPaymentRequest;
    await getPersonGroupId();
    await getUserInfo();
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<CollectivePaymentModel>.value(
          value: this,
          child: const CollectivePageEdit(),
        ),
      ),
    );
  }

  @override
  Future saveFilesToEntity({File picker, List<File> multiPicker}) async {
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
  Future<void> saveRequest() async {

    final S translation = S.current;
    setBusy(true);
    final bool validate = await checkValidateRequest();
    if (!validate) {
      return;
    }
    if (request.id == null) {
      request.id = await RestServices.createAndReturnId(entityName: request.getEntityName, entity: request);
      if (request.id != null) {
        setBusy(false);
      } else {
        setBusy(false);
        GlobalNavigator.errorSnackbar(translation.error);
      }
    } else {
      await RestServices.updateEntity(entityName: request.getEntityName, entityId: request.id, entity: request);
      setBusy(false);
    }
  }

  @override
  Future<List<CollAgreementPaymentRequest>> getRequests() async =>
      await RestServices.getCollAgreementPaymentRequest();

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
