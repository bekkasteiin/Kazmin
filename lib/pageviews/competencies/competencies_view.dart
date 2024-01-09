import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/competencies/competencies_data.dart';
import 'package:kzm/viewmodels/competencies_model.dart';
import 'package:provider/provider.dart';

class CompetenciesView extends StatelessWidget {
  const CompetenciesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: always_specify_types
        ChangeNotifierProvider(create: (_) => CompetenciesModel()),
      ],
      child: Consumer<CompetenciesModel>(
        builder: (BuildContext context, CompetenciesModel model, _) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: KzmAppBar(
                context: context,
                bottom: TabBar(
                  // isScrollable: true,
                  tabs: <Tab>[
                    Tab(text: S.current.open),
                    Tab(text: S.current.completedComptenceTab),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  CompetenciesData(model: model),
                  CompetenciesData(model: model, opened: false,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
