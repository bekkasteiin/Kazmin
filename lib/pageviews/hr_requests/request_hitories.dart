import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/proc_instance_v.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/hr_requests.dart';
import 'package:provider/provider.dart';


const String fName = 'lib/pageviews/hr_requests/request_hitories.dart';

class HrRequestHistories extends StatelessWidget {
  const HrRequestHistories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // regisrt
      providers: [
        ChangeNotifierProvider<HrRequestModel>(
          create: (BuildContext context) => HrRequestModel(),
        ),
      ],
      child: const HrRequestHistoriesWidget(),
    );
  }
}

class HrRequestHistoriesWidget extends StatefulWidget {
  const HrRequestHistoriesWidget({Key key}) : super(key: key);

  @override
  State<HrRequestHistoriesWidget> createState() => _HrRequestHistoriesWidgetState();
}

class _HrRequestHistoriesWidgetState extends State<HrRequestHistoriesWidget> {
  // bool loading = true;
  //
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await Provider.of<HrRequestModel>(context, listen: false).getHistories();
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final HrRequestModel model = Provider.of<HrRequestModel>(context);
    final HrRequestModel future = Provider.of<HrRequestModel>(context, listen: false);
    return FutureBuilder<List<ProcInstanceV>>(
      future: future.getHistories(),
      builder: (BuildContext context, AsyncSnapshot<List<ProcInstanceV>> snapshot) {
        final List<ProcInstanceV> list = snapshot.data;
        if (snapshot.data == null) {
          return const Center(child: LoaderWidget());
        } else if (snapshot.hasError) {
          return Center(
            child: SizedBox(
              child: KzmButton(
                child: const Text('Ошибка, попробуйте снова'),
                onPressed: () async {
                  await model.getHistories();
                },
              ),
            ),
          );
        }
       return (list.isEmpty)
                ? KZMNoData()
                : RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () async {
                      await model.getHistories(update: true);
                      setState(() {});
                    },
                    child: ListView.builder(
                      itemCount: list.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return KzmCard(
                          title: list[index].instanceName,
                          subtitle: list[index].status.instanceName,
                          statusColor: getColorByStatusCode(list[index].status.code),
                          selected: () async {
                            await model.openRequestByID(
                              name: list[index].procInstanceVEntityName,
                              id: list[index].entityId,
                              context: context,
                            );
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
                      },
                    ),
                  );
      },
    );
  }
}
