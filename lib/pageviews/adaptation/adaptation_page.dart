import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/adaptation/compulsory_courses.dart';
import 'package:kzm/pageviews/adaptation/introductory_documents.dart';
import 'package:kzm/pageviews/adaptation/my_tasks.dart';
import 'package:kzm/pageviews/adaptation/widgets/adaptation_period_widget.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

class NewEmployeesPage extends StatelessWidget {
  const NewEmployeesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AdaptationViewModel(),
        ),
      ],
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          centerTitle: true,
        ),
        body: Consumer<AdaptationViewModel>(
          builder: (BuildContext context, AdaptationViewModel model, _) {
            return Column(
              children: [
                const AdaptationPeriodWidget(),
                if (model.currentAdaptation == null)
                  const SizedBox()
                else
                  MenuList(
                    list: [
                      TileData(
                        name: S.current.newEmployeesPageMyTasks,
                        url: KzmPages.myTasks,
                        svgIcon: SvgIconData.sendMessage,
                        showOnMainScreen: null,
                        onTap: () {
                          Get.to(() => ChangeNotifierProvider.value(
                                value: model,
                                child: const MyTasks(),
                              ),);
                        },
                      ),
                      TileData(
                          name: S.current.newEmployeesIntroductoryDocuments,
                          url: KzmPages.introductoryDocuments,
                          svgIcon: SvgIconData.sendMessage,
                          showOnMainScreen: null,
                          onTap: () {
                            Get.to(() => ChangeNotifierProvider.value(
                                  value: model,
                                  child: const IntroductaryDocuments(),
                                ),);
                          },),
                      TileData(
                        name: S.current.newEmployeesMyAdaptationTeam,
                        url: KzmPages.myAdaptationTeam,
                        svgIcon: SvgIconData.sendMessage,
                        showOnMainScreen: null,
                      ),
                      TileData(
                          name: S.current.newEmployeesCompulsoryCourses,
                          url: KzmPages.compulsoryCourses,
                          svgIcon: SvgIconData.sendMessage,
                          showOnMainScreen: null,
                          onTap: () {
                            Get.to(() => ChangeNotifierProvider.value(
                                  value: model,
                                  child: const CompulsoryCourses(),
                                ),);
                          },),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
