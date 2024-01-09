import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/vacation_schedule_model.dart';
import 'package:provider/provider.dart';

class VacationScheduleFormView extends StatefulWidget {
  @override
  _VacationScheduleFormViewState createState() => _VacationScheduleFormViewState();
}

class _VacationScheduleFormViewState extends State<VacationScheduleFormView> {
  @override
  Widget build(BuildContext context) {
    final VacationScheduleRequestModel model = Provider.of<VacationScheduleRequestModel>(context);
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Column(
            children: [
              pageTitle(title: 'Заявка на график отпуска'),
              infoPanel(model: model),
              CancelAndSaveButtons(
                  disabled: true,
                  cancelText: 'Отменить',
                  onTapCancel: model.busy
                      ? null
                      : () {
                          Get.back();
                        },
                  onTapSave: null,),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoPanel({@required VacationScheduleRequestModel model}) {
    return KzmContentShadow(
        title: 'Общие сведения',
        child: Column(
          children: [
            FieldBones(
              placeholder: 'Номер заявки',
              textValue: model.request?.requestNumber.toString() ?? '',
            ),
            FieldBones(
              placeholder: 'Дата заявки',
              textValue: formatShortly(model.request?.requestDate) ?? ' ',
            ),
            FieldBones(
              placeholder: 'Назначенный график',
              textValue: model.request?.assignmentSchedule?.schedule?.scheduleName ?? '',
            ),
            FieldBones(placeholder: 'Остаток', textValue: model.request?.balance.toString() ?? ''),
            FieldBones(
                isRequired: true,
                placeholder: 'Дата с',
                leading: calendarWidgetForFormFiled,
                textValue: formatFull(model.request?.startDate) ?? '',),
            FieldBones(
                isRequired: true,
                placeholder: 'Дата по',
                leading: calendarWidgetForFormFiled,
                textValue: formatFull(model.request?.endDate) ?? '',),
            FieldBones(placeholder: 'Дни', textValue: model.request?.absenceDays.toString() ?? ''),
            FieldBones(
              placeholder: 'Примечание',
              maxLines: 3,
              textValue: model?.request?.comment ?? '',
            ),
            SizedBox(height: 8.w,),
            Row(
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: model.request.revision,
                      onChanged: (value) {},
                    ),
                    Text('На Доработку'),
                  ],
                ),
                SizedBox(width: 40.w,),

                Column(
                  children: [
                    Checkbox(
                      value: model.request.approved,
                      onChanged: (value) {},
                    ),
                    Text('Согласовано'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.w,),
            SizedBox(height: 8.w,),
            Container(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Text.rich(
                TextSpan(
                  text: '',
                  style: Styles.mainTS.copyWith(
                    // fontSize: 12,
                    color: Styles.appErrorColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Комментарий руководителя / ассистента',
                      style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Styles.appBrightGrayColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Styles.appBorderColor,
                  width: 1,
                ),

              ),
              child:  Text(model?.request?.commentManager ?? '',
                style: Styles.mainTS.copyWith(fontSize: 15.w, color: Styles.appDarkBlackColor),),
            ),
            FieldBones(
              placeholder: 'Статус отправки в Oracle',
              maxLines: 1,
              textValue: model?.request?.sentToOracle ?? '',
            ),
          ],
        ),);
  }
}
