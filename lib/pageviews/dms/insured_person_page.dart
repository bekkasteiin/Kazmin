import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/dms/insured_person.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/dms/insured_person_form.dart';
import 'package:kzm/viewmodels/insured_person_model.dart';
import 'package:provider/provider.dart';

class InsuredPersonListPage extends StatefulWidget {
  final InsuredPersonModel model;

  const InsuredPersonListPage({Key key, this.model}) : super(key: key);

  @override
  _InsuredPersonListPageState createState() => _InsuredPersonListPageState();
}

class _InsuredPersonListPageState extends State<InsuredPersonListPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<InsuredPersonModel>(
        builder:
            (BuildContext context, InsuredPersonModel model, Widget child) {
          return FutureBuilder(
            future: model.dms,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.data == null)
                return const Center(child: LoaderWidget());
              final List<InsuredPerson> list =
                  snapshot.data as List<InsuredPerson>;
              list.sort((a, b) => b.attachDate.compareTo(a.attachDate));
              return SingleChildScrollView(
                child: Column(
                  children: list.map(
                    (InsuredPerson e) {
                      // ignore: prefer_function_declarations_over_variables
                      final Future<void> Function() onTap = () async {
                        await widget.model.myInsuredPerson(e.id).then(
                              (value) async => await widget.model
                                  .myTsadvInsuredPerson(value.id)
                                  .then(
                                    (value) async => await widget.model
                                        .getMyAssistance(
                                            value.assistance?.assistance?.id ??
                                                ''),
                                  ),
                            );
                        widget.model.setBusy(true);
                        widget.model.getListAssistance(e.insuranceContract.id);
                        widget.model.insuredPerson =
                            widget.model.getInsuredPerson;
                        await widget.model.myCompany;
                        await widget.model.myContracts;
                        await widget.model.members;
                        final PersonGroup personGroup =
                            await RestServices.getPersonGroup() as PersonGroup;
                        widget.model.assignDate =
                            personGroup.list[0].startDate;
                        widget.model.setBusy(false);
                        Get.to(
                          () =>
                              ChangeNotifierProvider<InsuredPersonModel>.value(
                            value: widget.model,
                            child: InsuredPersonForm(),
                          ),
                        );
                      };
                      final String dates =
                          '${formatShortly(e?.insuranceContract?.startDate)} - ${formatShortly(e.insuranceContract.expirationDate)}';
                      final String title =
                          '№${e.insuranceContract.contract}, ${formatShortly(e?.attachDate)}';
                      return KzmCard(
                        title: title,
                        subtitle: dates,
                        selected: onTap,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              e.totalAmount.toString() ?? '',
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              e.statusRequest.instanceName ?? '',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await widget.model.myCompany;
          await widget.model.getEnableContract;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            elevation: 0.6,
            isDismissible: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.w),
                topRight: Radius.circular(16.w),
              ),
            ),
            backgroundColor: Colors.white,
            builder: (_) => Container(
              color: Colors.transparent,
              height: size.height * (0.5),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    child: Container(
                      height: 5.h,
                      width: size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: Styles.appBrightBlueColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Styles.appWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      S.current.insuranceContract,
                      style: Styles.mainTS
                          .copyWith(color: Styles.appDarkGrayColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: widget.model.enableContract?.length ?? 0,
                        separatorBuilder: (BuildContext context, int int) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(8.w),
                            child: GestureDetector(
                              child: Text(
                                widget.model.enableContract[index]
                                        ['contractNumber'] ??
                                    '',
                                style: TextStyle(fontSize: 18.w),
                              ),
                              onTap: () async {
                                widget.model
                                    .getInsuredPersonDefaultValue(widget.model
                                        .enableContract[index]['contractId'])
                                    .then((bool value) {
                                  if (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ChangeNotifierProvider.value(
                                          value: widget.model,
                                          child: InsuredPersonForm(),
                                        ),
                                      ),
                                    ).then(
                                      (value) => setState(() async {
                                        await widget.model.dms;
                                      }),
                                    );
                                  }
                                });
                                widget.model.rebuild();
                                GlobalNavigator.pop();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
