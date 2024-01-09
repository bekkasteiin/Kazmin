import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/book/book.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:star_rating/star_rating.dart';

class AddBookReview extends StatefulWidget {
  final BookRequest book;

  const AddBookReview({Key key, this.book}) : super(key: key);

  @override
  _AddBookReviewState createState() => _AddBookReviewState();
}

class _AddBookReviewState extends State<AddBookReview> {
  num rating = 0.0;
  Map<String, dynamic> bookReview = {
    'entityName': 'tsadv\$BookReview',
  };

  @override
  void initState() {
    super.initState();
    bookReview.putIfAbsent(
      'book',
      () => {
        'id': widget.book.id,
        'entityName': 'tsadv\$Book',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LearningModel model = Provider.of<LearningModel>(context);
    return ListTile(
      title: TextFormField(
        maxLines: null,
        onChanged: (String text) {
          bookReview['reviewText'] = text;
        },
      ),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StarRating(
              mainAxisAlignment: MainAxisAlignment.start,
              length: 5,
              rating: bookReview['rating'] as double ?? 0.0,
              between: 1.0,
              starSize: 25.0,
              onRaitingTap: (double a) {
                setState(() {
                  bookReview['rating'] = a;
                });
              },
              color: Colors.grey,
            ),
            KzmButton(
              outlined: true,
              disabled: bookReview['rating'] == null && !(bookReview['reviewText'] != null && (bookReview['reviewText'] as String).trim().isNotEmpty),
              borderColor: Styles.appDarkYellowColor,
              onPressed:  bookReview['rating'] != null || bookReview['reviewText'] != null && (bookReview['reviewText'] as String).trim().isNotEmpty
                  ? () async {
                      await model.addBookReview(bookReview);
                    }
                  : null,
              child: Text(
                S.current.leaveFeedback,
                style: Styles.mainTS.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: Styles.appAdvertsFontSize,
                  // color: Styles.appDarkYellowColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
