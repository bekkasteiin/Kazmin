import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/my_team/my_team_widget.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTeamPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyTeamModel()),
      ],
      child: Consumer<MyTeamModel>(
        builder: (BuildContext context, MyTeamModel counter, _) {
          return ScreenTypeLayout(
            mobile: MyTeamPage(),
            tablet: MyTeamPage(),
          );
        },
      ),
    );
  }
}

class MyTeamPage extends StatefulWidget {
  @override
  _MyTeamPageState createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double height2 = MediaQuery.of(context).size.height;
    final MyTeamModel model = Provider.of<MyTeamModel>(context);
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
    //     // appBar: AppBar(
    //     //   flexibleSpace: appBarBg(context),
    //     //   title: BrandLogo(),
    //     // ),
    //     endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
    //     appBar: KzmAppBar(context: context),
    //     body: SingleChildScrollView(
    //       child: Container(
    //         height: height2 * 0.87,
    //         padding: EdgeInsets.all(5),
    //         child: MyTeamWidget(
    //           model: model,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).getTiles()),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Container(
          height: height2 * 0.87,
          padding: const EdgeInsets.all(5),
          child: MyTeamWidget(
            model: model,
          ),
        ),
      ),
    );
  }
}
