import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/models/kpi/assigned_goal.dart';
import 'package:kzm/core/models/kpi/my_kpi.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/kpi/team/team_kpi_info.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class TeamKpiModel extends BaseModel {
  List<AssignedPerformancePlan> teamPlans, teamFilter;
  AssignedPerformancePlan selected;
  List<AssignedGoal> goals;
  List<PerformancePlan> teamListPlans;
  PerformancePlan lists;


  Future<List<AssignedPerformancePlan>> get myTeamPlans async {
    teamPlans ??= await RestServices.getMyTeamKpi();
    return teamPlans;
  }

  Future<List<PerformancePlan>> get myTeamPlansList async {
    teamListPlans ??= await RestServices.getMyTeamKpiList();
    return teamListPlans;
  }

  Future<List<AssignedPerformancePlan>> get teamFilters async {
    teamFilter = await RestServices.getMyTeamKpiListFilter(performanceId: lists.id);
    return teamFilter;
  }

  Future<void> selectItem() async {
    if(selected.id!=null){
      await myTeamPlans;
      goals = await RestServices.getAssignedGoalByPlanId(planId: selected.id);
      Navigator.push(
        navigatorKey.currentContext,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: this,
            child: TeamKpiInfo(),),
        ),
      );
    }
  }
}