import 'dart:developer';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/layout/loader_layout.dart';

const String fName = 'lib/core/components/widgets/pdf_view.dart';

class PdfView extends StatelessWidget {
  final String url;

  const PdfView({@required this.url, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(context: context, showMenu: false,),
      body: FutureBuilder<PDFDocument>(
        future: PickerFileServices.getPdf(url),
        builder: (BuildContext context, AsyncSnapshot<PDFDocument> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              log('-->> $fName, build ->> snapshot.data: ${snapshot.data.count}');
              return Center(child: PDFViewer(document: snapshot.data));
            }
          }
          // if (snapshot.data != null) {
          //   log('-->> $fName, build ->> snapshot.data: ${snapshot.data}');
          //   return Center(child: PDFViewer(document: snapshot.data));
          // } else {
          //   return const LoaderWidget();
          // }
          return const LoaderWidget();
        },
      ),
    );
  }
}
