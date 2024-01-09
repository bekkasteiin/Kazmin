
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';

const String fName = 'lib/core/bpm_helpers/dialog/user_item.dart';
// ignore: must_be_immutable
class UserItemList<T extends AbstractBpmModel> extends StatelessWidget {
  T model;
  NotPersisitBprocActors e;
  Function() onTabDeleteItem;

  UserItemList(this.model, this.e, this.onTabDeleteItem);

  @override
  Widget build(BuildContext context) {
    String users = '';
    final String countUser = e.users.length > 1 ? ' [${e.users.length}]' : '';
    for (int i = 0; i < e.users.length; i++) {
      if (i != e.users.length - 1) {
        users = '$users${e.users[i].fullName}[${e.users[i].login}], ';
      } else {
        users = "$users${e.users[i].fullName}[${e.users[i].login}]";
      }
    }
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          title: Wrap(
            children: <Widget>[
              Text(
                e?.hrRole?.instanceName ?? '',
                style: Styles.mainTS,
              ),
              Text(countUser, style: Styles.mainTS)
            ],
          ),
          subtitle: Text(users),
          trailing: e.id == null
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
                  onPressed: onTabDeleteItem,)
              : null,
        ),
        Container(
          child: model.notPersisitBprocActors?.last?.hrRole?.id != e.hrRole.id ? Divider(height: 5.w, thickness: 1) : null,
        )
      ],
    );
  }
}
