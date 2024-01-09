
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/kpi/my_kpi_widget.dart';
import 'package:kzm/viewmodels/my_kpi_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyKpiPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyKpiModel()),
      ],
      child: Consumer<MyKpiModel>(
        builder: (BuildContext context, MyKpiModel counter, _) {
          return ScreenTypeLayout(
            mobile: MyKpiPage(),
            tablet: MyKpiPage(),
          );
        },
      ),
    );
  }
}

class MyKpiPage extends StatefulWidget {
  @override
  _MyKpiPageState createState() => _MyKpiPageState();
}

class _MyKpiPageState extends State<MyKpiPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final MyKpiModel model = Provider.of<MyKpiModel>(context);
    return Scaffold(
      // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      // appBar: AppBar(
      //   flexibleSpace: appBarBg(context),
      //   title: BrandLogo(),
      //   centerTitle: Platform.isIOS,
      // ),
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: MyKpiWidget(
          model: model,
        ),
      ),
    );
  }
}
