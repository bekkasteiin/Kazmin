import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class PdfWidget extends StatelessWidget {
  final LearningModel model;
  final String url;

  const PdfWidget({Key key, this.model, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: model.getPdf(url),
        builder: (BuildContext context, AsyncSnapshot<PDFDocument> snapshot) {
          if (snapshot.data != null) {
            return Center(
                child: PDFViewer(document: snapshot.data),
            );
          } else {
            return const LoaderWidget();
          }
        },
    );
  }
}
