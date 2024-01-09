import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/cached_image.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person/person.dart';
// import 'package:kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/adaptation_view_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/adaptation/adaptation_team.dart';

class MyAdaptationTeam extends StatelessWidget {
  const MyAdaptationTeam({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AdaptationViewModel(),
        ),
      ],
      child: Scaffold(
        appBar: KzmAppBar(context: context, centerTitle: true),
        body: Consumer<AdaptationViewModel>(
          builder: (BuildContext context, AdaptationViewModel model, _) {
            return FutureBuilder<List<PersonGroup>>(
              future: model.getMyAdaptationTeam,
              builder: (BuildContext context, AsyncSnapshot<List<PersonGroup>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return ListView(
                    children: [
                      pageTitle(title: S.current.newEmployeesMyAdaptationTeam),
                      ...snapshot.data.where((PersonGroup element) => true).map((PersonGroup e) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: CachedImage(
                                  Kinfolk.getFileUrl(e?.person?.image?.id ?? '') as String,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      e.fullName,
                                      style: Styles.mainTS,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      // e.currentAssignment?.positionGroup?.currentPosition?.positionNameLang1 ?? '',
                                      e.currentAssignment?.positionGroup?.currentPosition?.instanceName ?? '',
                                      maxLines: 2,
                                      style: Styles.advertsText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
