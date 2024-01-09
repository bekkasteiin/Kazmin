import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/ui_design.dart';
// import 'package:kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/vacation_schedule_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

class VacationScheduleForm extends StatefulWidget {
  @override
  _VacationScheduleFormState createState() => _VacationScheduleFormState();
}

class _VacationScheduleFormState extends State<VacationScheduleForm> {
  File file;

  Future _openFileExplorer() async {
    List<PlatformFile> _picker;
    try {
      _picker = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'csv',
          'xml',
          'xlsx',
          'rtf',
        ],
        allowMultiple: true,
      ))
          ?.files;
      if (_picker != null) {
        file = File(_picker.first.path);
        setState(() {});
      }
      return _picker;
    } on PlatformException catch (e) {
      print('Unsupported operation$e');
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    return _picker;
  }

  Future _getImage() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickerFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile != null) {
        file = File(pickerFile.path);
      } else {
        print('No image selected');
      }
    });
    return pickerFile;
  }

  Future _getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickerFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickerFile != null) {
        file = File(pickerFile.path);
      } else {
        print('No image selected');
      }
    });
    return pickerFile;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VacationScheduleRequestModel>(
      builder: (BuildContext context, VacationScheduleRequestModel model, Widget l) {
        return Scaffold(
          // appBar: defaultAppBar(context),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                pageTitle(title: 'Заявка на график отпуска'),
                infoPanel(model: model),
                actions(model: model),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget infoPanel({@required VacationScheduleRequestModel model}) {
    return KzmContentShadow(
      title: 'Общие сведения',
      child: Column(
        children: [
          FieldBones(
            isRequired: true,
            placeholder: 'Номер заявки',
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
            isRequired: true,
            placeholder: 'Дата заявки',
            textValue: formatShortly(model.request?.requestDate) ?? ' ',
          ),
          FieldBones(
            placeholder: 'Назначенный график',
            textValue: model.request?.assignmentSchedule?.schedule?.scheduleName ?? '',
          ),
          FieldBones(placeholder: 'Остаток отпускных дней', textValue: model.request?.balance?.toString() ?? ''),
          FieldBones(
            isRequired: true,
            placeholder: 'Дата с',
            dateField: true,
            textValue: model.request?.startDate != null ? formatFull(model.request?.startDate) : null,
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              minimumDate: model.request?.requestDate,
              onDateTimeChanged: (DateTime newDT) async {
                model.request?.startDate = newDT;
                await model.calculateDay();
                await model.getBalanceDay();
                setState(() {});
              },
            ),
          ),
          FieldBones(
            isRequired: true,
            placeholder: 'Дата по',
            dateField: true,
            textValue: model.request?.endDate == null ? null : formatFull(model.request?.endDate),
            selector: () => DateTimeSelector(
              minimumDate: model.request?.requestDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) async {
                model.request?.endDate = newDT;
                await model.calculateDay();
                model.rebuild();
                setState(() {});
              },
            ),
          ),
          FieldBones(placeholder: 'Дни', textValue: model.request?.absenceDays?.toString() ?? ''),
          FieldBones(
            isTextField: true,
            placeholder: 'Примечание',
            maxLines: 3,
            onChanged: (String val) {
              model.request.comment = val;
            },
            textValue: model?.request?.comment ?? '',
          ),
          FieldBones(
            placeholder: 'Файл',
            textValue: model.request?.attachment?.name,
            hintText: 'файл не выбран',
            selector: () async {
              if (model.request.attachment != null) {
                // final String url = '$localEndPoint/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String url = '${await endpointUrlAsync}/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String fileName = model.request.attachment.name;
                final String fullPath = await RestServices.downloadFile(url, fileName);
                OpenFile.open(fullPath);
              } else {
                actionSheetMethod(context, model);
              }
            },
            iconColor: model.request.attachment != null ? Styles.appErrorColor : Styles.appDarkGrayColor,
            icon: model.request.attachment != null ? Icons.delete_forever : Icons.upload_sharp,
            iconTap: () {
              if (model.request.attachment != null) {
                model.request.attachment = null;
              } else {
                actionSheetMethod(context, model);
              }
              setState(() {});
            },
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
            isTextField: false,
            placeholder: 'Статус отправки в Oracle',
            maxLines: 1,
            textValue: model?.request?.sentToOracle ?? '',
          ),
        ],
      ),
    );
  }

  Widget actions({@required VacationScheduleRequestModel model}) {
    return CancelAndSaveButtons(
        disabled: model.request?.sentToOracle != null,
        saveText: 'Отправить на согласование',
        cancelText: 'Отменить',
        onTapCancel: model.busy
            ? null
            : () {
                Get.back();
              },
        onTapSave: () async {
          if (model.request.id == null) {
            await model.saveRequest();
          } else {
            await model.updateRequest();
          }
        },);
  }

  actionSheetMethod(BuildContext context, VacationScheduleRequestModel model) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Get.back();
                    final picker = await _getImageCamera();
                    if (picker != null) {
                      await model.saveFileToEntity(picker: file);
                      file = null;
                    }
                    setState(() {});
                  },
                  child: const Text('Камера'),),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Get.back();
                    final picker = await _getImage();
                    if (picker != null) {
                      await model.saveFileToEntity(picker: file);
                      file = null;
                    }
                    setState(() {});
                  },
                  child: const Text('Фото'),),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Get.back();
                    final picker = await _openFileExplorer();
                    if (picker != null) {
                      await model.saveFileToEntity(picker: file);
                      file = null;
                    }
                    setState(() {});
                  },
                  child: const Text('Документ'),)
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text(
                'Отменить',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          );
        },);
  }
}
