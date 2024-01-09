import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/bpm_helpers/dialog/user_item.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const String fName = 'lib/core/bpm_helpers/dialog/start_bpm_process.dart';

class StartBpmProcess<T extends AbstractBpmModel> extends StatefulWidget {
  final T model;
  final bool disableSaveButton;
  final bool hideCancel;

  const StartBpmProcess(this.model,
      {this.disableSaveButton = false, this.hideCancel = false});

  @override
  _StartBpmProcessState createState() => _StartBpmProcessState();
}

class _StartBpmProcessState extends State<StartBpmProcess> {
  User user;
  HrRole hrRole = HrRole();
  String bprocUserTaskCode;
  Link rolesLink;

  @override
  Widget build(BuildContext context) {
    return CancelAndSaveButtons(
      saveX: 5,
      showSaveRequestButton: widget.model.showSaveRequestButton,
      showGetReportButton: widget.model.showGetReportButton,
      onTapSaveRequest: widget.model.saveRequest,
      onTapGetReport: widget.model.getReport,
      cancelText: S.current.close,
      disabled:
          (widget.model.request?.id != null && widget.model.tasks != null) ||
              widget.disableSaveButton,
      saveText: S.current.outcomeStart,
      onTapCancel: widget.model.busy
          ? null
          : () {
              Get.back();
            },
      onTapSave: () async {
        await widget.model.getRolesDefinerAndNotRersisitActors();
        if (widget.model.notPersisitBprocActors != null) {
          await dialog();
        }
      },
      hideCancel: widget.hideCancel,
    );
  }

