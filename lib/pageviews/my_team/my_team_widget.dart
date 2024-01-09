
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/my_team_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/my_team/my_team_widget.dart';

class MyTeamWidget extends StatefulWidget {
  final MyTeamModel model;

  const MyTeamWidget({Key key, this.model}) : super(key: key);

  @override
  _MyTeamWidgetState createState() => _MyTeamWidgetState();
}

class _MyTeamWidgetState extends State<MyTeamWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (BuildContext context) => widget.model.getChildren,
      initialData: null,
      child: Scaffold(
        body: Consumer<List<MyTeamNew>>(
          builder: (BuildContext context, List<MyTeamNew> list, Widget child) {
            return list == null
                ? const Center(child: LoaderWidget())
                : list.isEmpty
                    ? Center(child: noData)
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.w),
                          child: Column(
                            children: list.map((MyTeamNew e) {
                              return _buildTiles(e);
                            }).toList(),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }

  Widget _buildTiles(
    MyTeamNew root, {
    int level = 0,
  }) {
    // log('-->> $fName, _buildTiles ->> root: ${root.toJson()}');
    int selected = 0;
    final ThemeData theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    // log('-->> $fName, _buildTiles -->> root: ${root.toJson()}');

    if (!root.hasChild) {
      return Container(
        margin: EdgeInsets.fromLTRB((level * 12).toDouble().w, 0, 0, 0),
        color: Colors.grey[level * 100],
        child: KzmCard(
          title: root.fullName,
          selected: () => widget.model.onSelected(root: root, context: context),
        ),
      );
    }
    selected = selected + 1;

    bool isExpanded = false;
    if (root.children == null || root.children.isEmpty) {
      return Card(
        color: Colors.grey[level * 100],
        margin: EdgeInsets.fromLTRB((level * 12).toDouble().w, 0, 10.w, 10.w),
        child: Theme(
          data: theme,
          child: ExpansionTile(
            onExpansionChanged: (bool expanding) async {
              isExpanded = expanding;
              root.children = await RestServices.getChildrenForTeamService(parentPositionGroupId: root.positionGroupId);
              isExpanded = false;
              selected = selected + 1;
              setState(() {});
            },
            initiallyExpanded: isExpanded,
            key: PageStorageKey<MyTeamNew>(root),
            title: InkWell(
                onTap: () => widget.model.onSelected(root: root),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Text(
                    root.fullName,
                    style: Styles.mainTS,
                    textAlign: TextAlign.start,
                  ),
                ),), // do something with level
          ),
        ),
      );
    }

    return Card(
      color: Colors.grey[level * 100],
      margin: EdgeInsets.fromLTRB((level * 12).toDouble(), 00, 10, 10),
      child: Theme(
        data: theme,
        child: ExpansionTile(
          key: PageStorageKey<MyTeamNew>(root),
          // initiallyExpanded: isExpanded,
          title: InkWell(
              onTap: () => widget.model.onSelected(root: root),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text(
                  root.fullName,
                  style: Styles.mainTS,
                  textAlign: TextAlign.start,
                ),
              ),), // do something with level
          children: root.children.map((MyTeamNew child) => _buildTiles(child, level: level + 1)).toList(),
        ),
      ),
    );
  }
}
