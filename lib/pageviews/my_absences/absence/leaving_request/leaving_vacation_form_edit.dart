import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/leaving_vacation_model.dart';
import 'package:provider/provider.dart';

class LeavingVacationFormEdit extends StatefulWidget {
  @override
  _LeavingVacationFormEditState createState() => _LeavingVacationFormEditState();
}

class _LeavingVacationFormEditState extends State<LeavingVacationFormEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      print('aaa');
      if (_picker != null) {
        print(_picker.length);
        for (int i = 0; i < _picker.length; i++) {
          multiFile.add(File(_picker[i].path));
          setState(() {});
        }
        print(multiFile.length);
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
    return Consumer<LeavingVacationModel>(
      builder: (BuildContext context, LeavingVacationModel model, Widget l) {
        return Scaffold(
          key: _scaffoldKey,
          // appBar: defaultAppBar(context),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
              child: Column(
                children: <Widget>[
                  pageTitle(title: 'Выход из отпуска без сохранения заработной платы по уходу за ребенком до достижения им возраста трех лет'),
                  contentShadow(
                    child: fields(model: model),
                  ),
                  StartBpmProcess(model)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column fields({@required LeavingVacationModel model}) {
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: 'Номер заявки',
          textValue: '${model.request?.requestNumber ?? ''}',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Статус',
          textValue: model.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявки',
          textValue: formatShortly(model?.request?.requestDate),
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Отсуствие',
          textValue: model?.request?.vacation?.type?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата c',
          textValue: formatFull(model?.request?.vacation?.dateFrom),
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата по',
          textValue: formatFull(model?.request?.vacation?.dateTo),
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Планируемая дата выхода на работу',
          textValue: model.request?.plannedStartDate == null ? '__ ___, _____' : formatFull(model.request?.plannedStartDate),
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
                  setState(() {});
                }
              : null,
          iconAlignEnd: true,
        ),
        FieldBones(
          isTextField: true,
          isRequired: true,
          placeholder: 'Примечание',
          onChanged: (String val) {
            model?.request?.comment = val;
          },
          textValue: model.request?.comment ?? '',
        ),
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
          selector: () {
            actionSheetMethod(context, model);
          },
          iconAlignEnd: true,
          icon: model.request.attachment == null ? Icons.attach_file : Icons.delete_forever,
          iconColor: model.request.attachment == null ? null : Colors.redAccent,
          textValue: model.request?.attachment?.name ?? '',
          hintText: 'файл не выбран',
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

// defaultAppBar(BuildContext context) {}
}
