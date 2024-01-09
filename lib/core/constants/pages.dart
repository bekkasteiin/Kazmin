import 'package:get/get.dart';
import 'package:kzm/layout/main_layout.dart';
import 'package:kzm/layout/update_required_layout.dart';
import 'package:kzm/pageviews/adaptation/adaptation_page.dart';
import 'package:kzm/pageviews/adaptation/adaptation_team.dart';
import 'package:kzm/pageviews/adaptation/compulsory_courses.dart';
import 'package:kzm/pageviews/adaptation/introductory_documents.dart';
import 'package:kzm/pageviews/adaptation/my_tasks.dart';
import 'package:kzm/pageviews/calculation_sheet/payslip_page_view.dart';
import 'package:kzm/pageviews/certificate/certificate_mobile_view.dart';
import 'package:kzm/pageviews/competencies/competencies_view.dart';
import 'package:kzm/pageviews/daily_questions/kzm_daily_questions.dart';
import 'package:kzm/pageviews/dms/insured_person_view.dart';
import 'package:kzm/pageviews/hr_requests/all_absence_request/all_absence_widget.dart';
import 'package:kzm/pageviews/hr_requests/all_absence_request/change_days/change_absence_view.dart';
import 'package:kzm/pageviews/hr_requests/all_absence_request/for_recall/absence_recall_view.dart';
import 'package:kzm/pageviews/hr_requests/hr_requests_view.dart';
import 'package:kzm/pageviews/hr_requests/my_vacation_balance/vacation_balance_view.dart';
import 'package:kzm/pageviews/hr_requests/rvd/view/absence_new_rvd_view.dart';
import 'package:kzm/pageviews/kpi/my_kpi_view.dart';
import 'package:kzm/pageviews/kpi/team/team_kpi_view.dart';
import 'package:kzm/pageviews/learning/book/library.dart';
import 'package:kzm/pageviews/learning/catalog_list.dart';
import 'package:kzm/pageviews/learning/course_schedules/course_schedule_view.dart';
import 'package:kzm/pageviews/learning/learning_mobile_view.dart';
import 'package:kzm/pageviews/learning/my_study_plan/my_study_plan_view.dart';
import 'package:kzm/pageviews/learning/my_work_contracts/my_work_contracts_view.dart';
import 'package:kzm/pageviews/learning/story/learn_story.dart';
import 'package:kzm/pageviews/learning/training_calendar/training_calendar_view.dart';
import 'package:kzm/pageviews/lk/lk_binding.dart';
import 'package:kzm/pageviews/lk/lk_view.dart';
import 'package:kzm/pageviews/login/login_code_verify.dart';
import 'package:kzm/pageviews/login/login_iin_phone.dart';
import 'package:kzm/pageviews/login/login_pageview.dart';
import 'package:kzm/pageviews/login/login_password_saved.dart';
import 'package:kzm/pageviews/login/login_save_password.dart';
import 'package:kzm/pageviews/login/pin/pin_page_view.dart';
import 'package:kzm/pageviews/material_assistance/create_material_request.dart';
import 'package:kzm/pageviews/material_assistance/material_assistance.dart';
import 'package:kzm/pageviews/material_assistance/my_material_requests.dart';
import 'package:kzm/pageviews/my_absences/absence_mobile_view.dart';
import 'package:kzm/pageviews/my_team/my_team_page_view.dart';
import 'package:kzm/pageviews/notifications/notification_mobile_view.dart';
import 'package:kzm/pageviews/send_message/sm_binding.dart';
import 'package:kzm/pageviews/send_message/sm_view.dart';
import 'package:kzm/pageviews/settings/settings_pageview.dart';
import 'package:kzm/pageviews/vacancies/vacation_mobile_view.dart';

import '../../pageviews/hr_requests/ovd/view/ovd_view.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/view/dismissal_view.dart';

class KzmPages {
  KzmPages._();

  static const String login = '/login';
  static const String init = '/init';
  static const String notificationsPage = '/notificationsPage';
  static const String pin_create = '/pin_create';
  static const String pin = '/pin';
  static const String update = '/update';
  static const String settings = '/settings';
  static const String myTeam = '/myTeam';
  static const String absence = '/absence';
  static const String notifications = '/notifications';
  static const String learning = '/learning';
  static const String mykpi = '/mykpi';
  static const String kpi = '/kpi';
  static const String dms = '/dms';
  static const String courseCatalog = '/courseCatalog';
  static const String myCourses = '/myCourses';
  static const String learnStory = '/learnStory';
  static const String library = '/library';
  static const String certificate = '/certificate';
  static const String iinPhone = '/signUp';
  static const String codeVerify = '/codeVerify';
  static const String savePassword = '/savePassword';
  static const String passwordSaved = '/passwordSaved';
  static const String dailyQuestions = '/dailyQuestions';
  static const String sendMessage = '/sendMessage';
  static const String hrRequests = '/hrRequests';
  static const String jclRequest = '/jclRequest';
  static const String payslip = '/payslip';
  static const String materialAssistance = '/materialAssistance';
  static const String createMaterialRequest = '/createMaterialRequest';
  static const String myMaterialRequest = '/myMaterialRequest';
  static const String newEmployees = '/newEmployees';
  static const String dateOfAdaptation = '/dateOfAdaptation';
  static const String myTasks = '/myTasks';
  static const String introductoryDocuments = '/introductoryDocuments';
  static const String myAdaptationTeam = '/myAdaptationTeam';
  static const String compulsoryCourses = '/compulsoryCourses';

