import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/menu_list.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/pageviews/hr_requests/request_hitories.dart';
import 'package:kzm/viewmodels/hr_requests.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HrRequestsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HrRequestModel model = Provider.of<HrRequestModel>(context);
    return ScreenTypeLayout(
      mobile: HrRequestView(model: model),
      tablet: HrRequestView(model: model),
    );
  }
}

class HrRequestView extends StatefulWidget {
  final HrRequestModel model;

  const HrRequestView({Key key, this.model}) : super(key: key);

  @override
  _HrRequestViewState createState() => _HrRequestViewState();
}

class _HrRequestViewState extends State<HrRequestView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: KzmAppBar(
          context: context,
          bottom: TabBar(
            // isScrollable: true,
            tabs: <Tab>[
              Tab(text: S.current.hr),
              Tab(text: S.current.historyRequests),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder<List<TileData>>(
              future: widget.model.tiles(
                userModel: Provider.of<UserViewModel>(context, listen: false),
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TileData>> snapshot) {
                if (snapshot.data == null) {
                  return const LoaderWidget();
                }
                return MenuList(list: snapshot.data);
              },
            ),
            const HrRequestHistories()
          ],
        ),
      ),
    );
  }
}
