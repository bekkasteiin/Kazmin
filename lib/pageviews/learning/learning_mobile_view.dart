import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/learning/learning_widget.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LearningPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearningModel()),
      ],
      child: Consumer<LearningModel>(
        builder: (BuildContext context, LearningModel counter, _) {
          return ScreenTypeLayout(
            mobile: LearningPage(),
            tablet: LearningPage(),
          );
        },
      ),
    );
  }
}

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double height2 = MediaQuery.of(context).size.height;
    final LearningModel model = Provider.of<LearningModel>(context);
    return Scaffold(
      // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      // appBar: AppBar(
      //   flexibleSpace: appBarBg(context),
      //   title: BrandLogo(),
      //   centerTitle: Platform.isIOS,
      // ),
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: LearningWidget(model: model),
    );
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/layout/main_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/learning/drawers.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'catalog_list.dart';
import 'enrollments_list.dart';

class LearningPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearningModel()),
      ],
      child: Consumer<LearningModel>(
        builder: (context, counter, _) {
          return ScreenTypeLayout(
            mobile: LearningPage(),
            tablet: LearningPage(),
          );
        },
      ),
    );
  }
}

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCalLearningModellback((timeStamp) {
      var model = Provider.of<>(context, listen: false);
      model.categories;
      model.enrollments;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height2 = MediaQuery.of(context).size.height;
    LearningModel model = Provider.of<LearningModel>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MenuDrawer(),
        endDrawer: MyLearningDrawer(
          model: model,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarCustomizer(
                  appBar: Container(
                    height: 100,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      title: BrandLogo(),
                      centerTitle: false,
                      actions: [
                        FilterButton(
                          model: model,
                        )
                      ],
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'Мое обучение'),
                          Tab(text: 'Каталог'),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height2 * 0.8,
                  child: TabBarView(
                    children: [
                      EnrollmentsList(
                        model: model,
                      ),
                      CatalogList(
                        model: model,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


*/
