import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/absence/validate_model.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dms/contract_assistance.dart';
import 'package:kzm/core/models/dms/insurance_contract.dart';
import 'package:kzm/core/models/dms/insured_person.dart';
import 'package:kzm/core/models/person/address.dart';
import 'package:kzm/core/models/person/person_document.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/base_model.dart';

class InsuredPersonModel extends BaseModel {
  List<InsuredPerson> dmsList;
  List<InsuranceContract> contracts;
  List<dynamic> enableContract;
  List<Address> addresses;
  List<PersonDocument> personDocuments;
  List<InsuredPerson> memberList;
  List<AbstractDictionary> region;
  List<AbstractDictionary> docType;
  List<AbstractDictionary> relative;
  List<AbstractDictionary> addressType;
  List<AbstractDictionary> memberSex;
  List<ContractAssistance> assistanceContract;
  List<ContractAssistance> assistanceList;
  InsuredPerson insuredPerson;
  InsuredPerson getInsuredPerson;
  InsuredPerson getTsadvInsuredPerson;
  Assistance getContractAssistance;
  InsuredPerson member;

  AbstractDictionary company;
  bool isEmployee;
  String employeeType;
  DateTime assignDate;
  bool successSaved = false;
  bool successSavedMember = false;
  File pickerFile;
  List<File> pickerFiles;

  Future<List<InsuredPerson>> get dms async =>
      dmsList = await RestServices.getMyDMS();
  // return dmsList;

  Future<List<AbstractDictionary>> getRegions() async {
    region = await RestServices.getRegion();
    return region;
  }

  Future<List<ContractAssistance>> getAssistanceContract(String id) async {
    assistanceContract = await RestServices.getAssistanceContract(id);
    return assistanceContract;
  }

  Future<List<AbstractDictionary>> getAddressType() async {
    addressType = await RestServices.getAddressType();
    return addressType;
  }

  Future<List<AbstractDictionary>> getMemberSex() async {
    memberSex = await RestServices.getMemberSex();
    return memberSex;
  }

  Future<List<AbstractDictionary>> getDocType() async {
    docType = await RestServices.getDocType(company.id);
    return docType;
  }

  Future<List<AbstractDictionary>> getRelative() async {
    var relatives = await RestServices.getRelative(company.code);
    relative = relatives.isNotEmpty ? relatives
        : await RestServices.getRelativeList();
    return relative;
  }

  Future<List<InsuredPerson>> get members async =>
      memberList = await RestServices.getMembers(
          insuranceContractId: insuredPerson.insuranceContract.id,
          personId: insuredPerson.id) as List<InsuredPerson>;

  Future<List<InsuranceContract>> get myContracts async {
    // getRegions();
    // getDocType();
    // getRelative();
    // getMemberSex();
    // getAddressType();
    contracts = await RestServices.getMyContracts(companyId: company.id)
        as List<InsuranceContract>;
    return contracts;
  }

  Future get getEnableContract async {
    final Box a = await HiveUtils.getSettingsBox();
    final String id = a.get('pgId') as String;
    final List<ValidateModel> validate =
        await RestServices.dmsValidation(personGroupId: id);
    var jsonString = jsonDecode(validate[0].value);
    enableContract = jsonString as List<dynamic>;
    return enableContract;
  }

  Future<AbstractDictionary> get myCompany async {
    company ??= await RestServices.getCompanyByPersonGroupId();
    return company;
  }

  Future<InsuredPerson> myInsuredPerson(String id) async {
    getInsuredPerson = await RestServices.getMyInsuredPerson(id);
    return getInsuredPerson;
  }

  Future<InsuredPerson> myTsadvInsuredPerson(String id) async {
    getTsadvInsuredPerson = await RestServices.getInsuredTsadvPerson(id);
    return getTsadvInsuredPerson;
  }

  Future<Assistance> getMyAssistance(String id) async {
    List<Assistance> list = await RestServices.getAssistanceById(id);
    if (list.isNotEmpty) {
      getContractAssistance = list.first;
    }
    return getContractAssistance;
  }

  Future<List<ContractAssistance>> getListAssistance(String id) async {
    assistanceList = await RestServices.getContractAssistanceById(id);
    return assistanceList;
  }

  Future<List<PersonDocument>> get myDocuments async {
    // personDocuments ??= await RestServices.getMyDocuments();
    return personDocuments;
  }

  Future<bool> getInsuredPersonDefaultValue(String id) async {
    setBusy(true);
    insuredPerson = await RestServices.getInsuredPerson(
        type: 'Employee', insuranceContractId: id);
    if (insuredPerson.company == null) {
      setBusy(false);
      GlobalNavigator.errorSnackbar('Данный сотрудник уже привязан к договору');
      return false;
    } else {
      await myContracts;
      insuredPerson.id = null;
      assignDate = insuredPerson.employee.list[0].startDate;
      personDocuments = insuredPerson.employee.personDocuments;
      addresses = insuredPerson.employee.addresses;
      if (addresses != null && addresses.isNotEmpty) {
        insuredPerson.addressType = addresses.first.addressType;
        insuredPerson.address = addresses.first.address;
      }
      setBusy(false);
      return true;
    }
  }

