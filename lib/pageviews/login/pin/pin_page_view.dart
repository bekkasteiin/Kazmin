import 'package:flutter/material.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

import 'pin_mobile_view.dart';
import 'pin_vertify.dart';

class PinPage extends StatelessWidget {
  final bool toCreate;

  PinPage(this.toCreate);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
        child: Consumer<UserViewModel>(builder: (context, counter, _) {
          return toCreate ? PinMobileCreate() : PinMobileView();
        }));
  }
}
