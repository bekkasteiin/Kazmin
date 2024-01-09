
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/kpi/assigned_goal.dart';
import 'package:kzm/viewmodels/my_kpi_model.dart';
import 'package:provider/provider.dart';

class MyKpiInfo extends StatefulWidget {
  @override
  _MyKpiInfoState createState() => _MyKpiInfoState();
}

class _MyKpiInfoState extends State<MyKpiInfo> {
  @override
  Widget build(BuildContext context) {
    final MyKpiModel model = Provider.of<MyKpiModel>(context);
    const EdgeInsets insets = EdgeInsets.symmetric(horizontal: 8);
    return Scaffold(
      // appBar: AppBar(
      //   leading: backButton(),
      //   flexibleSpace: appBarBg(context),
      //   title: Text("Форма постановки KPI (${model.selected?.performancePlan?.instanceName})",),
      //   centerTitle: Platform.isIOS,
      // ),
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(
        context: context,
        title: Text('Форма постановки KPI (${model.selected?.performancePlan?.instanceName})'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: insets,
          child: Column(
            children: [
              kpiPanel(model: model),
              goalsPanel(model: model),
              // model.processInstanceData != null
              //     ? bpmTask(model: model)
              //     :
              buttonPanelStartBpm(model: model),
            ],
          ),
        ),
      ),
    );
  }

  Widget kpiPanel({MyKpiModel model}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            child: ExpansionTile(
                title: const Text(
                  'Информация о сотруднике',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  ListTile(
                    title: const Text('Сотрудник'),
                    subtitle: Text(model?.selected?.assignedPerson?.instanceName),
                  ),
                  ListTile(
                    title: const Text('Должность'),
                    subtitle: Text(model?.selected?.assignedPerson?.currentAssignment?.jobGroup?.instanceName ?? ''),
                  ),
                  ListTile(
                    title: const Text('Подразделение'),
                    subtitle: Text(
                        model?.selected?.assignedPerson?.assignments?.first?.organizationGroup?.instanceName ?? '',),
                  ),
                  ListTile(
                    title: const Text('Статус'),
                    subtitle: Text(model?.selected?.status?.instanceName ?? ''),
                  ),
                  ListTile(
                    title: const Text('Дата с'),
                    subtitle: Text(formatShortly(model?.selected?.performancePlan?.startDate)),
                  ),
                  ListTile(
                    title: const Text('Дата по'),
                    subtitle: Text(formatShortly(model?.selected?.performancePlan?.endDate)),
                  ),
                  ListTile(
                    title: const Text('Дата приема на работу'),
                    subtitle: Text('${model?.selected?.assignedPerson?.person?.hireDate}'),
                  ),
                ],),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10,),
        //   child: Card(
        //     child: Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Column(
        //             children: [
        //               Text("1", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: model.selected.stepStageStatus == "DRAFT" ? Color(0xff005487) : Colors.grey),),
        //               Text("Черновик", style: TextStyle(fontWeight: FontWeight.w800))
        //             ],
        //           ),
        //           Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
        //           Column(
        //             children: [
        //               Text("2", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: model.selected.stepStageStatus != "DRAFT" ? Color(0xff005487) : Colors.grey),),
        //               Text("Завершено", style: TextStyle(fontWeight: FontWeight.w800))
        //             ],
        //           ),
        //           Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        //           Column(
        //             children: [
        //               Text("3", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: model.selected.stepStageStatus != "DRAFT" ? Color(0xff005487) : Colors.grey),),
        //               Text("Оценка", style: TextStyle(fontWeight: FontWeight.w800))
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget buttonPanelStartBpm({MyKpiModel model}) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              disabledColor: Colors.black12,
              onPressed:
                  // model.busy
                  //     ? null
                  //     :
                  () {
                Get.back();
              },
              child: const Text('Отменить'),
            ),
            MaterialButton(
              color: Colors.green[400],
              disabledColor: Colors.black12,
              onPressed: () {},
              // model.busy
              //     ? null
              //     : () async {
              //   // await model.saveAbsenceRequest(files);
              //   if (model.success) {
              //     model.notPersisitBprocActors != null ?
              //     await dialog(context, model) : CupertinoActivityIndicator();
              //   }
              // },
              child: const Text('Запустить процесс'),
            ),
          ],
        ),);
  }

  Widget goalsPanel({@required MyKpiModel model}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Форма оценки',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
                children: model.goals.map((AssignedGoal e) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Категрия'),
                      subtitle: Text(e?.category?.instanceName),
                    ),
                    ListTile(
                      title: const Text('Цель'),
                      subtitle: Text(e?.goalString),
                    ),
                    ListTile(
                      title: const Text('Описания'),
                      subtitle: Text(e?.goal?.successCriteria ?? ''),
                    ),
                    ListTile(
                      title: const Text('Вес цели, %'),
                      subtitle: Text('${e?.weight}'),
                    ),
                  ],
                ),
              );
            }).toList(),),
          ],
        ),
      ),
    );
  }
}
