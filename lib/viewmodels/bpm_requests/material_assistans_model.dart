import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/sur_change_request.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/material_assistance/create_material_request.dart';
import 'package:kzm/pageviews/material_assistance/view_material_request.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:provider/provider.dart';

class MaterialAssistantViewModel extends AbstractBpmModel<SurChargeRequest> {
  List<SurChargeRequest> localCache = [];

  @override
  Future<bool> checkValidateRequest() async {
    final S translation = S.current;
    if (
    request.aidType == null ||
        request.requestNumber == null || request.justification==null
    || request.employee == null
    || request.files == null || request.files.isEmpty
    ) {
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
    request = SurChargeRequest();
    request = await RestServices.getNewBpmRequestDefault(entity: request)
        as SurChargeRequest;
    request.id = null;
    request.files ??= <FileDescriptor>[];
    await getPersonGroupId();
    company = await RestServices.getCompanyByPersonGroupId();
    request.employee = await RestServices.getPersonGroupById(pgId: pgId);
    // request.employeeName = Person(id: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: this,
          child: const CreateMaterialRequest(),
        ),
      ),
    );
  }

  @override
  Future<void> openRequestById(String id, {bool isRequestID = false}) async {
    await getUserInfo();
    request = SurChargeRequest();
    setBusy(true);
    request.id = id;
    request = await RestServices.getEntity(entity: request) as SurChargeRequest;
    await getPersonGroupId();
    await getUserInfo();
    await getProcessInstanceData(entityId: id);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<MaterialAssistantViewModel>.value(
          value: this,
          child: const ViewMaterialRequest(),
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
    setBusy(true);
    final S translation = S.current;
    setBusy(true);
    final bool validate = await checkValidateRequest();
    if (!validate) {
      return;
    }
    if (request.id == null) {
      request.id = await RestServices.createAndReturnId(entityName: request.getEntityName, entity: request);
      if (request.id != null) {
        GlobalNavigator.pop();
        setBusy(false);
      } else {
        setBusy(false);
        GlobalNavigator.pop();
        GlobalNavigator.errorSnackbar(translation.error);
      }
    } else {
      await RestServices.updateEntity(entityName: request.getEntityName, entityId: request.id, entity: request);
      GlobalNavigator.pop();
      setBusy(false);
    }
  }

  @override
  Future<List<SurChargeRequest>> getRequests() async =>
      await RestServices.getMySurChangeRequestHistory();

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