  Future<bool> delete({@required String entityId, bool isFile = false}) async {
    final String entityName =
        isFile ? 'sys\$FileDescriptor' : 'kzm_InsuredPersonKzm';
    //'tsadv\$InsuredPerson';

    setBusy(true);
    final bool result = await RestServices.deleteEntity(
        entityName: entityName, entityId: entityId);
    setBusy(false);
    if (result) {
      GlobalNavigator.doneSnackbar(S.current.deleteMembers);
    }
    return result;
  }

  Future<void> getMemberDefaultValue() async {
    member = await RestServices.getInsuredPerson(
        type: 'Member',
        insuranceContractId: insuredPerson.insuranceContract.id);
    member.id = null;
    member.insuranceContract = insuredPerson.insuranceContract;
    member.file = <FileDescriptor>[];
  }

  Future<void> saveInsuredPerson() async {
    final S translation = S.current;

    if (!checkRequiredFields(insuredPerson)) return;
    setBusy(true);
    if (pickerFile != null) {
      insuredPerson.statementFile = await saveFile(pickerFile);
    }
    if (insuredPerson.id == null) {
      successSaved = false;
      // insuredPerson.id = await RestServices.createAndReturnId(entityName: 'tsadv\$InsuredPerson', entity: insuredPerson);
      insuredPerson.id = await RestServices.createAndReturnId(
          entityName: 'kzm_InsuredPersonKzm', entity: insuredPerson);
      dmsList = await RestServices.getMyDMS();
      getInsuredPerson = await myInsuredPerson(insuredPerson.id);
      getTsadvInsuredPerson = getTsadvInsuredPerson = await RestServices.getInsuredTsadvPerson(insuredPerson.id);
      List<Assistance> list = await RestServices.getAssistanceById(getTsadvInsuredPerson.assistance.assistance.id);
      assistanceList = await RestServices.getContractAssistanceById(insuredPerson.insuranceContract.id);
      if (list.isNotEmpty) {
        getContractAssistance = list.first;
      }
      for (int i = 0; i < dmsList.length; i++) {
        if (dmsList[i].id == getInsuredPerson.id) {
          insuredPerson = getInsuredPerson;
          break;
        }
      }
      for (int i = 0; i < assistanceList.length; i++) {
        if (getContractAssistance?.id != null) {
          if (assistanceList[i].assistance.id == getContractAssistance.id) {
            insuredPerson.assistance = assistanceList[i];
            break;
          }
        }
      }

      if (insuredPerson.id != null) {
        await members;
        setBusy(false);
        successSaved = await RestServices.updateEntity(
            entityName: 'kzm_InsuredPersonKzm',
            entityId: insuredPerson.id,
            entity: insuredPerson);
        GlobalNavigator.successSnackbar();
      } else {
        setBusy(false);
        successSaved = false;
        GlobalNavigator().errorBar(title: 'При сохранение заявка ошибка');
      }
    } else {
      setBusy(false);
      successSaved = await RestServices.updateEntity(
          entityName: 'kzm_InsuredPersonKzm',
          entityId: insuredPerson.id,
          entity: insuredPerson);
      setBusy(false);
      GlobalNavigator.pop();
      GlobalNavigator.successSnackbar();
    }
  }

  Future saveMember() async {
   if (!checkRequiredMemberFields(member)) return;
    setBusy(true);
    member.assistance = insuredPerson.assistance;
    if (member.id == null) {
      successSavedMember = false;
      member.id = await RestServices.createAndReturnId(
          entityName: 'kzm_InsuredPersonKzm', entity: member);
      setBusy(false);
      if (member.id != null) {
        successSavedMember = true;
        memberList = await RestServices.getMembers(
            insuranceContractId: insuredPerson?.insuranceContract?.id,
            personId: insuredPerson.id) as List<InsuredPerson>;
        dmsList = await RestServices.getMyDMS();
        for (int i = 0; i < dmsList.length; i++) {
          if (dmsList[i].id == getInsuredPerson.id) {
            insuredPerson = getInsuredPerson;
            break;
          }
        }
        GlobalNavigator.pop();
        GlobalNavigator.successSnackbar();
        setBusy(false);
      } else {
        setBusy(false);
        successSavedMember = false;
        GlobalNavigator().errorBar(title: S.current.errorDmsMember);
      }
    } else {
      // final bool results = await RestServices.updateEntity(entityName: 'tsadv\$InsuredPerson', entityId: member.id, entity: member);
      final bool result = await RestServices.updateEntity(
          entityName: 'kzm_InsuredPersonKzm',
          entityId: member.id,
          entity: member);
      setBusy(false);
      if (result) {
        GlobalNavigator.pop();
        GlobalNavigator.successSnackbar();
      } else {
        GlobalNavigator().errorBar(title: S.current.error);
      }
    }
  }

