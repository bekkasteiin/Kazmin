import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/names_store.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';

// ignore: must_be_immutable
class AddPersistent<T extends AbstractBpmModel> extends StatefulWidget {
  T model;
  User user;
  HrRole hrRole;
  String bprocUserTaskCode;
  Link rolesLink;

  AddPersistent(this.model, this.user, this.hrRole, this.bprocUserTaskCode, this.rolesLink);

  @override
  _AddPersistentState createState() => _AddPersistentState();
}

// ignore: always_specify_types
class _AddPersistentState extends State<AddPersistent> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: widget.model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList().isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Роль'),
                    subtitle: Text(widget.hrRole?.instanceName ?? 'выбрать'),
                    onTap: () => showModalBottomSheet(
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
                              margin: EdgeInsets.symmetric(vertical: 10.w),
                              child: Container(
                                height: 5.h,
                                width: size.width / 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: Styles.appBrightBlueColor.withOpacity(0.4),
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
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                '',
                                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Scrollbar(
                                child: ListView.separated(
                                  itemCount: widget.model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList().length,
                                  separatorBuilder: (BuildContext context, int int) {
                                    return const Divider();
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    final List<Link> links = widget.model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList();
                                    bool current = false;
                                    if (widget.hrRole != null) {
                                      current = links[index].hrRole.id ==widget.hrRole.id;
                                    }
                                    return Container(
                                      color: Styles.appWhiteColor,
                                      child: InkWell(
                                        child: SelectItem(
                                          links[index].hrRole.instanceName,
                                          current,
                                        ),
                                        onTap: () => setState(() {
                                          if (!current) {
                                            widget.hrRole = links[index].hrRole;
                                            widget.bprocUserTaskCode = links[index].bprocUserTaskCode;
                                            widget.rolesLink = links[index];
                                            widget.model.rebuild();
                                            setState(() {});
                                            GlobalNavigator.pop();
                                          }
                                        }),
                                      ),
                                    );
                                  },),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).then((value) => setState(() {})),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  ListTile(
                    title: const Text('Пользователь'),
                    subtitle: Text(widget.user?.fullName ?? 'выбрать'),
                    onTap: () async {
                      widget.user = await selector(entityName: EntityNames.userExt, isPopUp: true, fromMap: (Map<String, dynamic> json) => User.fromMap(json)) as User;
                      setState(() {
                        widget.user.fullNameWithLogin = '${widget.user.fullName}[${widget.user.login}]';
                      });
                      widget.model.rebuild();
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 15.w,
                    endIndent: 15.w,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Добавить'),
                          onPressed: () {
                            if (widget.user != null && widget.hrRole != null) {
                              for (int i = 0; i < widget.model.notPersisitBprocActors.length; i++) {
                                if (widget.hrRole.id == widget.model.notPersisitBprocActors[i].hrRole.id) {
                                  for (int j = 0; j < widget.model.notPersisitBprocActors[i].users.length; j++) {
                                    if (widget.user.id == widget.model.notPersisitBprocActors[i].users[j].id) {
                                      widget.model.setBusy(false);
                                      final S translation = S.of(Get.overlayContext);
                                      GlobalNavigator().errorBar(title: '${widget.user.instanceName} уже есть в роль: ${widget.hrRole.instanceName}');
                                      return;
                                    }
                                  }
                                }
                              }
                              final List<User> users = [];
                              final NotPersisitBprocActors addNotPersisitBprocActor = NotPersisitBprocActors();
                              users.add(widget.user);
                              addNotPersisitBprocActor.users = users;
                              addNotPersisitBprocActor.hrRole = widget.hrRole;
                              addNotPersisitBprocActor.bprocUserTaskCode = widget.bprocUserTaskCode;
                              addNotPersisitBprocActor.rolesLink = widget.rolesLink;
                              widget.model.notPersisitBprocActors.add(addNotPersisitBprocActor);

                              widget.rolesLink = null;
                              widget.user = null;
                              widget.hrRole = null;
                            } else {}
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
