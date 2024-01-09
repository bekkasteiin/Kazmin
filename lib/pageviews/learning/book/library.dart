import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/book/dic_book_category.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class Library extends StatefulWidget {
  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final TextEditingController _filter = TextEditingController();

  // List<Book> books = <Book>[];
  // List<Book> allList = <Book>[];
  // bool loading = false;
  //
  @override
  void dispose() {
    super.dispose();
    _filter.dispose();
  }

  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
  //     final LearningModel model = Provider.of<LearningModel>(context, listen: false);
  //     final List<Book> list = await model.books;
  //     print('list.length: ${list.length}');
  //     allList.clear();
  //     allList.addAll(list);
  //     list.clear();
  //     list.addAll(list);
  //     setState(() {
  //       loading = true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      // behavior: HitTestBehavior.opaque,
      // onPanDown: (_) {
      //   FocusScope.of(context).requestFocus(FocusNode());
      // },
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          showMenu: false,
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () => showSearch(
          //       context: context,
          //
          //       delegate: SearchPage<Book>(
          //         items: model.bookList,
          //         searchStyle: Styles.mainTS,
          //         searchLabel: 'Search people',
          //         suggestion: const Center(
          //           child: Text('Filter people by name, surname or age'),
          //         ),
          //         failure: const Center(
          //           child: Text('No person found :('),
          //         ),
          //         filter: (Book book) => <String>[
          //           book.instanceName,
          //           book.category.instanceName
          //           // person.surname,
          //           // person.age.toString(),
          //         ],
          //         builder: (Book book) => KzmCard(
          //           title: book?.instanceName,
          //           subtitle: book.category.instanceName,
          //           trailing: Icon(
          //             Icons.arrow_forward_ios,
          //             size: 16.w,
          //           ),
          //           selected: () => model.openBook(book),
          //         ),
          //         // barTheme:
          //       ),
          //     ),
          //     icon: Icon(Icons.search, color: Styles.appDarkBlueColor,),
          //   )
          // ],
        ),
        body: FutureBuilder<List<Book>>(
          future: model.books,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.data == null) {
              return const LoaderWidget();
            }
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
                  child: TextFormField(
                    controller: _filter,
                    onChanged: (String val) {
                      // search(val, allList);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Поиск',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _filter.text.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: () => clear(),
                              child: const Icon(Icons.clear),
                            ),
                      // border: InputBorder.none,
                      // filled: true,
                      fillColor: Colors.white54,
                      contentPadding: EdgeInsets.all(4.w),
                    ),
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: _filter.text.trim().isEmpty
                        ? ListView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            children: <Widget>[
                              pageTitle(title: S.current.library, fontSize: 15.w),
                              ...snapshot.data.map(
                                (Book e) {
                                  return Column(
                                    children: <Widget>[
                                      // if (snapshot.data.first.id == e.id) ,
                                      KzmCard(
                                        title: e?.instanceName,
                                        subtitle: e.category.instanceName,
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.w,
                                        ),
                                        selected: () => model.openBook(e),
                                      ),
                                    ],
                                  );
                                },
                              ).toList()
                            ],
                          )
                        : ListView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            children: <Widget>[
                              pageTitle(
                                title:
                                    '${S.current.library}: ${model.bookList.where((Book element) => element.instanceName.toUpperCase().contains(_filter.text.toUpperCase())).length}',
                                fontSize: 15.w,
                              ),
                              ...model.bookList.where((Book element) => element.instanceName.toUpperCase().contains(_filter.text.toUpperCase())).map(
                                (Book e) {
                                  return Column(
                                    children: <Widget>[
                                      // if (snapshot.data.first.id == e.id) ,
                                      KzmCard(
                                        title: e?.instanceName,
                                        subtitle: e.category.instanceName,
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.w,
                                        ),
                                        selected: () => model.openBook(e),
                                      ),
                                    ],
                                  );
                                },
                              ).toList()
                            ],
                          ),
                  ),
                ),
              ],
            );
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.search),
        //   tooltip: 'Search people',
        //   onPressed: () => ,
        // ),
      ),
    );
  }

  // void search(String val, List<Book> list) {
  //   print(val);
  //   print(list.length);
  //   books.clear();
  //   if (val.trim().isEmpty) {
  //     books = allList;
  //
  //     setState(() {});
  //     print(val);
  //     return;
  //   }
  //
  //   for (final Book element in list) {
  //     if (element.instanceName.contains(val)) {
  //       books.add(element);
  //     }
  //   }
  //
  //   setState(() {});
  // }

  void clear() {
    setState(() {
      _filter.clear();
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
