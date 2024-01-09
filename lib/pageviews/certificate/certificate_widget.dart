import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/certificate/certificate.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';

const String fName = 'lib/pageviews/certificate/certificate_widget.dart';

class CertificateWidget extends StatefulWidget {
  final CertificateModel model;

  const CertificateWidget({Key key, this.model}) : super(key: key);

  @override
  _CertificateWidgetState createState() => _CertificateWidgetState();
}

class _CertificateWidgetState extends State<CertificateWidget> with TickerProviderStateMixin {
  Future<List<CertificateRequest>> future;
  bool loading;

  @override
  void initState() {
    future = widget.model.getRequests();
    loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CertificateRequest>>(
        future: widget.model.getRequests(),
        builder: (BuildContext context, AsyncSnapshot<List<CertificateRequest>> snapshot) {
          if ((snapshot.connectionState == ConnectionState.done) || (snapshot.data != null)) loading = false;
          if (loading) return const Center(child: LoaderWidget());
          return widget.model.requestList?.isEmpty ?? true
              ? KZMNoData()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.w, bottom: 24.w),
                    child: Column(
                      children: widget.model.requestList.map(
                        (CertificateRequest e) {
                          final String requestNumber = e.requestNumber != null ? '№${e.requestNumber.toString()}' : '';
                          final String date = formatShortly(e.requestDate);
                          final String status = e.status != null ? e.status.instanceName : '';
                          final String receivingType = e.receivingType.code ?? '';
                          return KzmCard(
                            statusColor: getColorByStatusCode(e.status.code),
                            title: '$requestNumber ($date)',
                            subtitle: status,
                            trailing: Container(
                              child: receivingType == 'SCAN_VERSION'
                                  ? e.status?.code == 'APPROVED'
                                      ? IconButton(
                                          icon: SvgPicture.asset(
                                            SvgIconData.pdfFileColor,
                                            // color: Styles.appPrimaryColor,
                                            height: 40.0,
                                          ),
                                          color: Styles.appPrimaryColor,
                                          iconSize: Styles.appDefaultIconSize,
                                          // ignore: unnecessary_await_in_return
                                          onPressed: () {
                                            // showCupertinoModalPopup<void>(
                                            //   context: context,
                                            //   builder: (BuildContext context) => CupertinoActionSheet(
                                            //     // title: const Text('Выберите'),
                                            //     // message: const Text('Message'),
                                            //     actions: <CupertinoActionSheetAction>[
                                            //       CupertinoActionSheetAction(
                                            //         child: const Text('Cмотреть'),
                                            //         onPressed: () {
                                            //           Get.back();
                                            //           log('-->> $fName, build ->> e.file.url: ${e.file.url}');
                                            //           Get.to(() => PdfView(url: e.file.url));
                                            //         },
                                            //       ),
                                            //       CupertinoActionSheetAction(
                                            //         child: const Text('Скачать'),
                                            //         onPressed: () {
                                            //           Get.back();
                                            //           PickerFileServices.downloadFile(e.file);
                                            //         },
                                            //       ),
                                            //     ],
                                            //     cancelButton: CupertinoActionSheetAction(
                                            //       child: Text(S.current.cancel),
                                            //       onPressed: () {
                                            //         Navigator.pop(context);
                                            //       },
                                            //     ),
                                            //   ),
                                            // );
                                            PickerFileServices.downloadFile(e.file);
                                          },
                                        )
                                      : const SizedBox()
                                  : const Text('На руки'),
                            ),
                            selected: () async {
                              widget.model.request = e;
                              widget.model.openRequestById(e.id);
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await widget.model.getRequestDefaultValue().then((value) async {
            loading = true;
            widget.model.getRequests;
            setState(() {
              loading = false;
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
