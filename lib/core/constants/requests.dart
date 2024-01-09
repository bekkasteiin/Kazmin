import 'package:flutter/cupertino.dart';
import 'package:kzm/pageviews/hr_requests/rvd/absence_new_rvd_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/disability/disability_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/experience/experience_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/military/military_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_balance_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_request_model.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/bpm_requests/collective_payment_model.dart';
import 'package:kzm/viewmodels/bpm_requests/material_assistans_model.dart';
import 'package:kzm/viewmodels/bpm_requests/schedule_request_model.dart';
import 'package:provider/provider.dart';

import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_model.dart';

import '../../pageviews/hr_requests/dismissal/dismissal_request.dart';
import '../../pageviews/hr_requests/dismissal/view/dismissal_requests_view.dart';

Map<String, dynamic Function({@required BuildContext ctx})> kzmRequests = <String, dynamic Function({@required BuildContext ctx})>{
  'tsadv\$AbsenceRequest': ({@required BuildContext ctx}) => Provider.of<AbsenceRequestModel>(ctx, listen: false),
  'tsadv_AbsenceForRecall': ({@required BuildContext ctx}) => Provider.of<AbsenceForRecallModel>(ctx, listen: false),
  'tsadv\$AbsenceBalance': ({@required BuildContext ctx}) => Provider.of<AbsenceBalanceModel>(ctx, listen: false),
  'tsadv_ScheduleOffsetsRequest': ({@required BuildContext ctx}) => Provider.of<ScheduleRequestModel>(ctx, listen: false),
  'tsadv_AbsenceRvdRequest': ({@required BuildContext ctx}) => Provider.of<AbsenceNewRvdModel>(ctx, listen: false),
  'kzm_AbsenceRvdRequestKzm': ({@required BuildContext ctx}) => Provider.of<AbsenceNewRvdModel>(ctx, listen: false),
  //'tsadv_CertificateRequest': ({@required BuildContext ctx}) => Provider.of<CertificateModel>(ctx, listen: false),
  'tsadv_ChangeAbsenceDaysRequest': ({@required BuildContext ctx}) => Provider.of<ChangeAbsenceModel>(ctx, listen: false),
  'tsadv\$PersonalDataRequest': ({@required BuildContext ctx}) => Provider.of<PersonalDataRequestModel>(ctx, listen: false),
  'tsadv_PersonContactRequest': ({@required BuildContext ctx}) => Provider.of<PersonContactRequestModel>(ctx, listen: false),
  'tsadv_PersonDocumentRequest': ({@required BuildContext ctx}) => Provider.of<PersonDocumentRequestModel>(ctx, listen: false),
  'tsadv\$AddressRequest': ({@required BuildContext ctx}) => Provider.of<AddressRequestModel>(ctx, listen: false),
  'tsadv_PersonEducationRequest': ({@required BuildContext ctx}) => Provider.of<EducationRequestModel>(ctx, listen: false),
  'tsadv_PersonExperienceRequest': ({@required BuildContext ctx}) => Provider.of<ExperienceRequestModel>(ctx, listen: false),
  'tsadv_PersonQualificationRequest': ({@required BuildContext ctx}) => Provider.of<QualificationRequestModel>(ctx, listen: false),
  'tsadv_PersonAwardsDegreesRequest': ({@required BuildContext ctx}) => Provider.of<AwardDegreesRequestModel>(ctx, listen: false),
  'tsadv_DisabilityRequest': ({@required BuildContext ctx}) => Provider.of<DisabilityRequestModel>(ctx, listen: false),
  'tsadv_MilitaryFormRequest': ({@required BuildContext ctx}) => Provider.of<MilitaryRequestModel>(ctx, listen: false),
  'tsadv_BeneficiaryRequest': ({@required BuildContext ctx}) => Provider.of<BeneficiaryRequestModel>(ctx, listen: false),
  'tsadv_PersonOtherInfoRequest': ({@required BuildContext ctx}) => Provider.of<PersonOtherInfoRequestModel>(ctx, listen: false),
  'tsadv_SurChargeRequest': ({@required BuildContext ctx}) => Provider.of<MaterialAssistantViewModel>(ctx, listen: false),
  'kzm_CollAgreementPaymentRequest': ({@required BuildContext ctx}) => Provider.of<CollectivePaymentModel>(ctx, listen: false),
  //'tsadv_DismissalRequest': ({@required BuildContext ctx}) => Provider.of<DismissalRequestsView>(ctx, listen: false),
};