  Future<void> dialog() async {
    var size = MediaQuery.of(context).size;
    // bool isPop = true;
    return showBarModalBottomSheet<bool>(
      // bool result = await  showBarModalBottomSheet<bool>(
      barrierColor: Styles.appPrimaryColor.withOpacity(0.4),
      // isDismissible: false,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              final bool isAdd = widget.model.bpmRolesDefiner.links
                  .where((Link element) => element.isAddableApprover)
                  .toList()
                  .isNotEmpty;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.current.outcomeSendForApproval,
                      style: Styles.mainTxtTheme.headline6.copyWith(
                          height: 2,
                          color: Styles.appDarkBlackColor.withOpacity(0.8)),
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        radius: Radius.circular(10.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:
                                widget.model.notPersisitBprocActors != null
                                    ? widget.model.notPersisitBprocActors
                                        .where((NotPersisitBprocActors e) =>
                                            (e?.users?.length ?? 0) > 0)
                                        .map((NotPersisitBprocActors e) {
                                        return UserItemList(
                                          widget.model,
                                          e,
                                          () => setState(() {
                                            widget.model.notPersisitBprocActors
                                                .remove(e);
                                          }),
                                        );
                                      }).toList()
                                    : <Widget>[],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      S.current.outcomeAddIfNecessary,
                      style: Styles.questionText,
                    ),
                    Container(
                      child: isAdd
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.0.w,
                                horizontal: 8.w,
                              ),
                              margin: EdgeInsets.only(top: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Column(
                                children: <Widget>[
                                  FieldBones(
                                    isRequired: true,
                                    placeholder: 'Роль',
                                    hintText: '',
                                    textValue: hrRole?.instanceName,
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    selector: () => showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      elevation: 0.6,
                                      isDismissible: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.w),
                                          topRight: Radius.circular(16.w),
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      builder: (_) => Container(
                                        color: Colors.transparent,
                                        height: size.height * 0.4,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.w),
                                              child: Container(
                                                height: 5.h,
                                                width: size.width / 5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w),
                                                  color: Styles
                                                      .appBrightBlueColor
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                color: Styles.appWhiteColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                '',
                                                style: Styles.mainTS.copyWith(
                                                    color: Styles
                                                        .appDarkGrayColor),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Scrollbar(
                                                child: ListView.separated(
                                                  itemCount: widget.model
                                                      .bpmRolesDefiner.links
                                                      .where((Link element) =>
                                                          element
                                                              .isAddableApprover)
                                                      .toList()
                                                      .length,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int int) {
                                                    return const Divider();
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final List<Link> links = widget
                                                        .model
                                                        .bpmRolesDefiner
                                                        .links
                                                        .where((Link element) =>
                                                            element
                                                                .isAddableApprover)
                                                        .toList();
                                                    bool current = false;
                                                    if (hrRole != null) {
                                                      current = links[index]
                                                              .hrRole
                                                              .id ==
                                                          hrRole.id;
                                                    }
                                                    return Container(
                                                      color:
                                                          Styles.appWhiteColor,
                                                      child: InkWell(
                                                        child: SelectItem(
                                                          links[index]
                                                              .hrRole
                                                              .instanceName,
                                                          current,
                                                        ),
                                                        onTap: () =>
                                                            setState(() {
                                                          if (!current) {
                                                            hrRole =
                                                                links[index]
                                                                    .hrRole;
                                                            bprocUserTaskCode =
                                                                links[index]
                                                                    .bprocUserTaskCode;
                                                            rolesLink =
                                                                links[index];
                                                            widget.model
                                                                .rebuild();
                                                            setState(() {});
                                                            GlobalNavigator
                                                                .pop();
                                                          }
                                                        }),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).then((value) => setState(() {})),
                                  ),
                                  FieldBones(
                                    isRequired: true,
                                    placeholder: 'Пользователь',
                                    hintText: '',
                                    textValue: user?.fullName,
                                    icon: Icons.keyboard_arrow_down_outlined,
                                    selector: () async {
                                      user = await selector(
                                        entity: user,
                                        entityName: EntityNames.userExt,
                                        isPopUp: true,
                                        fromMap: (Map<String, dynamic> json) =>
                                            User.fromMap(json),
                                        useFilterByProperty: 'fullName',
                                      ) as User;
                                      if (user != null) {
                                        setState(() {
                                          user?.fullNameWithLogin =
                                              '${user.fullName}[${user?.login}]';
                                        });
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        onPressed: user != null &&
                                                hrRole != null
                                            ? () {
                                                for (int i = 0;
                                                    i <
                                                        (widget
                                                                .model
                                                                .notPersisitBprocActors
                                                                ?.length ??
                                                            0);
                                                    i++) {
                                                  if (hrRole.id ==
                                                      widget
                                                          .model
                                                          .notPersisitBprocActors[
                                                              i]
                                                          .hrRole
                                                          .id) {
                                                    for (int j = 0;
                                                        j <
                                                            (widget
                                                                    .model
                                                                    .notPersisitBprocActors[
                                                                        i]
                                                                    .users
                                                                    ?.length ??
                                                                0);
                                                        j++) {
                                                      if (user.id ==
                                                          widget
                                                              .model
                                                              .notPersisitBprocActors[
                                                                  i]
                                                              .users[j]
                                                              .id) {
                                                        widget.model
                                                            .setBusy(false);
                                                        GlobalNavigator().errorBar(
                                                            title:
                                                                '${user.instanceName} уже есть в роль: ${hrRole.instanceName}');
                                                        return;
                                                      }
                                                    }
                                                  }
                                                }

                                                final List<User> users =
                                                    <User>[];
                                                final NotPersisitBprocActors
                                                    addNotPersisitBprocActor =
                                                    NotPersisitBprocActors();
                                                users.add(user);
                                                addNotPersisitBprocActor.users =
                                                    users;
                                                addNotPersisitBprocActor
                                                    .hrRole = hrRole;
                                                addNotPersisitBprocActor
                                                        .bprocUserTaskCode =
                                                    bprocUserTaskCode;
                                                addNotPersisitBprocActor
                                                    .rolesLink = rolesLink;
                                                widget.model
                                                    .notPersisitBprocActors
                                                    .add(
                                                  addNotPersisitBprocActor,
                                                );
                                                rolesLink = null;
                                                user = null;
                                                hrRole = null;
                                                setState(() {});
                                              }
                                            : null,
                                        child: const Text('Добавить'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: KzmButton(
                              outlined: true,
                              borderColor: Styles.appDarkGrayColor,
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                S.current.cancel,
                                style: Styles.mainTxtTheme.button,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: KzmButton(
                              onPressed: () {
                                var list = widget.model.bpmRolesDefiner.links
                                    .where((element) =>
                                        element.isAddableApprover &&
                                        element.required)
                                    .toList();
                                for (final Link x in list) {
                                  for (final notPersisitBprocActors
                                      in widget.model.notPersisitBprocActors) {
                                    if (notPersisitBprocActors
                                            .rolesLink.required &&
                                        notPersisitBprocActors
                                            .rolesLink.isAddableApprover) {
                                      if (x.bprocUserTaskCode !=
                                          notPersisitBprocActors
                                              .bprocUserTaskCode) {
                                        GlobalNavigator().errorBar(
                                            title:
                                                '${S.current.bpmNeedUserWithRole} "${x.hrRole.instanceName}"');
                                        return;
                                      }
                                    }
                                  }
                                }
                                Navigator.pop(context, true);
                              },
                              child: Text(
                                'OK',
                                style: Styles.mainTxtTheme.button
                                    .copyWith(color: Styles.appWhiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    ) /*;*/
        // log('-->> $fName, dialog ->> result: $result');
        .then((bool exit) async {
      // widget.model.refr();
      setState(() {});
      if (exit == null) return;
      if (exit) {
        // widget.model.setBusy(true);
        await widget.model.saveBprocActors();
      } else {
        return;
      }
    });
  }
}
