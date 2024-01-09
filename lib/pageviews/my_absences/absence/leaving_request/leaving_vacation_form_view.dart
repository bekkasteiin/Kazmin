import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/ui_design.dart';
// import 'package:kinfolk/global_variables.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:provider/provider.dart';

class LeavingVacationFormView extends StatefulWidget {
  @override
  _LeavingVacationFormViewState createState() => _LeavingVacationFormViewState();
}

class _LeavingVacationFormViewState extends State<LeavingVacationFormView> {
  File file;
  List<File> multiFile = [];

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
        allowMultiple: false,
      ))
          ?.files;
      if (_picker != null) {
        for (int i = 0; i < _picker.length; i++) {
          multiFile.add(File(_picker[i].path));
          setState(() {});
        }
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
    final LeavingVacationModel model = Provider.of<LeavingVacationModel>(context);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pageTitle(title: 'Заявка на выход из отпуска'),
            contentShadow(
              child: fields(model: model),
            ),
            BpmTaskList(model),
            StartBpmProcess(model)
          ],
        ),
      ),
    );
  }

  Widget fields({LeavingVacationModel model}) {
    return Column(
      children: <Widget>[
        FieldBones(
          isRequired: true,
          placeholder: 'Номер заявки',
          textValue: model?.request?.requestNumber.toString() ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.status,
          textValue: model?.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявки',
          textValue: formatShortly(model?.request?.requestDate) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Отсуствие',
          textValue: model?.request?.vacation?.type?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата с',
          textValue: formatFull(model?.request?.startDate) ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата по',
          textValue: formatFull(model?.request?.endDate) ?? '',
        ),
        if (model.request?.status?.code == 'DRAFT')
          FieldBones(
            isRequired: true,
            placeholder: S.current.plannedStartDate,
            textValue: model.request?.plannedStartDate == null ? '__ ___, _____' : formatShortly(model.request?.plannedStartDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.plannedStartDate = newDT;
                setState(() {});
              },
            ),
            icon: model.request?.plannedStartDate != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
            iconColor: model.request?.plannedStartDate != null ? Colors.red : null,
            iconTap: model.request?.plannedStartDate != null
                ? () {
                    model.request?.plannedStartDate = null;
                    setState(() {
                      model.request?.plannedStartDate = null;
                    });
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          )
        else
          Column(
            children: <Widget>[
              FieldBones(
                placeholder: S.current.plannedStartDate,
                textValue: formatShortly(model.request.plannedStartDate),
              ),
              if (model.request.plannedStartDate.difference(model.request.requestDate).inDays <= 30)
                const ListTile(
                  title: Text(
                    'Заявка подана за менее чем 30 календарных дней до планируемой даты выхода',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        if (model.request?.status?.code == 'DRAFT')
          FieldBones(
            isTextField: true,
            isRequired: true,
            placeholder: 'Примечание',
            onChanged: (String val) {
              model?.request?.comment = val;
            },
            textValue: model.request?.comment ?? '',
          )
        else
          FieldBones(
            placeholder: 'Примечание',
            textValue: model?.request?.comment ?? '',
          ),
        if (model.request?.status?.code == 'DRAFT')
          FieldBones(
            placeholder: 'Файл',
            iconTap: () {
              if (model.request.attachment != null) {
                setState(() {
                  file = null;
                  model.request.attachment = null;
                });
              } else {
                actionSheetMethod(context, model);
              }
            },
            selector: () async {
              if (model.request.attachment != null) {
                // final String url = '$localEndPoint/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String url = '${await endpointUrlAsync}/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String fileName = model.request.attachment.name;
                final String fullPath = await RestServices.downloadFile(url, fileName);
                OpenFile.open(fullPath);
              }
            },
            iconAlignEnd: true,
            icon: file == null ? Icons.attach_file : Icons.delete_forever,
            iconColor: file == null ? null : Colors.redAccent,
            textValue: model.request?.attachment?.name ?? '',
            hintText: 'файл не выбран',
          )
        else
          FieldBones(
            // needMaxLines: true,
            placeholder: 'Файл',
            iconAlignEnd: true,
            selector: () async {
              if (model.request.attachment != null) {
                // final String url = '$localEndPoint/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String url = '${await endpointUrlAsync}/rest/v2/files/${model.request.attachment.id}?access_token=${GlobalVariables.token}';
                final String fileName = model.request.attachment.name;
                final String fullPath = await RestServices.downloadFile(url, fileName);
                OpenFile.open(fullPath);
              }
            },
            icon: Icons.attach_file,
            textValue: model.request?.attachment?.name ?? '',
          ),
      ],
    );
  }

  actionSheetMethod(BuildContext context, LeavingVacationModel model) {
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
                      await model.saveFileToEntity(picker: multiFile.first);
                      multiFile = [];
                    }
                    setState(() {});
                  },
                  child: const Text('Документ'),),
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
