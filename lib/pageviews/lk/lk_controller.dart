//@dart=2.18
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/tsadv_address.dart';
import 'package:kzm/core/models/entities/tsadv_beneficiary.dart';
import 'package:kzm/core/models/entities/tsadv_disability.dart';
import 'package:kzm/core/models/entities/tsadv_military_form.dart';
import 'package:kzm/core/models/entities/tsadv_person_awards_degrees.dart';
import 'package:kzm/core/models/entities/tsadv_person_contact.dart';
import 'package:kzm/core/models/entities/tsadv_person_document.dart';
import 'package:kzm/core/models/entities/tsadv_person_education.dart';
import 'package:kzm/core/models/entities/tsadv_person_experience.dart';
import 'package:kzm/core/models/entities/tsadv_person_qualification.dart';
import 'package:kzm/pageviews/lk/_misc/po_ids.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:supercharged/supercharged.dart';

const String fName = 'lib/pageviews/lk/lk_controller.dart';

class KzmLKController extends GetxController {
  final KzmPrivateOfficeIDs ids = Get.find<KzmPrivateOfficeIDs>();
  KzmLKModel model = Get.find<KzmLKModel>();
  final KzmPrivateOfficeServices _services =
      Get.find<KzmPrivateOfficeServices>();

  @override
  Future<void> onInit() async {
    await fetchMainData();
    super.onInit();
  }

  Future<void> fetchMainData() async {
    model.personProfile = await _services.getPersonProfile();
    final DateTime dt = DateTime.now();
    model.personProfile?.ext = (await _services.getPersonExt(
      startDate: formatFullRestNotMilSec(dt),
      endDate: formatFullRestNotMilSec(dt),
    ))
        .firstOrElse(() => BasePersonExt());
    update(<UniqueKey>[ids.lkView]);

    _services
        .getEntityList<TsadvPersonDocument>(
      entityName: TsadvPersonDocument.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonDocument.fromMap(e),
      view: TsadvPersonDocument.view,
      property: TsadvPersonDocument.property,
    )
        .then(
      (List<TsadvPersonDocument> value) {
        model.personDocuments = value;
        update(<UniqueKey>[ids.mainDataPersonDocuments]);
      },
    );

    _services
        .getEntityList<TsadvAddress>(
      entityName: TsadvAddress.entity,
      fromMap: (Map<String, dynamic> e) => TsadvAddress.fromMap(e),
      view: TsadvAddress.view,
      property: TsadvAddress.property,
    )
        .then(
      (List<TsadvAddress> value) {
        model.address = value;
        update(<UniqueKey>[ids.mainDataAddress]);
      },
    );

    _services
        .getEntityList<TsadvPersonContact>(
      entityName: TsadvPersonContact.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonContact.fromMap(e),
      view: TsadvPersonContact.view,
      property: TsadvPersonContact.property,
    )
        .then(
      (List<TsadvPersonContact> value) {
        model.personContact = value;
        update(<UniqueKey>[ids.mainDataPersonContact]);
      },
    );

    _services
        .getEntityList<TsadvPersonEducation>(
      entityName: TsadvPersonEducation.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonEducation.fromMap(e),
      view: TsadvPersonEducation.view,
      property: TsadvPersonEducation.property,
    )
        .then(
      (List<TsadvPersonEducation> value) {
        model.education = value;
        update(<UniqueKey>[ids.mainDataEducation]);
      },
    );

    _services
        .getEntityList<TsadvPersonExperience>(
      entityName: TsadvPersonExperience.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonExperience.fromMap(e),
      view: TsadvPersonExperience.view,
      property: TsadvPersonExperience.property,
    )
        .then(
      (List<TsadvPersonExperience> value) {
        model.experience = value;
        update(<UniqueKey>[ids.mainDataExperience]);
      },
    );

    _services
        .getEntityList<TsadvPersonQualification>(
      entityName: TsadvPersonQualification.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonQualification.fromMap(e),
      view: TsadvPersonQualification.view,
      property: TsadvPersonQualification.property,
    )
        .then(
      (List<TsadvPersonQualification> value) {
        model.qualification = value;
        update(<UniqueKey>[ids.mainDataQualification]);
      },
    );

    _services
        .getEntityList<TsadvPersonAwardsDegrees>(
      entityName: TsadvPersonAwardsDegrees.entity,
      fromMap: (Map<String, dynamic> e) => TsadvPersonAwardsDegrees.fromMap(e),
      view: TsadvPersonAwardsDegrees.view,
      property: TsadvPersonAwardsDegrees.property,
    )
        .then(
      (List<TsadvPersonAwardsDegrees> value) {
        model.awardsDegrees = value;
        update(<UniqueKey>[ids.mainDataAwardsDegrees]);
      },
    );

    _services
        .getEntityList<TsadvDisability>(
      entityName: TsadvDisability.entity,
      fromMap: (Map<String, dynamic> e) => TsadvDisability.fromMap(e),
      view: TsadvDisability.view,
      property: TsadvDisability.property,
    )
        .then(
      (List<TsadvDisability> value) {
        model.disability = value;
        update(<UniqueKey>[ids.mainDataDisability]);
      },
    );

    _services
        .getEntityList<TsadvMilitaryForm>(
      entityName: TsadvMilitaryForm.entity,
      fromMap: (Map<String, dynamic> e) => TsadvMilitaryForm.fromMap(e),
      view: TsadvMilitaryForm.view,
      property: TsadvMilitaryForm.property,
    )
        .then(
      (List<TsadvMilitaryForm> value) {
        model.military = value;
        update(<UniqueKey>[ids.mainDataMilitary]);
      },
    );

    _services
        .getEntityList<TsadvBeneficiary>(
      entityName: TsadvBeneficiary.entity,
      fromMap: (Map<String, dynamic> e) => TsadvBeneficiary.fromMap(e),
      view: TsadvBeneficiary.view,
      property: TsadvBeneficiary.property,
    )
        .then(
      (List<TsadvBeneficiary> value) {
        model.beneficiary = value;
        update(<UniqueKey>[ids.mainDataBeneficiary]);
      },
    );

    _services
        .getEntityList<BasePersonExt>(
      entityName: BasePersonExt.entity,
      fromMap: (Map<String, dynamic> e) => BasePersonExt.fromMap(e),
      view: BasePersonExt.view,
      property: BasePersonExt.property,
      limit: 1,
    )
        .then(
      (List<BasePersonExt> value) {
        // for(final BasePersonExt x in value) {
        //   log('-->> $fName, fetchMainData ->> BasePersonExt value: ${x.toJson()}');
        // }
        model.personExt = value;
        update(<UniqueKey>[ids.mainDataPersonExt]);
      },
    );
  }
}
