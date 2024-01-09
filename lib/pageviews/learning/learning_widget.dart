import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class LearningWidget extends StatefulWidget {
  final LearningModel model;

  const LearningWidget({Key key, this.model}) : super(key: key);

  @override
  _LearningWidgetState createState() => _LearningWidgetState();
}

class _LearningWidgetState extends State<LearningWidget> {
  // // ignore: always_specify_types
  // final StreamController _streamController = StreamController();
  //
  // @override
  // void initState() {
  //   _streamController.add(0);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _streamController?.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // getSliders(),
          pageTitle(title: S().training),
          MenuList(
            list: widget.model.tiles,
            model: widget.model,
          ),
        ],
      ),
    );
  }

  // Widget getSliders() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 16.w),
  //     child: FutureProvider(
  //       create: (BuildContext context) => widget.model.sliderNews,
  //       initialData: null,
  //       child: Consumer<List<SliderInfoRequest>>(
  //         builder: (BuildContext context, List<SliderInfoRequest> list, Widget child) {
  //           return list == null
  //               ? const LoaderWidget()
  //               : Column(
  //                   children: [
  //                     CarouselSlider(
  //                       options: CarouselOptions(
  //                         height: MediaQuery.of(context).size.height * 0.1,
  //                         viewportFraction: 0.9,
  //                         initialPage: 0,
  //                         enableInfiniteScroll: true,
  //                         reverse: false,
  //                         autoPlay: true,
  //                         autoPlayInterval: const Duration(seconds: 3),
  //                         autoPlayAnimationDuration: const Duration(milliseconds: 1000),
  //                         autoPlayCurve: Curves.fastOutSlowIn,
  //                         enlargeCenterPage: false,
  //                         scrollDirection: Axis.horizontal,
  //                         onPageChanged: (index, reason) {
  //                           _streamController.add(index);
  //                         },
  //                       ),
  //                       items: list.map((e) {
  //                         var file = Kinfolk.getFileUrl(e.image.id);
  //                         return InkWell(
  //                           onTap: () async {
  //                             if (await canLaunch(e.url)) {
  //                               await launch(e.url);
  //                             } else {
  //                               throw 'Could not launch ${e.url}';
  //                             }
  //                           },
  //                           child: Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: 8.w),
  //                             child: CachedImage(file as String),
  //                           ),
  //                         );
  //                       }).toList(),
  //                     ),
  //                     StreamBuilder(
  //                       stream: _streamController.stream,
  //                       // ignore: always_specify_types
  //                       builder: (BuildContext context, AsyncSnapshot snapS) {
  //                         return Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             for (int i = 0; i < list.length; i++)
  //                               Container(
  //                                 width: 10,
  //                                 height: 10,
  //                                 margin: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 5.0.w),
  //                                 decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   color: snapS.data == i ? Styles.appDarkBlueColor : Styles.appDarkGrayColor.withOpacity(0.5),
  //                                 ),
  //                               )
  //                           ],
  //                         );
  //                       },
  //                     )
  //                   ],
  //                 );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
