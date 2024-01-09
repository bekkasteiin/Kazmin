import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/cached_image.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/learning/book/book_reviews.dart';
import 'package:kzm/pageviews/learning/book/leave_book_review.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';

class BookInfo extends StatefulWidget {
  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        child: FutureProvider<bool>(
          create: (_) => model.getBook(model.selectedBook?.id ?? ''),
          initialData: null,
          child: Consumer<bool>(
            builder: (BuildContext context, bool data, _) {
              return data == null
                  ? const LoaderWidget()
                  : contentShadow(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16.w),
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: CachedImage(
                              Kinfolk.getFileUrl(model.selectedBook.image?.id ?? '') as String,
                            ),
                          ),
                          Divider(
                            height: 16.w,
                            thickness: 1.w,
                            color: Styles.appBorderColor,
                          ),
                          FieldBones(
                            placeholder: S.current.name,
                            textValue: model.selectedBookInfo?.instanceName ?? '',
                          ),
                          FieldBones(
                            placeholder: S.current.author,
                            textValue: model.selectedBookInfo?.authorLang1 ?? '',
                          ),
                          FieldBones(
                            placeholder: S.current.description,
                            textValue: model.selectedBookInfo?.bookDescriptionLang1 ?? '',
                            maxLinesSubTitle: 100,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 8.w),
                          //   child: Text(
                          //     S.current.description,
                          //     style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                          //   ),
                          // ),
                          // BookDescription(model.selectedBookInfo),
                          KzmExpansionTile(
                            initiallyExpanded: true,
                            title: S.current.comments,
                            children: <Widget>[
                              AddBookReview(book: model.selectedBookInfo),
                              BookReviews(book: model.selectedBookInfo),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: KzmButton(
                              bgColor: Styles.appSuccessColor,
                              onPressed: () async {
                                await model.downloadCertificateOrBook(model.selectedBook.pdf.id);
                              },
                              child: Text(S.current.download),
                            ),
                          )
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
