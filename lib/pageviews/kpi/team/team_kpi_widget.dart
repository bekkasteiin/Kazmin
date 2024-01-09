import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/models/kpi/my_kpi.dart';
import 'package:kzm/viewmodels/team_kpi_model.dart';
import 'package:provider/provider.dart';

class KpiTeamWidget extends StatelessWidget {
  final TeamKpiModel model;

  const KpiTeamWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (BuildContext context) => model.myTeamPlans,
      initialData: null,
      child: Consumer<List<AssignedPerformancePlan>>(
        builder: (BuildContext context, List<AssignedPerformancePlan> list, Widget child) {
          return list == null
              ? const CupertinoActivityIndicator()
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: list.map(
                        (AssignedPerformancePlan e) {
                          return Container(
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  e?.performancePlan?.instanceName ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(e.performancePlan.instanceName),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: (){
                                  model.selected = e;
                                  model.selectItem();

                                },
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class KpiTeamFilterWidget extends StatelessWidget {
  final TeamKpiModel model;

  const KpiTeamFilterWidget({Key key, this.model}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (BuildContext context) => model.teamFilters,
      initialData: null,
      child: Consumer<List<AssignedPerformancePlan>>(
        builder: (BuildContext context, List<AssignedPerformancePlan> list, Widget child) {
          return list == null
              ? const CupertinoActivityIndicator()
              : SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                children:
                list.map(
                      (AssignedPerformancePlan e)=>
                      Card(
                        child: ListTile(
                          title: Text(
                            e?.performancePlan?.instanceName ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                          subtitle: Text(e?.performancePlan?.instanceName),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            model.selected = e;
                            model.selectItem();
                          },
                        ),
                      ),
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
