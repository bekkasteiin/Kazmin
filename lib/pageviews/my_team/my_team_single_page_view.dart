import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/my_team/person_info/person_info.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class MyTeamSinglePageView extends StatefulWidget {
  @override
  _MyTeamSinglePagState createState() => _MyTeamSinglePagState();
}

class _MyTeamSinglePagState extends State<MyTeamSinglePageView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final MyTeamModel model = Provider.of<MyTeamModel>(context);
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: PersonInfoWidget(model: model),
      ),
    );
  }
}