  static const String absenceNewRvd = '/absenceNewRvd';
  static const String ovd = '/ovd';
  static const String changeAbsence = '/changeAbsence';
  static const String absenceRequest = '/absenceRequest';
  static const String absenceForRecall = '/absenceForRecall';
  static const String absenceVacationBalance = '/absenceVacationBalance';

  static const String privateOffice = '/privateOffice';
  static const String privateOfficeMainDataView = '/privateOfficeMainDataView';
  static const String privateOfficePersonProfileView = '/privateOfficePersonProfileView';
  static const String privateOfficePersonDocumentView = '/privatePersonDocumentView';

  static const String trainingCalendar = '/trainingCalendar';
  static const String courseSchedule = '/courseSchedule';
  static const String myStudyPlan = '/myStudyPlan';
  static const String myWorkContracts = '/myWorkContracts';
  static const String competenceAssessment = '/competenceAssessment';
  static const String vacationOrg = '/vacationOrg';
  static const String dismissal = '/dismissal';

  // Competence assessment
  static List<GetPage> pages = <GetPage>[
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: init, page: () => MainLayout()),
    GetPage(name: update, page: () => UpdateRequiedLayout()),
    GetPage(name: settings, page: () => SettingsPageView()),
    GetPage(name: myTeam, page: () => MyTeamPageView()),
    GetPage(name: absence, page: () => AbsencePageView()),
    GetPage(name: notifications, page: () => NotificationPageView(), bindings: <Bindings>[KzmLKBinding()]),
    GetPage(name: notificationsPage, page: () => NotificationPageView(indexPage: 1,), bindings: <Bindings>[KzmLKBinding()]),
    GetPage(name: learning, page: () => LearningPageView()),
    GetPage(name: mykpi, page: () => MyKpiPageView()),
    GetPage(name: kpi, page: () => KpiTeamView()),
    GetPage(name: dms, page: () => InsuredPersonPageView()),
    GetPage(name: courseCatalog, page: () => CatalogList()),
    // GetPage(name: myCourses, page: () => EnrollmentsList()),
    GetPage(name: learnStory, page: () => LearnStory()),
    GetPage(name: library, page: () => Library()),
    GetPage(name: certificate, page: () => CertificatePageView()),
    GetPage(name: trainingCalendar, page: () => const TrainingCalendarView()),
    GetPage(name: iinPhone, page: () => LoginIINPhone()),
    GetPage(name: courseSchedule, page: () => const CourseScheduleView()),
    GetPage(name: myWorkContracts, page: () => const MyWorkContractsView()),
    GetPage(name: myStudyPlan, page: () => const MyStudyPlanView()),
    GetPage(name: codeVerify, page: () => LoginCodeVerify()),
    GetPage(name: savePassword, page: () => LoginSavePassword()),
    GetPage(name: passwordSaved, page: () => LoginPasswordSaved()),
    GetPage(name: dailyQuestions, page: () => KzmDailyQuestions()),
    GetPage(name: sendMessage, page: () => KzmSendMessageView(), bindings: <Bindings>[KzmSendMessageBinding()]),
    GetPage(name: hrRequests, page: () => HrRequestsPageView(), bindings: <Bindings>[KzmLKBinding()]),
    GetPage(name: jclRequest, page: () => CertificatePageView()),
    GetPage(name: competenceAssessment, page: () => const CompetenciesView()),
    GetPage(name: payslip, page: () => const PayslipPageView()),
    GetPage(name: materialAssistance, page: () => const MaterialAssistancePage()),
    GetPage(name: createMaterialRequest, page: () => const CreateMaterialRequest()),
    GetPage(name: myMaterialRequest, page: () => const MyMaterialRequests()),
    GetPage(name: sendMessage, page: () => KzmSendMessageView(), bindings: <Bindings>[KzmSendMessageBinding()]),
    GetPage(name: privateOffice, page: () => KzmLKView(), bindings: <Bindings>[KzmLKBinding()]),
    GetPage(name: newEmployees, page: () => const NewEmployeesPage()),
    GetPage(name: myTasks, page: () => const MyTasks()),
    GetPage(name: introductoryDocuments, page: () => const IntroductaryDocuments()),
    GetPage(name: myAdaptationTeam, page: () => const MyAdaptationTeam()),
    GetPage(name: compulsoryCourses, page: () => const CompulsoryCourses()),
    GetPage(name: absenceNewRvd, page: () => AbsenceNewRvdView()),
    GetPage(name: ovd, page: () => OvdView()),
    GetPage(name: changeAbsence, page: () => const ChangeAbsenceWidget()),
    GetPage(name: absenceRequest, page: () => const AllAbsenceWidget('tsadv\$AbsenceRequest', '')),
    GetPage(name: absenceForRecall, page: () => const AbsenceRecallWidget()),
    GetPage(name: absenceVacationBalance, page: () => const VacationBalanceView()),
    GetPage(name: vacationOrg, page: () =>  VacationPageView()),
    GetPage(name: dismissal, page: () => DismissalView()),
    GetPage(name: pin_create, page: () => PinPage(true)),
    GetPage(name: pin, page: () => PinPage(false)),
  ];
}
