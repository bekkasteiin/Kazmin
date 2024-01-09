import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/book/book.dart';
import 'package:kzm/core/models/book/dic_book_category.dart';
import 'package:kzm/core/models/course_schedule.dart';
import 'package:kzm/core/models/courses/answered_test.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/models/courses/course_category.dart';
import 'package:kzm/core/models/courses/course_notes.dart';
import 'package:kzm/core/models/courses/enrollment.dart';
import 'package:kzm/core/models/courses/learned_course.dart';
import 'package:kzm/core/models/courses/learnig_history.dart';
import 'package:kzm/core/models/courses/test.dart' as t;
import 'package:kzm/core/models/learning_request.dart';
import 'package:kzm/core/models/person_learning_contract.dart';
import 'package:kzm/core/models/slider/slide.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/core/models/trainin_calendar.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/learning/book/book_info.dart';
import 'package:kzm/pageviews/learning/course/course_info.dart';
import 'package:kzm/pageviews/learning/course_schedules/course_schedule_detail_view.dart';
import 'package:kzm/pageviews/learning/my_study_plan/my_study_plan_detail.dart';
import 'package:kzm/pageviews/learning/my_work_contracts/my_work_contracts_detail.dart';
import 'package:kzm/pageviews/learning/story/story_detail.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

class LearningModel extends BaseModel {
  List<DicCategory> coursesCategoryList;
  List<String> selectedCategories = <String>[];
  List<String> enrollmentsSelectedCategories = <String>[];
  ValueNotifier<List<Course>> coursesForCatalog = ValueNotifier<List<Course>>(<Course>[]);
  ValueNotifier<List<Course>> enrollmentsForShow = ValueNotifier<List<Course>>(<Course>[]);
  List<SliderInfoRequest> newsSliderList;
  List<DicBookCategory> bookCategoryList;
  List<LearnedCourse> enrollmentsStoryList;
  List<LearningHistory> learningHistories;
  List<Book> bookList = <Book>[];
  List<DicCategory> enrollmentsList;
  Course selectedCourse;
  Content courseContent;
  Book selectedBook;
  BookRequest selectedBookInfo;
  t.Test test;
  Enrollment enrollment;
  int index = 0;
  Map<int, dynamic> answersForCheck = <int, dynamic>{};
  AnsweredTest answeredTest = AnsweredTest();
  bool leavedReview = false;
  PDFDocument doc;
  CourseNote courseNotes;
  LearningHistory currentLearningHistory;
  List<TrainingCalendar> trainingCalendars;
  List<CourseSchedule> courseSchedules;
  CourseSchedule currentCourseSchedule;
  int initialScrollIndex = 1;
  List<LearningRequest> learningRequests;
  LearningRequest _currentLearningRequest;
  List<PersonLearningContract> personLearningContracts;

  List<TileData> get tiles {
    return <TileData>[
      TileData(
        name: S.current.myStudyPlan,
        url: KzmPages.myStudyPlan,
        svgIcon: SvgIconData.trainingCatalogue,
      ),
      // TileData(
      //   name: S.current.myCourses,
      //   url: KzmPages.myCourses,
      //   svgIcon: SvgIconData.myCourses,
      // ),
      TileData(
        name: S.current.trainingHistory,
        url: KzmPages.learnStory,
        svgIcon: SvgIconData.trainingHistory,
      ),
      TileData(
        name: S.current.library,
        url: KzmPages.library,
        svgIcon: SvgIconData.library,
      ),
      TileData(
        name: S.current.trainingCalendar,
        url: KzmPages.trainingCalendar,
        svgIcon: SvgIconData.library,
      ),
      TileData(
        name: S.current.myWorkContracts,
        url: KzmPages.myWorkContracts,
        svgIcon: SvgIconData.library,
      ),

      TileData(
        name: S.current.courseSchedule,
        url: KzmPages.courseSchedule,
        svgIcon: SvgIconData.library,
      ),
    ];
  }

  Future<List<DicCategory>> get categories async {
    await getFilteredCatalog();
    // print(coursesCategoryList.length);
    return coursesCategoryList;
  }

  Future<List<Book>> get books async {
    bookCategoryList ??= await RestServices.getBooks() as List<DicBookCategory>;
    bookList.clear();
    for (final DicBookCategory element in bookCategoryList) {
      if (element.books != null && element.books.isNotEmpty) {
        bookList.addAll(element.books);
      }
    }
    setBusy();
    return bookList;
  }

