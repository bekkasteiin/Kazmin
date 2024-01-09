import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/collective_payment/collective_model.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/collective_payment_model.dart';
import 'package:kzm/viewmodels/bpm_requests/material_assistans_model.dart';
import 'package:provider/provider.dart';

class MaterialAssistancePage extends StatefulWidget {
  const MaterialAssistancePage({Key key}) : super(key: key);

  @override
  State<MaterialAssistancePage> createState() => _MaterialAssistancePageState();
}

class _MaterialAssistancePageState extends State<MaterialAssistancePage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final CollectivePaymentModel future = Provider.of<CollectivePaymentModel>(context, listen: false);
    return DefaultTabController(

      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => MaterialAssistantViewModel(),),
        ],
        child: Scaffold(
          appBar: KzmAppBar(
            context: context,
            bottom: TabBar(
              onTap: (int int){
                setState(() {
                  page = int;
                });
              },
              controller: _tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              tabs: <Tab>[
                Tab(text: S.current.materialAssistance),
                Tab(text: S.current.collectivePayment),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Consumer<MaterialAssistantViewModel>(
                builder: (BuildContext context,
                    MaterialAssistantViewModel model, _) {
                  return Column(
                    children: [
                      pageTitle(title: S.current.materialAssistance),
                      MenuList(
                        list: [
                          TileData(
                            name: S.current.materialAssistanceCreateRequest,
                            url: null,
                            svgIcon: SvgIconData.trainingCatalogue,
                            showOnMainScreen: null,
                            onTap: () => model.getRequestDefaultValue(),
                          ),
                          TileData(
                            name: S.current.materialAssistanceMyRequests,
                            url: KzmPages.myMaterialRequest,
                            svgIcon: SvgIconData.myCourses,
                            showOnMainScreen: null,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Consumer<CollectivePaymentModel>(
                  builder: (BuildContext context, CollectivePaymentModel model,
                      Widget child) {
                    return Column(
                      children: [
                        FutureBuilder<List<CollAgreementPaymentRequest>>(
                            future: model.getRequests(),
                            builder: (BuildContext context, AsyncSnapshot<List<CollAgreementPaymentRequest>> snapshot){
                              if(snapshot.hasData){
                                List<CollAgreementPaymentRequest> list = snapshot.data;
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: list.length,
                                      itemBuilder: (_, int index){
                                        return KzmCard(
                                          title: list[index].paymentType.instanceName,
                                          subtitle: list[index].status.instanceName,
                                          statusColor: getColorByStatusCode(list[index].status.code),
                                          selected: () async {
                                              await model.openRequestById(list[index].id);
                                          },
                                          trailing: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                list[index].requestNumber.toString(),
                                                style: Styles.mainTxtTheme.subtitle1,
                                              ),
                                              Text(
                                                formatShortly(list[index].requestDate),
                                                style: Styles.mainTxtTheme.subtitle1,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                              }else{
                                return SizedBox();
                              }
                            }),
                      ],
                    );
                  }),
            ],
          ),
          floatingActionButton: page!=0
          ? FloatingActionButton(
            backgroundColor: Styles.appPrimaryColor,
            onPressed: () async {
               await future.getRequestDefaultValue().then((value) => setState((){}));
            },
            child: const Icon(Icons.add),
          ) : SizedBox(),
        ),
      ),
    );
  }
}
