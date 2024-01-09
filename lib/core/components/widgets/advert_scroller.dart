// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/advert_model.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
const String fName = 'lib/core/components/widgets/advert_scroller.dart';

class KzmAdScroller extends StatelessWidget {
  final List<KzmAdModel> images;

  const KzmAdScroller({@required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Styles.appAdScrollerHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images?.length ?? 0,
        cacheExtent: 8,
        itemBuilder: (BuildContext context, int idx) {
          return FutureBuilder<bool>(
              future: showImage(images[idx]),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == null) {
                  return const LoaderWidget();
                } else {
                  return Container(
                    padding: idx > 0 ? EdgeInsets.only(
                        left: Styles.appStandartMargin * 2) : EdgeInsets.zero,
                    width: Styles.appAdScrollerImageWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: Styles.appAdScrollerImageWidth,
                          height: Styles.appAdScrollerImageHeight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Styles.appDefaultShimmerRadius),
                            child: snapshot.data ?
                            Image.network(
                              Kinfolk.getFileUrl(images[idx].imageURL).toString(),
                              fit: BoxFit.cover,
                              width: Styles.appAdScrollerImageWidth,
                              height: Styles.appAdScrollerImageHeight,
                              loadingBuilder: (BuildContext _, Widget child,
                                  ImageChunkEvent loadingProgress) {
                                return loadingProgress == null
                                    ? GestureDetector(
                                  child: child,
                                  onTap: () async {
                                    if (await canLaunch(
                                        images[idx]?.gotoURL ?? '')) {
                                      await launch(images[idx].gotoURL);
                                    } else {
                                      showNewsContent(context, images[idx].topic,
                                          images[idx].newsTextRu);

                                    }
                                  },
                                )
                                    : const KzmShimmer();},
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace stackTrace) =>
                                  Container(
                                    color: Styles.shimmerBaseColor,
                                    child: const Icon(
                                        Icons.no_photography_outlined),
                                  ),
                            ) : Container(
                              color: Styles.shimmerBaseColor,
                              child: const Icon(Icons.no_photography_outlined),
                            ),
                          ),
                        ),
                        Text(
                          images[idx].topic,
                          style: Styles.advertsText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                }
              }
          );
        },
      ),
    );
  }

  Future<bool> showImage(KzmAdModel model)async{
    final http.Request request = http.Request('GET', Uri.parse(Kinfolk.getFileUrl(model.imageURL).toString()));
    final http.StreamedResponse response = await request.send();
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }

  void showNewsContent(BuildContext context, String title, String content) {
    log('-->> $fName, showNewsContent ->> content: $content');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        title: Text(title ?? ''),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   content ?? '',
              //   style: TextStyle(fontSize: 12.w),
              // ),
              Html(
                data: content.replaceAll('\n', '<br>'),
                // Styling with CSS (not real CSS)
                // style: {
                //   'h1': Style(color: Colors.red),
                //   'p': Style(color: Colors.black87, fontSize: FontSize.medium),
                //   'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20))
                // },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          KzmButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            outlined: true,
            borderColor: Styles.appGrayColor,
            // ignore: prefer_const_constructors
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}