  Future saveFileToEntity(
      {bool isMember, File picker, List<File> multiPicker}) async {
    setBusy(true);

    if (isMember) {
      if (picker != null) {
        final FileDescriptor result = await saveFile(picker);
        member.file.add(result);
      } else {
        for (int i = 0; i < multiPicker.length; i++) {
          final FileDescriptor result = await saveFile(multiPicker[i]);
          member.file.add(result);
        }
      }
    }
    setBusy(false);
  }

  Future setMember(InsuredPerson person) async {
    member = person;
  }

  Future getMemberFiles({String memberId}) async {}

  Future calculateAmount() async {
    if (member.insuranceContract?.id != null &&
        member.birthdate != null &&
        member.relative?.id != null) {
      final amount = await RestServices.calcAmount(
          insuranceContractId: member.insuranceContract?.id ?? '',
          bith: member.birthdate,
          memberId: member.id == null ? null : member.id,
          relativeTypeId: member.relative?.id);
      amount.replaceAll(RegExp('W+'), '');
      member.amount = int.parse(amount).toDouble();
      return member.amount;
    }
  }

  Future<FileDescriptor> saveFile(File file) async {
    final FileDescriptor fileDescriptor =
        await RestServices.saveFile(file: file);
    return fileDescriptor;
  }

  bool checkRequiredFields(InsuredPerson person) {
    final S translation = S.current;

    if (person.firstName == null ||
        person.secondName == null ||
        person.sex == null ||
        person.birthdate == null ||
        person.address == null ||
        person.address == '' ||
        person.iin == null ||
        person.iin == '' ||
        person.relative == null ||
        person.documentType == null ||
        person.documentNumber == null ||
        person.documentNumber == '' ||
        person.region == null ||
        person.attachDate == null ||
        person.statusRequest == null ||
        person.insuranceContract == null ||
        person.company == null ||
        person.employee == null ||
        person.insuranceProgram == null ||
        person.insuranceProgram == '' ||
        person.insuranceProgram == null ||
        person.phoneNumber == null ||
        person.assistance == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }

    if (person.iin.length != 12) {
      setBusy(false);
      GlobalNavigator().errorBar(title: 'ИИН не соответствует формату');
      return false;
    }

    if (person.relative.code == 'PRIMARY' && person.job == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }

    //validate field file for Member
    // if (!(person.relative.code == "PRIMARY") && (person.file.isEmpty)){
    //   setBusy(false);
    //   Get.snackbar(translation.attention, translation.fillRequiredFields);
    //   return false;
    // }

    // if (person.relative.code == 'PRIMARY' && dmsList.isNotEmpty) {
    //   for (int i = 0; i < dmsList.length; i++) {
    //     if (dmsList[i].insuranceContract.id == person.insuranceContract.id) {
    //       setBusy(false);
    //       Get.snackbar(translation.attention, 'Данный сотрудник уже привязан к договору');
    //       return false;
    //     }
    //   }
    // }
    return true;
  }

  bool checkRequiredMemberFields(InsuredPerson person) {
    final S translation = S.current;

    if (person.firstName == null ||
        person.secondName == null ||
        person.sex == null ||
        person.birthdate == null ||
        person.iin == null ||
        person.iin == '' ||
        person.relative == null ||
        person.documentType == null ||
        person.address == null ||
        person.address == '' ||
        person.documentNumber == null ||
        person.documentNumber == '' ||
        person.region == null ||
        person.attachDate == null ||
        person.statusRequest == null ||
        person.insuranceContract == null ||
        person.company == null ||
        person.employee == null ||
        person.phoneNumber == null ||
        person.phoneNumber == '' ||
        person.insuranceProgram == null ||
        person.insuranceProgram == '' ||
        person.insuranceProgram == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }

    if (person.iin.length != 12) {
      setBusy(false);
      GlobalNavigator().errorBar(title: 'ИИН не соответствует формату');
      return false;
    }

    if (person.relative.code == 'PRIMARY' && person.job == null) {
      setBusy(false);
      GlobalNavigator().errorBar(title: translation.fillRequiredFields);
      return false;
    }

    //validate field file for Member
    // if (!(person.relative.code == "PRIMARY") && (person.file.isEmpty)){
    //   setBusy(false);
    //   Get.snackbar(translation.attention, translation.fillRequiredFields);
    //   return false;
    // }

    if (person.relative.code == 'PRIMARY' && dmsList.isNotEmpty) {
      for (int i = 0; i < dmsList.length; i++) {
        if (dmsList[i].insuranceContract.id == person.insuranceContract.id) {
          setBusy(false);
          GlobalNavigator().errorBar(title: 'Данный сотрудник уже привязан к договору');
          return false;
        }
      }
    }
    return true;
  }
}
