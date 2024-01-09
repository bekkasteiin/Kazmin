import 'package:flutter/material.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/models/kpi/assigned_goal.dart';
import 'package:kzm/core/models/kpi/my_kpi.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/pageviews/kpi/my_kpi_info.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class MyKpiModel extends BaseModel {
  List<AssignedPerformancePlan> plans;
  List<PerformancePlan> teamPlans;
  AssignedPerformancePlan selected;
  List<AssignedGoal> goals;

  Future<List<AssignedPerformancePlan>> get myPlans async {
    plans ??= await RestServices.getMyKpi();
    return plans;
  }

  Future<List<PerformancePlan>> get myTeamPlans async {
    teamPlans ??= await RestServices.getMyTeamKpi();
    return teamPlans;
  }

  Future<List<AssignedGoal>> get myGoals async {
    goals ??= await RestServices.getAssignedGoalByPlanId(planId: selected.id);
    return goals;
  }

  Future<void> selectItem() async {
    await myGoals;
    Navigator.push(
      navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) =>ChangeNotifierProvider.value(
          value: this,
          child: MyKpiInfo(),
        ),
      ),
    );
  }
}