  // ignore: type_annotate_public_apis
  bool _loading = true;

  Future<bool> get isLoading async => _loading;

  // ignore: avoid_setters_without_getters
  set loading(bool val) {
    _loading = val;
    setBusy();
  }

  Future<List<TrainingCalendar>> getTrainingCalendar() async {
    trainingCalendars ??= await RestServices.getTrainingCalendars();
    return trainingCalendars;
  }

  void openCourse(Course course) {
    selectedCourse = course;
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) =>
            ChangeNotifierProvider<LearningModel>.value(value: this, child: CourseInfo()),
      ),
    );
  }

  Future<List<DicCategory>> get enrollments async {
    await getFilteredEnrollments();
    return enrollmentsList;
  }

  Future<List<LearnedCourse>> get enrollmentsStory async =>
      enrollmentsStoryList ??= await RestServices.getLearningStory();

  Future<List<LearningHistory>> get learningHistory async =>
      learningHistories = await RestServices.getLearningHistory();

  Future<List<CourseSchedule>> getCourseSchedules({bool update = false}) async {
    if (courseSchedules == null || update) {
      // print('update: $update');
      courseSchedules = await RestServices.getCourseSchedules();
      courseSchedules
          .sort((CourseSchedule a, CourseSchedule b) => b.startDate.compareTo(a.startDate));
    }
    return courseSchedules;
  }

  Future<List<SliderInfoRequest>> get sliderNews async {
    newsSliderList ??= await RestServices.getSliderNews() as List<SliderInfoRequest>;
    return newsSliderList;
  }

  Future<void> getFilteredCatalog() async {
    coursesCategoryList ??= await RestServices.getCoursesCatalog() as List<DicCategory>;

    coursesForCatalog.value = selectedCategories.isEmpty
        ? coursesCategoryList.fold(<Course>[], (List<Course> previousValue, DicCategory element) {
            for (final Course e in element.courses) {
              previousValue.add(e);
            }
            return previousValue;
          })
        : coursesCategoryList
            .where((DicCategory element) => selectedCategories.contains(element.id))
            .fold(<Course>[], (List<Course> previousValue, DicCategory element) {
            for (final Course e in element.courses) {
              previousValue.add(e);
            }
            return previousValue;
          });
  }

  Future<void> getFilteredEnrollments() async {
    enrollmentsList ??= await RestServices.getEnrollments() as List<DicCategory>;

    enrollmentsForShow.value = enrollmentsSelectedCategories.isEmpty
        ? enrollmentsList.fold(<Course>[], (List<Course> previousValue, DicCategory element) {
            for (final Course e in element.courses) {
              previousValue.add(e);
            }
            return previousValue;
          })
        : enrollmentsList
            .where((DicCategory element) => enrollmentsSelectedCategories.contains(element.id))
            .fold(<Course>[], (List<Course> previousValue, DicCategory element) {
            for (final Course e in element.courses) {
              previousValue.add(e);
            }
            return previousValue;
          });
  }

  Future<bool> getCourse(String id) async {
    selectedCourse = await RestServices.getCourseById(id);
    return true;
  }

  Future<bool> getBook(String id) async {
    selectedBookInfo = await RestServices.getBookById(id);
    return true;
  }

  Future<bool> getCourseContent(String id) async {
    courseContent = await RestServices.getCourseContentById(id);
    return true;
  }

  Future<CourseNote> getCourseNotes() async {
    courseNotes = await RestServices.getCourseNotes(selectedCourse.id) as CourseNote;
    return courseNotes;
  }

  Future<dynamic> saveCourseNotes(String newCourseNotes) async {
    courseNotes.note = newCourseNotes;

    await RestServices.updateEntity(
      entityName: 'tsadv_CoursePersonNote',
      entityId: courseNotes.id,
      entity: courseNotes,
    );
  }

  Future<bool> getTest(String id) async {
    test = await RestServices.startAndLoadTest(
      enrollmentId: enrollment.id,
      courseSectionObjectId: id,
    ) as t.Test;
    rebuild();
    return true;
  }

  Future<PDFDocument> getPdf(String url) async {
    doc = await PDFDocument.fromURL(url);
    return doc;
  }

  Future<dynamic> isUserEnrolled() async {
    final Box<dynamic> settings = await HiveUtils.getSettingsBox();
    final dynamic pgId = settings.get('pgId');
    final List<Enrollment> list = selectedCourse.enrollments
        .where((Enrollment element) => element.personGroup.id == pgId)
        .toList();
    if (list.isNotEmpty) {
      list.sort((Enrollment a, Enrollment b) => b.date.compareTo(a.date));
      enrollment = list.last;
      return enrollment.status == 'APPROVED' ? true : enrollment.status;
    } else {
      return false;
    }
  }

  Future<void> downloadCertificateOrBook(String id) async {
    setBusy(true);
    FileDescriptor descriptor;
    try {
      descriptor = await RestServices.getFileDescriptorById(id);
      final String url = Kinfolk.getFileUrl(id) as String;
      // final String fileName = '${course.certificateFiles.first.certificateFile.instanceName}pdf';
      final String fullPath = await RestServices.downloadFile(url, descriptor.name);
      setBusy(false);
      OpenFile.open(fullPath);
    } catch (ex) {
      setBusy();
      GlobalNavigator.pop();
      String error = ex.message as String;
      // print('FileDescriptorID: $id');
      if (ex.message as String == 'No element' || ex.message as String == 'Can not fetch url') {
        error = 'Файл не найдено';
      }
      GlobalNavigator().errorBar(title: error);
      throw Exception('Can not fetch FileDescriptor, ${ex.message as String}');
      // return;
    }
  }

  Future<dynamic> enrollToCourse() async {
    final Box<dynamic> settings = await HiveUtils.getSettingsBox();
    // Map enrollment = await DBProvider.createEntity(entityName: 'tsadv\$Enrollment', entityMap: {
    final Map<String, dynamic> enrollment = await RestServices.createEntity(
      entityName: 'tsadv\$Enrollment',
      entityMap: <String, dynamic>{
        '_entityName': 'tsadv\$Enrollment',
        'date': formatFullRest(DateTime.now()),
        'personGroup': <String, dynamic>{
          '_entityName': 'base\$PersonGroupExt',
          'id': settings.get('pgId'),
        },
        'course': <String, dynamic>{
          '_entityName': 'tsadv\$Course',
          'id': selectedCourse.id,
        },
        'status': selectedCourse.isOnline ? 'APPROVED' : 'REQUEST'
      },
    ) as Map<String, dynamic>;
    if (enrollment['id'] != null) {
      GlobalNavigator.doneSnackbar('Вы записаны на курс');
      selectedCourse = await RestServices.getCourseById(selectedCourse.id);
      rebuild();
    }

    return true;
  }

  Future<dynamic> endCourseSection() async {
    setBusy(true);
    //final Box settings = await HiveUtils.getSettingsBox();
    final Map<String, dynamic> courseSectionAttempt = await RestServices.createEntity(
      entityName: 'tsadv\$CourseSectionAttempt?view=course-section-attempt',
      entityMap: <String, dynamic>{
        '_entityName': selectedCourse.id,
        'attemptDate': formatFullRest(DateTime.now()),
        'activeAttempt': false,
        'success': true,
        'enrollment': <String, dynamic>{'_entityName': 'tsadv\$Enrollment', 'id': enrollment.id},
        'course': <String, dynamic>{
          '_entityName': 'tsadv\$Course',
          'id': selectedCourse.id,
        },
      },
    ) as Map<String, dynamic>;
    if (courseSectionAttempt['id'] != null) {
      GlobalNavigator.doneSnackbar('Раздел завершен');
      rebuild();
      setBusy(false);
      GlobalNavigator.pop();
    }
  }

  Future<dynamic> leaveReview(Map<String, dynamic> review) async {
    final Box<dynamic> settings = await HiveUtils.getSettingsBox();
    review.putIfAbsent(
      'personGroup',
      () => <String, dynamic>{
        '_entityName': 'base\$PersonGroupExt',
        'id': settings.get('pgId'),
      },
    );
    final Map<String, dynamic> enrollment = await RestServices.createEntity(
      entityName: 'tsadv\$CourseReview',
      entityMap: review,
    ) as Map<String, dynamic>;
    if (enrollment['id'] != null) {
      selectedCourse = await RestServices.getCourseById(selectedCourse.id);
      GlobalNavigator.doneSnackbar('Успешно');
      leavedReview = true;
      rebuild();
    }

    return true;
  }

  Future<bool> addBookReview(Map<String, dynamic> review) async {
    final Box<dynamic> settings = await HiveUtils.getSettingsBox();
    review.putIfAbsent(
      'author',
      () => <String, dynamic>{
        '_entityName': 'base\$PersonGroupExt',
        'id': settings.get('pgId'),
      },
    );
    final Map<String, dynamic> enrollment = await RestServices.createEntity(
      entityName: 'tsadv\$BookReview',
      entityMap: review,
    ) as Map<String, dynamic>;
    if (enrollment['id'] != null) {
      selectedBookInfo = await RestServices.getBookById(selectedBook?.id);
      GlobalNavigator.doneSnackbar('Отзыв сохранен');
      rebuild();
    }

    return true;
  }

  bool checkAttempt(Section e) {
    return e.courseSectionAttempts
        .where((CourseSectionAttempt element) => element.enrollment.id == enrollment.id)
        .isNotEmpty;
  }

  Future<dynamic> endTest() async {
    setBusy(true);
    answeredTest.attemptId = test.attemptId;
    answeredTest.questionsAndAnswers = <AttemptQuestionPojo>[];
    answersForCheck.forEach((int key, dynamic value) {
      final t.QuestionsAndAnswer questionsAndAnswer =
          test.testSections.first.questionsAndAnswers[key];
      answeredTest.questionsAndAnswers.add(
        AttemptQuestionPojo(
          questionId: questionsAndAnswer.id,
          answer: value is List ? List<String>.from(value) : <String>[value as String],
        ),
      );
    });
    //final a = await RestServices.endTest(test: answeredTest);
    selectedCourse = await RestServices.getCourseById(selectedCourse.id);
    rebuild();
    setBusy(false);
    GlobalNavigator.pop();
  }

  void openBook(Book e) {
    selectedBook = e;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) => ChangeNotifierProvider<LearningModel>.value(value: this, child: BookInfo()),
      ),
    );
  }

  Future<void> openStory(LearningHistory e) async {
    currentLearningHistory = e;
    setBusy(true);
    final Course course = await RestServices.getCourseById(e.courseId);
    setBusy(false);
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) => ChangeNotifierProvider<LearningModel>.value(
          value: this,
          child: StoryDetail(course: course),
        ),
      ),
    );
  }

  void openCourseSchedule(CourseSchedule element) {
    currentCourseSchedule = element;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) => ChangeNotifierProvider<LearningModel>.value(
          value: this,
          child: const CourseScheduleDetailView(),
        ),
      ),
    );
  }

  Future<void> courseScheduleRequested() async {
    setBusy(true);
    await RestServices.courseScheduleRequested(currentCourseSchedule.id).then(
      (_) async {
        await getCourseSchedules(update: true);
      },
    );
    setBusy(false);
    GlobalNavigator.pop();
    await BaseModel.showAttention(middleText: S.current.successfullyEnrolled);
  }

  Future<List<LearningRequest>> getLearninRequests() async {
    // ignore: join_return_with_assignment
    learningRequests = await RestServices.getLearninRequests();
    return learningRequests;
  }

  void openStudyPlan(LearningRequest e) {
    _currentLearningRequest = e;
    // ignore: always_specify_types
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) => ChangeNotifierProvider<LearningModel>.value(
          value: this,
          child: StudyPlanDetailView(
            learningRequest: _currentLearningRequest,
          ),
        ),
      ),
    );
  }

  Future<List<PersonLearningContract>> getMyWorkContracts() async {
    personLearningContracts ??= await RestServices.getMyWorkContracts();
    return personLearningContracts;
  }

  void openPersonLearningContract(PersonLearningContract e) {
    // ignore: always_specify_types
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute<MaterialPageRoute<dynamic>>(
        builder: (_) => ChangeNotifierProvider<LearningModel>.value(
          value: this,
          child: MyWorkContractsDetail(
            personLearningContract: e,
            balance: balanceCalculation(e),
          ),
        ),
      ),
    );
  }

  String balanceCalculation(PersonLearningContract personLearningContract) {
    if (personLearningContract.courseScheduleEnrollment.totalCost == null) {
      return '0';
    }
    final int betweenTermContDates =
        personLearningContract.termOfService.difference(personLearningContract.contractDate).inDays;
    final int betweenTermTodayDates =
        personLearningContract.termOfService.difference(DateTime.now()).inDays;
    return (personLearningContract.courseScheduleEnrollment.totalCost /
            ((betweenTermContDates + 1) / (betweenTermTodayDates + 1)))
        .toStringAsFixed(2);
  }
}
