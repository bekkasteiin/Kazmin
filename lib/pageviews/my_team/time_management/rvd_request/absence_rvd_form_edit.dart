import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/rvd/schedule_offsets_request.dart';
// import 'package:kinfolk/model/cuba_entity_filter.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_rvd_model.dart';
import 'package:provider/provider.dart';

class AbsenceRvdFormEdit extends StatefulWidget {
  @override
  _AbsenceRvdFormEditState createState() => _AbsenceRvdFormEditState();
}

class _AbsenceRvdFormEditState extends State<AbsenceRvdFormEdit> {
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
        allowMultiple: true,
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
    final AbsenceRvdModel model = Provider.of<AbsenceRvdModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: 'Заявки на РВД,Сверхуроч.'),
            KzmContentShadow(
              child: fields(model: model),
            ),
            StartBpmProcess(model)
          ],
        ),
      ),
    );
  }

  Widget fields({AbsenceRvdModel model}) {
    return Column(
      children: [
        FieldBones(
          isRequired: true,
          placeholder: '№ заявки',
          textValue: model.request?.requestNumber.toString() ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Статус',
          textValue: model.request?.status?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Дата заявки',
          textValue: formatShortly(model.request?.requestDate),
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Сотрудник',
          textValue: model.request?.employee?.instanceName ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Тип отсутствие',
          textValue: model.request?.type?.instanceName ?? '',
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
          selector: () async {
            final AbstractDictionary company = await RestServices.getCompanyByPersonGroupId(/*personGroupId: model.pgId*/);
            model.request?.type = await selector(
              entityName: 'tsadv\$DicAbsenceType',
              fromMap: (Map<String, dynamic> json) => DicAbsenceType.fromMap(json),
              filter: CubaEntityFilter(
                filter: Filter(conditions: [
                  FilterCondition(
                    property: 'availableToManager',
                    conditionOperator: Operators.equals,
                    value: true,
                  ),
                  FilterCondition(
                    group: 'OR',
                    conditions: [
                      ConditionCondition(
                        property: 'company.code',
                        conditionOperator: Operators.equals,
                        value: 'empty',
                      ),
                      ConditionCondition(
                        property: 'company.id',
                        conditionOperator: Operators.equals,
                        value: company.id,
                      )
                    ],
                  ),
                ],),
                view: '_local',
                returnCount: true,
              ),
              isPopUp: true,
            ) as DicAbsenceType;
            if (model.request?.type == null) {}
            setState(() {});
            model.setBusy(false);
          },
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Обоснование',
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
          selector: () async {
            if (model.request?.type == null) {
              final S translation = S.of(Get.overlayContext);
              GlobalNavigator().errorBar(title: 'Выберите тип отсуствие');
            } else {
              model.request?.absencePurpose = await selector(
                entityName: 'tsadv_AbsPurposeSetting',
                fromMap: (Map<String, dynamic> json) => Purpose.fromMap(json),
                filter: CubaEntityFilter(
                  filter: Filter(
                    conditions: [
                      FilterCondition(
                        property: 'absenceType',
                        conditionOperator: Operators.equals,
                        value: model.request.type.id,
                      ),
                    ],
                  ),
                  view: '_base',
                  returnCount: true,
                ),
                isPopUp: true,
              ) as Purpose;
            }
            if (model.request?.absencePurpose == null ||
                !(model.request?.absencePurpose?.purposeType?.instanceName == 'Другое' ||
                    !(model.request?.absencePurpose?.purposeType?.instanceName == 'OTHER'))) {
              model?.request?.purposeText = null;
            }
            setState(() {});
            model.setBusy(false);
          },
          textValue: model.request?.absencePurpose?.purposeType?.instanceName ?? '',
        ),
        if (model.request?.absencePurpose?.purposeType?.instanceName == 'Другое' || model.request?.absencePurpose?.purposeType?.instanceName == 'OTHER')
          FieldBones(
            isTextField: true,
            isRequired: true,
            placeholder: 'Обоснование',
            onChanged: (String val) {
              model?.request?.purposeText = val;
            },
            textValue: model.request?.purposeText ?? '',
          )
        else
          Column(),
        FieldBones(
          isRequired: true,
          placeholder: 'Время начала работы',
          dateField: true,
          textValue: model.request?.timeOfStarting != null ? formatFull(model.request?.timeOfStarting) : null,
          selector: () => DateTimeSelector(
            mode: CupertinoDatePickerMode.dateAndTime,
            onDateTimeChanged: (DateTime newDT) {
              model.request?.timeOfStarting = newDT;
              setState(() {});
            },
          ),
          icon: model.request?.timeOfStarting != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
          iconColor: model.request?.timeOfStarting != null ? Colors.red : null,
          iconTap: model.request?.timeOfStarting != null
              ? () {
                  model.request?.timeOfStarting = null;
                  setState(() {});
                }
              : null,
          iconAlignEnd: true,
        ),
        FieldBones(
          isRequired: true,
          placeholder: 'Время окончания работы',
          dateField: true,
          textValue: model.request?.timeOfFinishing != null ? formatFull(model.request?.timeOfFinishing) : null,
          selector: () {
            if (model.request?.timeOfStarting == null) {
              GlobalNavigator().errorBar(title: 'Заполните поле "Комментарий"');
            } else {
              DateTimeSelector(
                mode: CupertinoDatePickerMode.dateAndTime,
                onDateTimeChanged: (DateTime newDT) {
                  model.request?.timeOfFinishing = newDT;
                  model.request?.totalHours = model.request.timeOfFinishing.difference(model.request.timeOfStarting).inHours;
                  setState(() {});
                },
              );
            }
          },
          icon: model.request?.timeOfFinishing != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
          iconColor: model.request?.timeOfFinishing != null ? Colors.red : null,
          iconTap: model.request?.timeOfFinishing != null
              ? () {
                  model.request?.timeOfFinishing = null;
                  model.request?.totalHours = null;
                  setState(() {});
                }
              : null,
          iconAlignEnd: true,
        ),
        FieldBones(
          placeholder: 'Общее кол-во часов работы',
          textValue: model.request?.totalHours?.toString() ?? '',
        ),
        filesContainer(model: model),
      ],
    );
  }

  Widget filesContainer({AbsenceRvdModel model}) {
    bool editable = true;
    if (model.request.id != null) {
      editable = false;
    }
    return KzmFileDescriptorsWidget(
      editable: editable,
      onTap: () => actionSheetMethod(context, model),
      list: editable
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: model.request.files.isNotEmpty
                  ? model.request.files.map((FileDescriptor e) {
                      return KzmFileTile(
                        fileName: e.name,
                        onTap: () {
                          model.request.files.remove(e);
                          setState(() {});
                        },
                        fileDescriptor: e,
                      );
                    }).toList()
                  : [noData],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: model.request.files.isNotEmpty
                  ? model.request.files.map((FileDescriptor e) {
                      return KzmFileTile(
                        fileName: e.name,
                        onTap: null,
                        fileDescriptor: e,
                      );
                    }).toList()
                  : [noData],
            ),
    );
  }

  actionSheetMethod(BuildContext context, AbsenceRvdModel model) {
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
                    if (picker != null && multiFile.isNotEmpty != null) {
                      await model.saveFileToEntity(multiPicker: multiFile);
                      multiFile = [];
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
