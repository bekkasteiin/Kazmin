import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/adaptation/adaptation_plan.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/adaptation/tasks_page.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdaptationViewModel model = Provider.of<AdaptationViewModel>(context, listen: false);
    return Scaffold(
      appBar: KzmAppBar(context: context, centerTitle: true),
      body: Column(
        children: [
          pageTitle(title: S.current.newEmployeesAdaptationTasks),
          FutureBuilder<List<AdaptationTask>>(
            future: model.getTasks,
            builder: (_, AsyncSnapshot<List<AdaptationTask>> snapshot) {
              if (snapshot.data == null) {
                return const CupertinoActivityIndicator();
              }
              return MenuList(
                list: snapshot.data
                    .where(
                      (AdaptationTask element) => element.achievedResultsLang1 == null || element.achievedResultsLang1?.isEmpty == true,
                    )
                    .map(
                      (AdaptationTask e) => TileData(
                        name: e.assignmentLang1 + e.achievedResultsLang1.toString(),
                        url: '',
                        svgIcon: null,
                        showOnMainScreen: null,
                        onTap: () {
                          Get.to(AdaptationTaskView(
                            currentTask: e,
                            shouldShowAchievements: false,
                          ),);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
          pageTitle(title: S.current.done),
          FutureBuilder<List<AdaptationTask>>(
            future: model.getTasks,
            builder: (_, AsyncSnapshot<List<AdaptationTask>> snapshot) {
              if (snapshot.data == null) {
                return const CupertinoActivityIndicator();
              }
              return MenuList(
                list: snapshot.data
                    .where(
                      (AdaptationTask element) => element.achievedResultsLang1 != null && element.achievedResultsLang1?.isNotEmpty == true,
                    )
                    .map(
                      (AdaptationTask e) => TileData(
                        name: e.assignmentLang1,
                        url: '',
                        svgIcon: null,
                        showOnMainScreen: null,
                        onTap: () {
                          Get.to(AdaptationTaskView(
                            currentTask: e,
                            shouldShowAchievements: true,
                          ),);
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
