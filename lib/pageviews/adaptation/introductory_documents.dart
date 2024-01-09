import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/documents_familitarization.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/learning/course/enrollment/video_player_widget.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

class IntroductaryDocuments extends StatefulWidget {
  const IntroductaryDocuments({Key key}) : super(key: key);

  @override
  State<IntroductaryDocuments> createState() => _IntroductaryDocumentsState();
}

class _IntroductaryDocumentsState extends State<IntroductaryDocuments> {
  @override
  Widget build(BuildContext context) {
    final AdaptationViewModel model = Provider.of<AdaptationViewModel>(context);
    return Scaffold(
      appBar: KzmAppBar(context: context, centerTitle: true),
      body: FutureBuilder<List<GetDocumentListResponse>>(
        future: model.getCompulsoryDocuments(),
        builder: (BuildContext context, AsyncSnapshot<List<GetDocumentListResponse>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Column(
              children: [
                pageTitle(title: S.current.newEmployeesIntroductaryDocuments),
                if (model.introductoryDocumentsList
                    .where((DocumentsFamiliarization element) => !element.acknowledgement)
                    .isNotEmpty)
                  ...model.introductoryDocumentsList
                      .where((DocumentsFamiliarization element) => !element.acknowledgement)
                      .map(
                        (DocumentsFamiliarization e) =>
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: CupertinoButton(
                                  child: Text(e.name),
                                  onPressed: () {
                                    if (e.type.code == 'VIDEO') {
                                      Get.to(_VideoPage(url: e.file.url));
                                    } else {
                                      PickerFileServices.downloadFile(e.file);
                                    }
                                  },
                                ),
                              ),
                              KzmButton(
                                bgColor: Styles.appSuccessColor,
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(S.current.newEmployeesAcquaintanceWithTheDocument),
                                        content: Text(S.current.newEmployeesMarkDocument),
                                        actions: [
                                          // OutlineButton(
                                          OutlinedButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            // textColor: Colors.black87,
                                            // padding: EdgeInsets.symmetric(horizontal: 16.w),
                                            child: Text(S.current.no),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10.w),
                                            child: MaterialButton(
                                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                                              color: const Color(0xff025487),
                                              onPressed: () async{
                                                await model.addToKnown(e).then((value) => setState(() {}));
                                              },
                                                child: Text(
                                                  S.current.yes,
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                            ),
                                            // RaisedButton(
                                            //   color: const Color(0xff025487),
                                            //   onPressed: () async {
                                            //     await model.addToKnown(e).then((value) => setState(() {}));
                                            //     // ignore: use_build_context_synchronously
                                            //   },
                                            //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                                            //   child: Text(
                                            //     S.current.yes,
                                            //     style: const TextStyle(color: Colors.white),
                                            //   ),
                                            // ),
                                          ),
                                        ],
                                        elevation: 24,
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  '✔  ${S.current.newEmployeesMarkAsFamiliar}',
                                  style: Styles.mainTS.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                      .toList(),
                if (model.introductoryDocumentsList
                    .where((DocumentsFamiliarization element) => !element.acknowledgement)
                    .isEmpty)
                  getWidgetIsEmptyList(first: true),

                ///Ознокомлен
                pageTitle(title: S.current.familiarization),
                if (model.introductoryDocumentsList
                    .where((DocumentsFamiliarization element) => element.acknowledgement)
                    .isEmpty)
                  getWidgetIsEmptyList(first: false),
                if (model.introductoryDocumentsList
                    .where((DocumentsFamiliarization element) => element.acknowledgement)
                    .isNotEmpty)
                  ...model.introductoryDocumentsList
                      .where((DocumentsFamiliarization element) => element.acknowledgement)
                      .map(
                        (DocumentsFamiliarization e) =>
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 350,
                                child: CupertinoButton(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    e.name,
                                    textAlign: TextAlign.start,
                                  ),
                                  onPressed: () {
                                    if (e.type.code == 'VIDEO') {
                                      Get.to(_VideoPage(url: e.file.url));
                                    } else {
                                      PickerFileServices.downloadFile(e.file);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                      .toList(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget getWidgetIsEmptyList({@required bool first}) {
    return Padding(
      // padding: const EdgeInsets.symmetric(vertical: 30.0),
      padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 16.w),
      child: Center(
        child: Column(
          children: <Widget>[
            // Icon(Icons.people_outline, color: Styles.appBrightGrayColor, size: 50),
            Icon(Icons.file_copy_outlined, color: Styles.appBrightGrayColor, size: 50.w),
            Text(
              first ? S.current.thereAreNoDocumentsToReview : S.current.thereAreNoFamiliarDocuments,
              style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
            )
          ],
        ),
      ),
    );
  }
}

class _VideoPage extends StatelessWidget {
  final String url;

  const _VideoPage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: VideoPlayerWidget(url),
            ),
          ],
        ),
      ),
    );
  }
}
