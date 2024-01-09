import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/bpm/form_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';
import 'package:kzm/viewmodels/hr_requests.dart';
import 'package:kzm/viewmodels/notification_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/core/bpm_helpers/task/outcomes.dart';

// ignore: must_be_immutable
class OutcomesWidget<T extends AbstractBpmModel> extends StatelessWidget {
  final T model;

  const OutcomesWidget(this.model);

  @override
  Widget build(BuildContext context) {
    bool showOutcomes = false;
    bool showCancel = true;
    if (model?.formData?.outcomes != null && model.formData.outcomes.isNotEmpty)
    // ignore: curly_braces_in_flow_control_structures
    {
      for (int i = 0; i < model.tasks.last.assigneeOrCandidates.length; i++) {
        if (model.tasks.last.assigneeOrCandidates[i]?.id == model.userInfo.id) {
          showOutcomes = true;
          break;
        }else{
          showCancel = false;
        }
      }
    }

    // if (!showOutcomes) {
    //   if (model.request.status.code.toUpperCase() == statusCodeApproved || model.request.status.code.toUpperCase() == statusCodeCanceled) {
    //     return const SizedBox.shrink();
    //   } else {
    //     return Align(
    //       alignment: Alignment.topLeft,
    //       // child: showBtn(context, 'CANCEL'),
    //       child: outcomeButton(
    //         outcomeId: statusCodeCancel,
    //         onTap: () => onTap(context, 'CANCEL', model),
    //       ),
    //     );
    //   }
    // }

    if (!showOutcomes) {
      if (model.request.status.code.toUpperCase() == statusCodeApproved || model.request.status.code.toUpperCase() == statusCodeCanceled  || model.request.status.code.toUpperCase() == statusCodeReject) {
        return const SizedBox.shrink();
      } else {
        if(showCancel==false){
          return Column(
            children: <Widget>[
              SizedBox(height: Styles.appDoubleMargin),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: outcomeButton(
                      outcomeId: statusCodeCancel,
                      onTap: () => onTap(context, statusCodeCancel, model),
                    ),
                  ),
                ],
              ),
            ],
          );
        }else{
          return SizedBox();
        }
      }
    }
    // return Align(
    //   alignment: Alignment.topLeft,
    //   child: Wrap(
    //     spacing: 4,
    //     alignment: WrapAlignment.spaceBetween,
    //     children: model.formData.outcomes.map((Outcome e) {
    //       if (e.id == 'CANCEL' && model.request.employee.id != model.pgId) {
    //         // print(model.request?.status?.code ?? '');
    //         return const SizedBox();
    //       }
    //       // else if(e.id == 'CANCEL' && model.request.employee.id == model.pgId && )
    //       // return showBtn(context, e.id);
    //       return outcomeButton(
    //         outcomeId: e.id,
    //         onTap: () => onTap(context, e.id, model),
    //       );
    //     }).toList(),
    //   ),
    // );
    return Column(
      children: <Widget>[
        SizedBox(height: Styles.appDoubleMargin),
        if (model.request.requireAgreeAndFamiliarization && model.tasks.last.hrRole.id == employeeRoleID)
          Column(
            children: <KzmCheckboxListTile>[
              KzmCheckboxListTile(
                value: model.request?.agree ?? false,
                onChanged: (bool newVal) {
                  model.request?.agree = newVal;
                },
                title: Text(
                  S.current.agree,
                  style: Styles.mainTS.copyWith(
                    fontSize: 16,
                    color: Styles.appDarkGrayColor,
                  ),
                ),
              ),
              KzmCheckboxListTile(
                value: model.request?.familiarization ?? false,
                onChanged: (bool newVal) {
                  model.request?.familiarization = newVal;
                },
                title: Text(
                  S.current.familiarization,
                  style: Styles.mainTS.copyWith(
                    fontSize: 16,
                    color: Styles.appDarkGrayColor,
                  ),
                ),
              ),
            ],
          ),
        ...model.formData.outcomes.map((Outcome e) {
          // log('-->> $fName, outcome: ->> e: ${e.toJson()}');
          // log('-->> $fName, model.request.employee: ->> e: ${model.request.employee?.toJson()}');
          if (e.id == statusCodeCancel && model.request.employee?.id != model.pgId) {
            return const SizedBox();
          }
          return Row(
            children: <Expanded>[
              Expanded(
                child: outcomeButton(
                  outcomeId: e.id,
                  onTap: () => onTap(context, e.id, model),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  // Widget showBtn(BuildContext context, String id) {
  //   // return SizedBox.shrink();
  //   return outcomeButton(
  //     outcomeId: id,
  //     onTap: () => onTap(context, id),
  //   );
  // }

  void onTap(BuildContext context, String id, AbstractBpmModel<AbstractBpmRequest> model) {
    log('-->> $fName, onTap ->> id: $id');
    final TextEditingController _commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    getOutcomeNameById(id),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.w),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16.w,
                    ),
                    onPressed: () => Get.back(),
                  )
                ],
              ),
            ),
            Divider(
              height: 2,
              color: Styles.appDarkGrayColor,
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Комментарий',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 10.w),
            TextField(
              controller: _commentController,
              maxLines: 3,
              // enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Styles.appPrimaryColor),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          KzmButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            outlined: true,
            borderColor: Styles.appGrayColor,
            // ignore: prefer_const_constructors
            child: const Text('Отмена'),
          ),
          KzmButton(
            onPressed: ()async{
              if (id == 'REVISION' || id == 'REJECT' || id == 'ON_HOLD') {
                _commentController.text == '' || _commentController.text == null
                    ?  GlobalNavigator().errorBar(title: 'Заполните поле "Комментарий"')
                    : Navigator.pop(context, true);
              } else if(id == 'SEND_FOR_APPROVAL'){
                Navigator.pop(context, true);
                await model.saveRequest().then((value) => Navigator.pop(context, true));
              }
              else {
                Navigator.pop(context, true);
              }
            },
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Text('OK'),
          )
        ],
      ),
    ).then((dynamic exit) async {
      if (exit == null) return;
      if (exit as bool) {
        final HrRequestModel hrRequestModel = Provider.of<HrRequestModel>(context, listen: false);
        await model.completeWithOutcome(
          outcomeId: id,
          currentTask: model.tasks.last,
          comment: _commentController.text,
          hrRequestModel: id == 'CANCEL' ? hrRequestModel : null,
        ).then((value) {
          final NotificationModel notifications = Provider.of<NotificationModel>(context, listen: false);
          notifications.refreshData();
        });
      }
    });
   }
}
