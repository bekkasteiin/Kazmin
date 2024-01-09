// import 'package:flutter/material.dart';
// import 'package:kzm/core/ui_design.dart';
// import 'package:kzm/layout/main_layout.dart';
// import 'package:kzm/layout/widgets.dart';
//
// class MyProfilePage extends StatefulWidget {
//   @override
//   _MyProfilePageState createState() => _MyProfilePageState();
// }
//
// class _MyProfilePageState extends State<MyProfilePage> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     var height2 = MediaQuery.of(context).size.height;
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         drawer: MenuDrawer(),
//         appBar: AppBar(
//           flexibleSpace: appBarBg(context),
//           title: BrandLogo(),
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: [
//               Tab(text: "Основные данные"),
//               Tab(text: "Заявка на изменение личных данных"),
//               Tab(text: "Заявка на документ"),
//               Tab(text: "Заявка на адрес"),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             height: height2 * 0.829,
//             child: TabBarView(
//               children: [
//                 Container(),
//                 Container(),
//                 Container(),
//                 Container(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }