import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/insured_person_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InsuredPersonMember extends StatefulWidget {
  final InsuredPersonModel model;

  const InsuredPersonMember({Key key, this.model}) : super(key: key);

  @override
  _InsuredPersonMemberState createState() => _InsuredPersonMemberState();
}

class _InsuredPersonMemberState extends State<InsuredPersonMember> {
  bool isNotNullAddress = false;
  File file;
  List<File> multiFile = [];
  TextEditingController phoneText = TextEditingController();

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+#(###)#######',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

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
    final PickedFile pickerFile =
        await picker.getImage(source: ImageSource.gallery);
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
    final PickedFile pickerFile =
        await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickerFile != null) {
        file = File(pickerFile.path);
        print(pickerFile.path);
      } else {
        print('No image selected');
      }
    });
    return pickerFile;
  }

  @override
  Widget build(BuildContext context) {
    final InsuredPersonModel model = widget.model;
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pageTitle(title: S.current.addFamilyMember),
              infoPanelForMember(model: model),
              actions(model: model),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoPanelForMember({InsuredPersonModel model}) {
    return contentShadow(
      child: Column(
        children: [
          FieldBones(
            placeholder: S.current.lastName,
            isRequired: true,
            isTextField: true,
            onChanged: (String val) {
              model?.member?.secondName = val;
            },
            textValue: model?.member?.secondName ?? '',
          ),
          FieldBones(
            placeholder: S.current.personName,
            isRequired: true,
            isTextField: true,
            onChanged: (String val) {
              model?.member?.firstName = val;
            },
            textValue: model?.member?.firstName ?? '',
          ),
          FieldBones(
            placeholder: S.current.middleName,
            isTextField: true,
            onChanged: (String val) {
              model?.member?.middleName = val;
            },
            textValue: model?.member?.middleName ?? '',
          ),
          FieldBones(
            placeholder: S.current.sex,
            isRequired: true,
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
            selector: () async {
              await model.getMemberSex();
              await selectSex(model);
            },
            textValue: model.member?.sex?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.iin,
            isRequired: true,
            isTextField: true,
            onChanged: (String val) {
              model?.member?.iin = val;
            },
            textValue: model?.member?.iin ?? '',
            keyboardType: TextInputType.number,
            showCounterText: true,
            maxLength: 12,
          ),
          FieldBones(
            placeholder: S.current.phoneNumber,
            editable: true,
            isRequired: true,
            isTextField: true,
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.number,
            textValue: model.member?.phoneNumber ?? '',
            onChanged: (String val) {
              model.member?.phoneNumber = val;
            },
          ),
          FieldBones(
            placeholder: S.current.bithDate,
            isRequired: true,
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) async {
                model.member.birthdate = newDT;
                await model.calculateAmount();
                setState(() {});
                model.setBusy(false);
              },
              startDate: model.member?.birthdate,
            ),
            textValue: formatShortly(model.member?.birthdate),
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
          ),
          FieldBones(
            placeholder: S.current.relative,
            isRequired: true,
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
            selector: () async {
              await model.getRelative();
              await selectRelative(model);
            },
            textValue: model.member?.relative?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.documentType,
            isRequired: true,
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
            selector: () async {
              model.member?.documentType = await selector(
                  entityName: 'tsadv\$DicDocumentType',
                  fromMap: (json) => AbstractDictionary.fromMap(json),
                  isPopUp: true,
                  filter: CubaEntityFilter(
                    filter: Filter(conditions: [
                      FilterCondition(
                        property: 'company.id',
                        conditionOperator: Operators.equals,
                        value: model.company.id,
                      ),
                    ]),
                    view: '_local',
                  )
              );
              setState(() {});
              model.setBusy(false);
            },
            textValue: model.member?.documentType?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.militaryDocumentNumber,
            isRequired: true,
            isTextField: true,
            textValue: model.member?.documentNumber ?? '',
            onChanged: (String val) {
              model?.member?.documentNumber = val;
            },
          ),
          FieldBones(
            placeholder: S.current.region,
            icon: Icons.keyboard_arrow_down,
            isRequired: true,
            iconAlignEnd: true,
            selector: () async {
              var selected = await selector(
                  entityName: 'base\$DicRegion',
                  fromMap: (json) => AbstractDictionary.fromMap(json),
                  isPopUp: true);
              model.member?.region = selected;
              setState(() {});
              model.setBusy(false);
            },
            textValue: model?.member?.region?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.adress,
            isRequired: true,
            isTextField: true,
            textValue: model.member?.address ?? '',
            onChanged: (String val) {
              model?.member?.address = val;
            },
          ),
          FieldBones(
            placeholder: S.current.amountKzt,
            isRequired: true,
            textValue: model.member?.amount?.toString() ?? '',
          ),
          FieldBones(
            placeholder: S.current.attachDate,
            isRequired: true,
            textValue: formatShortly(model.member?.attachDate),
          ),
          //filesContainer(model: model),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget actions({@required InsuredPersonModel model}) {
    return CancelAndSaveButtons(
      onTapCancel: model.busy
          ? null
          : () {
              GlobalNavigator.pop();
            },
      onTapSave: model.busy
          ? null
          : () async {
              if (model.member.amount > 0) {
                model.setBusy(false);
                showDialog(
                  context: context,
                  builder: (_) {
                    return CupertinoAlertDialog(
                      content: Text(S.current.attachCoPaymentField),
                      actions: [
                        CupertinoButton(
                          child: Text(S.current.ok),
                          onPressed: () async {
                            Navigator.pop(_);
                            await model.saveMember();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                await model.saveMember();
              }
            },
    );
  }

  void actionSheetMethod(BuildContext context,
      {@required InsuredPersonModel model}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                GlobalNavigator.pop();
                final picker = await _getImageCamera();
                if (picker != null) {
                  await model.saveFileToEntity(isMember: true, picker: file);
                  file = null;
                }
                setState(() {});
              },
              child: Text(S.current.camera),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                GlobalNavigator.pop();
                final picker = await _getImage();
                if (picker != null) {
                  await model.saveFileToEntity(isMember: true, picker: file);
                  file = null;
                }
                setState(() {});
              },
              child: Text(S.current.photo),
            ),
            // ignore: require_trailing_commas
            CupertinoActionSheetAction(
              onPressed: () async {
                GlobalNavigator.pop();
                final picker = await _openFileExplorer();
                print(picker);
                if (picker != null && multiFile.isNotEmpty != null) {
                  await model.saveFileToEntity(
                      isMember: true, multiPicker: multiFile);
                  multiFile = [];
                }
                setState(() {});
              },
              child: Text(S.current.document),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              S.current.cancel,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: () => GlobalNavigator.pop(),
          ),
        );
      },
    );
  }

  selectSex(InsuredPersonModel model) {
    showModalBottomSheet(
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
      builder: (_) => SelectsWidget(
        title: S.current.sex,
        select: model.member.sex,
        list: model.memberSex ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.member.sex != null) {
              current = model.memberSex[i].id == model.member.sex.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.memberSex[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.member.sex = model.memberSex[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.memberSex?.length ?? 0,
        ),
      ),
    );
  }

  selectRelative(InsuredPersonModel model) {
    showModalBottomSheet(
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
      builder: (_) => SelectsWidget(
        title: S.current.relative,
        select: model.member.relative,
        list: model.relative ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.member.relative != null) {
              current = model.relative[i].id == model.member.relative.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.relative[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.member.relative = model.relative[i];
                    setState(() {});
                    model.calculateAmount();
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.relative?.length ?? 0,
        ),
      ),
    );
  }

  selectDocType(InsuredPersonModel model) {
    showModalBottomSheet(
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
      builder: (_) => SelectsWidget(
        title: S.current.documentType,
        select: model.member.documentType,
        list: model.docType ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.member.documentType != null) {
              current = model.docType[i].id == model.member.documentType.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.docType[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.member.documentType = model.docType[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.docType?.length ?? 0,
        ),
      ),
    );
  }

  selectRegion(InsuredPersonModel model) {
    showModalBottomSheet(
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
      builder: (_) => SelectsWidget(
        title: S.current.region,
        select: model.member.region,
        list: model.region ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model?.member?.region != null) {
              current = model.region[i].id == model?.member?.region?.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.region[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model?.member?.region = model.region[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.region?.length ?? 0,
        ),
      ),
    );
  }

  Widget filesContainer({InsuredPersonModel model}) {
    return KzmFileDescriptorsWidget(
      // isRequired: true,
      onTap: () => actionSheetMethod(context, model: model),
      list: Column(
        mainAxisSize: MainAxisSize.min,
        children: model.member.file.isNotEmpty
            ? model.member.file.map((FileDescriptor e) {
                final String fileName = e.name;
                return KzmFileTile(
                  fileName: fileName ?? '',
                  onTap: () {
                    model.member.file.remove(e);
                    setState(() {});
                  },
                );
              }).toList()
            : [noData],
      ),
    );
  }
}
