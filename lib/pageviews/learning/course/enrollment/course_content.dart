import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/courses/course.dart';
import 'package:kzm/core/models/courses/course_notes.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/web_viewer.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/learning/course/enrollment/pdf_widget.dart';
import 'package:kzm/pageviews/learning/course/enrollment/test/test.dart';
import 'package:kzm/pageviews/learning/course/enrollment/video_player_widget.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class CourseContent extends StatefulWidget {
  final Section section;

  const CourseContent(this.section);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  bool rotated = false;

  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    final bool isTest = widget.section.sectionObject.test != null;

    return Scaffold(
      appBar: isTest
          ? null
          : CupertinoNavigationBar(
              middle: Text(
                isTest ? widget?.section?.sectionObject?.test?.instanceName ?? '' : widget.section.instanceName,
              ),
              trailing: GestureDetector(
                child: const Icon(Icons.rotate_left),
                onTap: () {
                  setState(() {
                    rotated = !rotated;
                  });
                },
              ),
            ),
      body: RotatedBox(
        quarterTurns: rotated ? 1 : 0,
        child: isTest
            ? FutureProvider<bool>(
                create: (_) => model.getTest(widget.section?.sectionObject?.id),
                initialData: null,
                child: Consumer<bool>(
                  builder: (BuildContext context, bool data, _) {
                    if (data == null) return const Center(child: LoaderWidget());
                    return CourseTest(model);
                  },
                ),
              )
            : buildLessonWidget(model),
      ),
    );
  }

  FutureProvider<bool> buildLessonWidget(LearningModel model) {
    return FutureProvider<bool>(
      create: (_) => model.getCourseContent(widget.section?.sectionObject?.content?.id),
      initialData: null,
      child: Consumer<bool>(
        builder: (BuildContext context, bool data, _) {
          print(model.courseContent?.contentType);
          if (data == null) return const CupertinoActivityIndicator();
          if (model.courseContent?.contentType == 'HTML') {
            return SingleChildScrollView(
              child: Column(
                children: [SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Html(data: model.courseContent.html)), courseButtons(model)],
              ),
            );
          }
          if (model.courseContent?.contentType == 'URL') {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: WebViewer(url: model.courseContent.url ?? ''),
                  ),
                  courseButtons(model)
                ],
              ),
            );
          }
          if (model.courseContent?.contentType == 'PDF') {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8, child: PdfWidget(model: model, url: Kinfolk.getFileUrl(model.courseContent.file.id)),
                      // child: PDF.network(
                      //     Kinfolk.getFileUrl(model.courseContent.file.id),
                      //     height: MediaQuery.of(context).size.height * 0.7,
                      //     width:  MediaQuery.of(context).size.width,
                      //     placeHolder: LoaderWidget(),
                      // ),
                      ),
                  courseButtons(model)
                ],
              ),
            );
          }
          if (model.courseContent?.contentType == 'TEXT') {
            return SingleChildScrollView(
              child: Column(
                children: [SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Html(data: model.courseContent.text)), courseButtons(model)],
              ),
            );
          }
          if (model.courseContent?.contentType == 'VIDEO') {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: VideoPlayerWidget(model.courseContent.file.url),
                    //child: NetworkVideoPlayer(url: model.courseContent.file.url)
                  ),
                  courseButtons(model)
                ],
              ),
            );
          }
          if (model.courseContent?.contentType == 'SCORM_ZIP') {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.8,
                  //   child: WebView(
                  //     initialUrl: Uri.dataFromString(
                  //         '<html><body><iframe src="${model.courseContent.url}"></iframe></body></html>', mimeType: 'text/html').toString(),
                  //     javascriptMode: JavascriptMode.unrestricted,
                  //   ),
                  // ),
                  // ScormWidget(),
                  courseButtons(model)
                ],
              ),
            );
          }
          return Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: WebViewer(url: model.courseContent?.file?.url ?? '')),
                courseButtons(model)
              ],
            ),
          ),);
        },
      ),
    );
  }

  Widget courseButtons(LearningModel model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: KzmButton(
                    outlined: true,
                    borderColor: Styles.appDarkYellowColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return courseNotesDialog(model);
                          },);
                    },
                    child: const Text('Заметки'),
                  ),
                ),
              ),
              Expanded(
                child: KzmButton(
                  onPressed: () {
                    model.endCourseSection();
                  },
                  child: const Text('Завершить раздел'),
                ),
              ),
            ],
          ),),
    );
  }

  Widget courseNotesDialog(LearningModel model) {
    final TextEditingController controller = TextEditingController();
    return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        content: SizedBox(
          // height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                  future: model.getCourseNotes(),
                  builder: (BuildContext context, AsyncSnapshot<CourseNote> snapshot) {
                    if (snapshot.data != null) {
                      controller.text = snapshot.data?.note ?? '';
                      return TextField(
                        maxLines: 5,
                        controller: controller,
                      );
                    } else {
                      return const LoaderWidget();
                    }
                  },),
              KzmButton(
                child: const Text('Сохранить'),
                onPressed: () async {
                  await model.saveCourseNotes(controller.text);
                  Get.back();
                },
              ),
            ],
          ),
        ),);
  }
}
