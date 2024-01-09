import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

class AbsenceListTeam extends StatefulWidget {
  final TabController controller;

  const AbsenceListTeam(this.controller, {Key key}) : super(key: key);

  @override
  _AbsenceListTeamState createState() => _AbsenceListTeamState();
}

class _AbsenceListTeamState extends State<AbsenceListTeam> {
  @override
  Widget build(BuildContext context) {
    final ChangeAbsenceModel changeAbsenceModel = Provider.of<ChangeAbsenceModel>(context, listen: false);
    final MyTeamModel temModel = Provider.of<MyTeamModel>(context, listen: false);
    final AbsenceForRecallModel absenceForRecallModel = Provider.of<AbsenceForRecallModel>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: temModel.getAbsences,
          builder: (BuildContext context, AsyncSnapshot<List<Absence>> snapshot) {
            if (snapshot.data == null) {
              return Container(
                margin: EdgeInsets.only(top: 20.w),
                child: const Center(
                  child: LoaderWidget(),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: snapshot.data.map((Absence e) {
                  return KzmCard(
                    title: e.type?.instanceName,
                    subtitle: e.instanceName,
                    trailing: absenceForRecallModel.checkAbsenceForRecall(e)
                        ? IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline_sharp,
                            ),
                            onPressed: () async {
                              absenceForRecallModel.child = temModel.child;
                              absenceForRecallModel.employee = temModel.employee;
                              absenceForRecallModel.selectedAbsence = e;
                              await absenceForRecallModel.getRequestDefaultValue().then((value) => setState(() {
                                    widget.controller.index = 1;
                                  }),);
                            },)
                        : changeAbsenceModel.checkChangeAbsenceDaysRequest(e)
                            ? IconButton(
                                icon: const Icon(Icons.add_circle),
                                onPressed: () async {
                                  changeAbsenceModel.child = temModel.child;
                                  changeAbsenceModel.selectedAbsence = e;
                                  await changeAbsenceModel.getRequestDefaultValue().then((value) => setState(() {
                                        widget.controller.index = 1;
                                      }),);
                                },
                              )
                            : null,
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   onPressed: () async {
      //     await temModel.getAbsenceTypesForManager;
      //     showModalBottomSheet(
      //         context: context,
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //         builder: (context) {
      //           return Column(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 8.0),
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(20),
      //                   child: Container(
      //                     height: 5,
      //                     width: 40,
      //                     color: Color(0x80808080),
      //                   ),
      //                 ),
      //               ),
      //               Container(
      //                 padding: EdgeInsets.symmetric(horizontal: 10),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(''),
      //                     Text("Выберите тип", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 20)),
      //                     IconButton(
      //                         icon: Icon(Icons.close),
      //                         onPressed: () {
      //                           Get.back();
      //                         })
      //                   ],
      //                 ),
      //                 width: MediaQuery.of(context).size.width,
      //               ),
      //               Container(
      //                 height: 1,
      //                 color: Color(0x1A1A1A1A),
      //               ),
      //               Container(
      //                   padding: EdgeInsets.all(8),
      //                   height: 200,
      //                   color: Colors.transparent,
      //                   //could change this to Color(0xFF737373),
      //                   alignment: Alignment.center,
      //                   child: ListView.separated(
      //                       itemCount: temModel.absenceTypesForManager.length,
      //                       separatorBuilder: (context, int) {
      //                         return Divider();
      //                       },
      //                       itemBuilder: (context, index) {
      //                         return GestureDetector(
      //                           child: Text(
      //                             temModel.absenceTypesForManager[index].instanceName,
      //                             style: TextStyle(fontSize: 18),
      //                           ),
      //                           onTap: () {
      //                             print(temModel.absenceTypesForManager[index].instanceName);
      //                             // model.createAbsence(model.absenceTypesForManager[index]);
      //                           },
      //                         );
      //                       })),
      //             ],
      //           );
      //         });
      //     // DicAbsenceType selected = await selector(
      //     //     entityName: "tsadv\$DicAbsenceType",
      //     //     fromMap: (json) => DicAbsenceType.fromMap(json),
      //     //     filter: CubaEntityFilter(
      //     //       filter: Filter(conditions: [
      //     //         FilterCondition(
      //     //           property: 'availableToManager',
      //     //           conditionOperator: Operators.equals,
      //     //           value: true,
      //     //         ),
      //     //         FilterCondition(
      //     //           group: "OR",
      //     //           conditions: [
      //     //             ConditionCondition(
      //     //               property: 'company.code',
      //     //               conditionOperator: Operators.equals,
      //     //               value: 'empty',
      //     //             ),
      //     //             ConditionCondition(
      //     //               property: 'company.id',
      //     //               conditionOperator: Operators.equals,
      //     //               value: model.company.id,
      //     //             )
      //     //           ],
      //     //         ),
      //     //       ]),
      //     //       view: '_local',
      //     //     ),
      //     //     isPopUp: true);
      //     // if (selected != null){
      //     //   model.createAbsence(selected);
      //     // }
      //   },
      // ),
    );
  }
}
