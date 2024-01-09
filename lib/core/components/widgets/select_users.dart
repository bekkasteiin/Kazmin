import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/combo_input.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/components/widgets/user_tile.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/selected_users.dart';

const String fName = 'lib/core/components/widgets/select_users.dart';

class KzmSelectUsers extends StatefulWidget {
  final List<KzmCommonItem> roles;
  final List<KzmCommonItem> users;
  final Future<List<KzmSelectedUsers>> initialUsers;
  final Function() onPressedOK;

  final Function({@required List<KzmSelectedUsers> val}) onChangeSelectedUsers;

  const KzmSelectUsers({
    @required this.roles,
    @required this.users,
    @required this.initialUsers,
    @required this.onChangeSelectedUsers,
    @required this.onPressedOK,
  });

  @override
  _KzmSelectUsersState createState() => _KzmSelectUsersState();
}

class _KzmSelectUsersState extends State<KzmSelectUsers> {
  List<KzmSelectedUsers> _selectedUsers;
  KzmCommonItem _currentRole;
  KzmCommonItem _currentUser;

  Future<bool> get _isButtonActive async {
    if (widget.roles == null) return false;
    if ((widget.roles).isEmpty) return false;
    if (widget.users == null) return false;
    if ((widget.users).isEmpty) return false;
    if (await widget.initialUsers == null) return false;
    if ((await widget.initialUsers).isEmpty) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 1.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          KzmComboInput(
            isLoading: false,
            caption: 'Роль'.tr,
            items: <KzmCommonItem>[...widget.roles],
            onChanged: ({KzmCommonItem val}) {
              setState(() {
                _currentRole = val;
              });
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          KzmComboInput(
            isLoading: false,
            isActive: _currentRole != null,
            caption: 'Пользователь'.tr,
            items: <KzmCommonItem>[...widget.users],
            onChanged: ({KzmCommonItem val}) {
              setState(() {
                _currentUser = val;
              });
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          FutureBuilder<bool>(
            future: _isButtonActive,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return GestureDetector(
                onTap: (snapshot.data == null)
                    ? null
                    : () {
                        if ((_currentRole != null) && (_currentUser != null) && (_selectedUsers != null)) {
                          final KzmSelectedUsers _tmp = KzmSelectedUsers(
                            user: _currentUser,
                            role: _currentRole,
                            canBeDeleted: true,
                          );
                          if (!_selectedUsers.contains(_tmp)) {
                            setState(() {
                              _selectedUsers.insert(0, _tmp);
                              widget.onChangeSelectedUsers(val: _selectedUsers);
                            });
                          }
                        }
                      },
                child: (snapshot.data == null) || (_currentUser == null) ? KzmIcons.downArrowInactive : KzmIcons.downArrow,
              );
            },
          ),
          SizedBox(height: Styles.appQuadMargin),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Styles.appBorderColor),
                borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
              ),
              height: Styles.appSelectUsersHeight,
              child: FutureBuilder<List<KzmSelectedUsers>>(
                future: widget.initialUsers, // async work
                builder: (BuildContext context, AsyncSnapshot<List<KzmSelectedUsers>> snapshot) {
                  if (snapshot.data != null) {
                    _selectedUsers ??= snapshot.data;
                    widget.onChangeSelectedUsers(val: _selectedUsers);
                    return Padding(
                      padding: paddingHorizontal(top: Styles.appDoubleMargin, bottom: Styles.appDoubleMargin),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            if (_selectedUsers.isNotEmpty)
                              ..._selectedUsers.map(
                                (KzmSelectedUsers e) => KzmUserTile(
                                  data: e,
                                  onDelete: () => setState(() {
                                    _selectedUsers.remove(e);
                                  }),
                                ),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Icon>[
                                  KzmIcons.personGray,
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const KzmShimmer();
                  }
                },
              ),
            ),
          ),
          SizedBox(height: Styles.appQuadMargin),
          FutureBuilder<bool>(
            future: _isButtonActive,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return KzmOutlinedBlueButton(
                caption: 'ОК'.tr,
                enabled: snapshot.data ?? false,
                onPressed: widget.onPressedOK,
              );
            },
          ),
        ],
      ),
    );
  }
}
