import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/sur_change_request.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/bpm_requests/material_assistans_model.dart';
import 'package:provider/provider.dart';

class MyMaterialRequests extends StatelessWidget {
  const MyMaterialRequests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // regisrt
      providers: [
        ChangeNotifierProvider<MaterialAssistantViewModel>(
          create: (BuildContext context) => MaterialAssistantViewModel(),
        ),
      ],
      child: Scaffold(
        // endDrawer:
        //     KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
        appBar: KzmAppBar(context: context),
        body: SingleChildScrollView(
          child: Consumer<MaterialAssistantViewModel>(
            builder: (BuildContext context, MaterialAssistantViewModel materialModel, _) {
              return Column(
                children: [
                  pageTitle(title: S.current.materialAssistanceMyRequests),
                  FutureBuilder<List<SurChargeRequest>>(
                    future: materialModel.getRequests(),
                    builder: (BuildContext context, AsyncSnapshot<List<SurChargeRequest>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else {
                        return MenuList(
                          list: snapshot.data
                              .map(
                                (SurChargeRequest e) => TileData(
                                  name: '${S.current.request} ${e.requestNumber}',
                                  url: '',
                                  svgIcon: null,
                                  showOnMainScreen: null,
                                  onTap: () => materialModel.openRequestById(e.id),
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
