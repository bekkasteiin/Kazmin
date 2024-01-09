
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/models/kpi/my_kpi.dart';
import 'package:kzm/pageviews/kpi/team/team_kpi_widget.dart';
import 'package:kzm/viewmodels/team_kpi_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class KpiTeamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamKpiModel()),
      ],
      child: Consumer<TeamKpiModel>(
        builder: (BuildContext context, TeamKpiModel counter, _) {
          return ScreenTypeLayout(
            mobile: KpiTeamPage(),
            tablet: KpiTeamPage(),
          );
        },
      ),
    );
  }
}

class KpiTeamPage extends StatefulWidget {
  @override
  _KpiTeamPageState createState() => _KpiTeamPageState();
}

class _KpiTeamPageState extends State<KpiTeamPage> {
  String chosenValue;

  @override
  void initState() {
    chosenValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TeamKpiModel model = Provider.of<TeamKpiModel>(context);
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(11.0),
              ),
              child: FutureProvider(
                create: (BuildContext context) => model.myTeamPlansList,
                initialData: null,
                child: Consumer<List<PerformancePlan>>(builder: (BuildContext context, List<PerformancePlan> list, Widget child) {
                  return list == null
                      ? const CupertinoActivityIndicator()
                      : DropdownButton<String>(
                          isExpanded: true,
                          value: chosenValue,
                          style: const TextStyle(color: Colors.grey),
                          items: list.map((PerformancePlan e) {
                            return DropdownMenuItem<String>(
                              value: '',
                              child: Text(e?.instanceName ?? ''),
                              onTap: () async {
                                model.lists = e;
                                await model.teamFilters;
                              },
                            );
                          }).toList(),
                          hint: const Text(
                            'Назначенные планы',
                            style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          icon: chosenValue != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      chosenValue = null;
                                    });
                                  },
                                )
                              : const Icon(Icons.arrow_drop_down),
                          onChanged: (String value) {
                            setState(() {
                              chosenValue = value;
                            });
                          },
                        );
                },),
              ),
            ),
            if (chosenValue == null) KpiTeamWidget(model: model) else KpiTeamFilterWidget(model: model),
          ],
        ),
      ),
    );
  }
}
