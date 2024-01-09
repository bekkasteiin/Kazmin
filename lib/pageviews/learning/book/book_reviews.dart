import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/book/book.dart';
import 'package:kzm/core/models/book/book_reviews_request.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:star_rating/star_rating.dart';

class BookReviews extends StatelessWidget {
  final BookRequest book;

  const BookReviews({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookReviewRequest>>(
      future: RestServices.getBookReviewsByBookId(book.id),
      builder: (BuildContext context, AsyncSnapshot<List<BookReviewRequest>> snapshot) {
        if (snapshot.data == null) {
          return const LoaderWidget();
        } else {
          return Column(
            children: snapshot.data
                .map((BookReviewRequest e) {
                  return Container(
                    color: Styles.appBrightGrayColor.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 4.w),
                    child: ListTile(
                      title: Text(
                        e?.author?.instanceName ?? '',
                        style: Styles.mainTS.copyWith(
                          fontSize: Styles.appSubtitleFontSize,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StarRating(
                            mainAxisAlignment: MainAxisAlignment.start,
                            length: 5,
                            rating: e.rating.toDouble(),
                            between: 1.0,
                            starSize: 15.0,
                            onRaitingTap: (_) {},
                            color: Colors.grey,
                          ),
                          Text(
                            e.reviewText ?? '',
                            style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor, fontSize: Styles.appAdvertsFontSize),
                          ),
                        ],
                      ),
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          );
        }
      },
    );
  }
}
