// ignore_for_file: join_return_with_assignment
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/assignment/employee_category.dart';
import 'package:kzm/core/models/company_vacation/company_vacation.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';
import 'package:kzm/core/models/user_info.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/vacancies/vacation_recommend_view.dart';
import 'package:kzm/viewmodels/base_model.dart';

class CompanyVacationModel extends BaseModel {
  List<CompanyVacation> futureList;
  VacanciesRecommend request;
  List<AbstractDictionary> workExperience;
  List<AbstractDictionary> relationshipToReferrer;
  List<AbstractDictionary> education;
  List<AbstractDictionary> personalEvaluation;
  List<AbstractDictionary> companySearch;
  CompanyVacationItem companyVacationItem;
  List<EmployeeCategory> category;
  UserInfo userInfo;

  Future<List<AbstractDictionary>> workExperiences() async {
    workExperience = await RestServices.getDicExperience();
    workExperience.sort((a, b) => a.instanceName.compareTo(b.instanceName));
    return workExperience;
  }

  getUserInfo() async {
    userInfo = await RestServices.getUserInfo();
    return userInfo;
  }

  Future<List<AbstractDictionary>> relationshipToReferrers() async {
    relationshipToReferrer = await RestServices.relationshipToReferrer();
    return relationshipToReferrer;
  }

  Future<List<AbstractDictionary>> companySearches() async {
    companySearch = await RestServices.companySearches();
    return companySearch;
  }

  Future<List<AbstractDictionary>> dicEducation() async {
    education = await RestServices.dicEducation();
    return education;
  }

  Future<List<AbstractDictionary>> personalEvaluations() async {
    personalEvaluation = await RestServices.dicPersonalEvaluation();
    return personalEvaluation;
  }

  Future<EmployeeCategory> get allRequest async {
    category ??= await RestServices.getAttachmentCategory();
    return category.first;
  }

  Future<List<CompanyVacation>> getHistoriesSearch(
      {AbstractDictionary company, String nameOrg}) async {
    companySearches();
    futureList = await RestServices.getCompanyVacation(
      companyId: company?.id ?? '',
      companyName: nameOrg ?? '',
    );
    return futureList;
  }

  Future<void> getRequestDefaultValue() async {
    request = VacanciesRecommend();
    workExperiences();
    relationshipToReferrers();
    personalEvaluations();
    dicEducation();
    Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(
          builder: (_) => const RecommendVacationView(),
        ));
  }

  bool checkRequiredFields() {
    if (request.file == null ||
        request.firstName == null ||
        request.lastName == null ||
        request.workExperience == null ||
        request.cityResidence == null ||
        request.education == null ||
        request.personalEvaluation == null ||
        request.email == null ||
        request.mobilePhone == null ||
        request.birthDate == null ||
        request.relationshipToReferrer == null) {
      GlobalNavigator().fillAllBar();
      return false;
    }
    return true;
  }

  createCandidate() async {
    setBusy(true);
    BasePersonGroupExt personGroup = await RestServices.getPersonByFullName(
        firstName: request.firstName,
        lastName: request.lastName,
        birthDate: request.birthDate,);
    if (personGroup != null) {
      setBusy(false);
      if (await RestServices()
          .checkClicks(companyVacationItem.id, personGroup.id)) {
        GlobalNavigator().errorClickRecommendBar();
        return;
      }
    } else {
      setBusy(true);
      personGroup = await RestServices.createCandidate(
        mobilePhone: request.mobilePhone,
        email: request.email,
        birthDate: request.birthDate,
        companyId: companyVacationItem.id,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    }
    request.vacancy = companyVacationItem;
    request.personGroup = personGroup;
    await RestServices.createRefferalCandidate(request);
    await RestServices.createPersonAttachment(
      personGroup: request.personGroup.id,
      attachment: request.file,
      category: category.first,
    );
    final Map create = await RestServices.getPersonGroupRefferalCandidate(
        request.personGroup.id) as Map;
    var personId = create['person']['id'];
    await RestServices.createCityGroupRefferalCandidate(
        id: personId.toString(), city: request.cityResidence);
    bool successSaved = await RestServices.applyRecommendVacation(
      companyId: companyVacationItem.id,
      personId: request.personGroup.id,
    );
    setBusy(false);
    if (successSaved == true) {
      GlobalNavigator.pop();
      GlobalNavigator.pop();
      GlobalNavigator.successSnackbar();
    } else {
      GlobalNavigator.errorSnackbar(S.current.serverError);
    }
  }

  Future<void> saveApply(FileDescriptor attachment) async {
    try {
      final Box settings = await HiveUtils.getSettingsBox();
      final id = settings.get('pgId');
      bool click = await RestServices()
          .checkClicks(companyVacationItem.id, id.toString());
      if (click == false) {
        await applyPersonAttachment(attachment);
      } else {
        GlobalNavigator().errorClickBar();
      }
    } catch (e) {
      GlobalNavigator().errorClickBar();
    } finally {}
  }

  Future applyPersonAttachment(FileDescriptor attachment) async {
    final Box settings = await HiveUtils.getSettingsBox();
    final id = settings.get('pgId');
    setBusy(true);
    final Map courseSectionAttempt = await RestServices.createPersonAttachment(
      personGroup: id.toString(),
      attachment: attachment,
      category: category.first,
    ) as Map;
    if (courseSectionAttempt['id'] != null) {
      bool successSaved = await RestServices.applyVacation(
        companyId: companyVacationItem.id,
      );
      setBusy(false);
      if (successSaved == true) {
        GlobalNavigator.pop();
        GlobalNavigator.pop();
        GlobalNavigator.successSnackbar();
      }
    }
  }

  Future<CompanyVacationItem> getVacation(String id) async {
    companyVacationItem = await RestServices.getCompanyVacationItem(id);
    return companyVacationItem;
  }
}
