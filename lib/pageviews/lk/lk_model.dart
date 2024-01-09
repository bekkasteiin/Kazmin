//@dart=2.18
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/other/person_profile.dart';
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

class KzmLKModel {
  PersonProfile? personProfile;
  List<TsadvPersonDocument>? personDocuments;
  List<TsadvAddress>? address;
  List<TsadvPersonContact>? personContact;
  List<TsadvPersonEducation>? education;
  List<TsadvPersonExperience>? experience;
  List<TsadvPersonQualification>? qualification;
  List<TsadvPersonAwardsDegrees>? awardsDegrees;
  List<TsadvDisability>? disability;
  List<TsadvMilitaryForm>? military;
  List<TsadvBeneficiary>? beneficiary;
  List<BasePersonExt>? personExt;
}
