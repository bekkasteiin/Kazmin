import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/dms/insured_person.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/dms/insured_person_member.dart';
import 'package:kzm/viewmodels/insured_person_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class InsuredPersonForm extends StatefulWidget {
  @override
  _InsuredPersonFormState createState() => _InsuredPersonFormState();
}

class _InsuredPersonFormState extends State<InsuredPersonForm> {
  File file;
  String _fileName;
  bool isNotNullAddress = false;
  bool isNotNullDocument = true;
  TextEditingController phoneText = TextEditingController();
  bool attachFamily = true;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+#(###)#######',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Future<void> _openFileExplorer() async {
    try {
      final PlatformFile _picker = (await FilePicker.platform.pickFiles(
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
          .files
          .first;
      setState(() {
        if (_picker != null) {
          file = File(_picker.path);
          _fileName = file.path.split('/').last;
        }
      });
    } on PlatformException catch (e) {
      print('Unsupported operation$e');
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
  }

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickerFile =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile != null) {
        file = File(pickerFile.path);
        _fileName = file.path.split('/').last;
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> _getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickerFile =
        await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickerFile != null) {
        file = File(pickerFile.path);
        _fileName = file.path.split('/').last;
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InsuredPersonModel>(
      builder: (BuildContext context, InsuredPersonModel model, Widget l) {
        return Scaffold(
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageTitle(title: S.current.joinHealthInsurance),
                if (model.insuredPerson?.id!=null)
                  formView(model: model)
                else
                  editView(model: model),
                if(model.insuredPerson?.id!=null)
                  contractView(model: model)
                else
                  contractEdit(model: model),
                model.insuredPerson.insuranceContract.attachments.isNotEmpty?
                documentView(model: model)
                : documentEmptyView(model: model),
                if (model.insuredPerson?.id != null && model.memberList != null)
                  infoMembers(model: model),
                actions(model: model)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget actions({@required InsuredPersonModel model}) {
    return CancelAndSaveButtons(
        onTapCancel: model.busy
            ? null
            : () {
               GlobalNavigator.pop();
              },
        onTapSave: () async {
          model.pickerFile = file;
          await model.saveInsuredPerson();
        },);
  }

  Widget formView({@required InsuredPersonModel model}) {
    return KzmContentShadow(
      title: S.current.generalInformation,
      child: Column(
        children: [
          FieldBones(
            placeholder: S.current.employeeFio,
            isRequired: true,
            editable: false,
            icon: Icons.arrow_forward_ios,
            textValue: model?.insuredPerson?.employee?.instanceName,
          ),
          FieldBones(
            placeholder: S.current.iin,
            editable: false,
            isRequired: true,
            textValue: model?.insuredPerson?.iin ?? '',
          ),
          FieldBones(
            placeholder: S.current.sex,
            editable: false,
            isRequired: true,
            // icon: Icons.arrow_forward_ios,
            textValue: model.insuredPerson?.sex?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.beneficiaryBirthDate,
            isRequired: true,
            textValue: formatShortly(model.insuredPerson?.birthdate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.phoneNumber,
            isRequired: true,
            textValue: model.getInsuredPerson?.phoneNumber ?? '',
          ),
          FieldBones(
            placeholder: S.current.documentType,
            isRequired: true,
            editable: false,
            iconAlignEnd: true,
            icon: Icons.keyboard_arrow_down,
            textValue: model.insuredPerson?.documentType?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.militaryDocumentNumber,
            isRequired: true,
            editable: false,
            textValue: model.insuredPerson?.documentNumber ?? '',
          ),
          if (model.insuredPerson?.addressType != null)
            FieldBones(
              placeholder: S.current.beneficiaryAddressType,
              isRequired: true,
              editable: false,
              iconAlignEnd: true,
              icon: Icons.keyboard_arrow_down,
              textValue: model.insuredPerson?.addressType?.instanceName ?? '',
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Text.rich(
                  TextSpan(
                    text: '* ',
                    style: Styles.mainTS.copyWith(
                      color: Styles.appErrorColor,
                    ),
                    children: [
                      TextSpan(
                        text: S.current.adress,
                        style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.0.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Styles.appBorderColor,
                      width: 1,
                    ),
                    color:  Styles.appBrightGrayColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
                    // color: isTextField ? appWhiteColor : appGrayColor
                  ),
                  child: Text(model.insuredPerson?.address ?? ''),
              ),
            ],
          ),
          FieldBones(
            placeholder: S.current.company,
            isRequired: true,
            editable: false,
            textValue: model.insuredPerson?.company?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.experienceJob,
            isRequired: true,
            textValue: model.insuredPerson?.job?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employmentDate,
            isRequired: true,
            textValue: formatShortly(model.assignDate) ?? '',
          ),
          FieldBones(
            placeholder:  S.current.withholdingStatement,
            iconTap: () {
              if (file != null) {
                setState(() {
                  file = null;
                  _fileName = null;
                  model.pickerFile = null;
                });
              } else {
                actionSheetMethod(context);
                setState(() {
                  model.pickerFile = file;
                });
              }
            },
            selector: () {
              if (file == null) {
                actionSheetMethod(context);
                setState(() {
                  model.pickerFile = file;
                });
              } else {
                // actionSheetMethod(context);
                // setState(() {
                //   model.statementFile = file;
                // });
              }
            },
            iconAlignEnd: true,
            icon: file == null ? Icons.attach_file : Icons.delete_forever,
            iconColor: file == null ? null : Colors.redAccent,
            textValue: model.insuredPerson?.statementFile?.name ?? _fileName,
            hintText: S.current.notFile,
          ),
          SizedBox(height: 10.w)
        ],
      ),
    );
  }

  Widget editView({InsuredPersonModel model}) {
    if (model.insuredPerson.addressType != null) {
      isNotNullAddress = true;
    }
    return KzmContentShadow(
      title: S.current.generalInformation,
      child: Column(
        children: [
          FieldBones(
            placeholder: S.current.employeeFio,
            isRequired: true,
            icon: Icons.arrow_forward_ios,
            textValue: model?.insuredPerson?.employee?.instanceName,
          ),
          FieldBones(
            placeholder: S.current.iin,
            isRequired: true,
            textValue: model?.insuredPerson?.iin ?? '',
          ),
          FieldBones(
            placeholder: S.current.sex,
            isRequired: true,
            // icon: Icons.arrow_forward_ios,
            textValue: model.insuredPerson?.sex?.instanceName ?? '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder:  S.current.beneficiaryBirthDate,
            isRequired: true,
            textValue: formatShortly(model.insuredPerson?.birthdate),
          ),
          FieldBones(
            placeholder: S.current.phoneNumber,
            isRequired: true,
            isTextField: true,
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.number,
            textValue: model.insuredPerson?.phoneNumber ?? '',
            onChanged: (String val) {
              model.insuredPerson?.phoneNumber = val;
            },
          ),
          personDocumentFields(model: model),
          addressFields(model: model),
          FieldBones(
            placeholder: S.current.company,
            isRequired: true,
            textValue: model.insuredPerson?.company?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.position,
            isRequired: true,
            textValue: model.insuredPerson?.job?.instanceName ?? '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.employmentDate,
            isRequired: true,
            textValue: formatShortly(model.assignDate) ?? '',
          ),
          FieldBones(
            placeholder:  S.current.withholdingStatement,
            iconTap: () {
              if (file != null) {
                setState(() {
                  file = null;
                  _fileName = null;
                  model.pickerFile = null;
                });
              } else {
                actionSheetMethod(context);
                setState(() {
                  model.pickerFile = file;
                });
              }
            },
            selector: () {
              if (file == null) {
                actionSheetMethod(context);
                setState(() {
                  model.pickerFile = file;
                });
              } else {
                // actionSheetMethod(context);
                // setState(() {
                //   model.statementFile = file;
                // });
              }
            },
            iconAlignEnd: true,
            icon: file == null ? Icons.attach_file : Icons.delete_forever,
            iconColor: file == null ? null : Colors.redAccent,
            textValue: _fileName,
            hintText: S.current.notFile,
          ),
          SizedBox(height: 10.w)
        ],
      ),
    );
  }

  Column addressFields({@required InsuredPersonModel model}) {
    return Column(
      children: <Widget>[
        FieldBones(
          placeholder: S.current.addressType,
          isRequired: true,
          iconAlignEnd: true,
          iconColor:
              model.insuredPerson.addressType == null ? null : Colors.redAccent,
          icon: model.insuredPerson.addressType == null
              ? Icons.keyboard_arrow_down
              : Icons.cancel_outlined,
          iconTap: () async {
            if (model.insuredPerson?.addressType != null) {
              model.insuredPerson?.addressType = null;
              model.insuredPerson?.address = null;
            } else {
              await model.getAddressType();
              selectAddress(model);
              setState(() {});
              if (model.insuredPerson?.addressType != null) {
                if (model.addresses.isNotEmpty) {
                  for (int i = 0; i < model.addresses.length; i++) {
                    if (model.insuredPerson.addressType.id ==
                        model.addresses[i].addressType.id) {
                      model.insuredPerson.address = model.addresses[i].address;
                    }
                  }
                }
              } else {
                model.insuredPerson?.address = null;
              }
            }
            model.setBusy(false);
          },
          selector: () async {
            await model.getAddressType();
            selectAddress(model);
            setState(() {});
            if (model.insuredPerson?.addressType != null) {
              if (model.addresses.isNotEmpty) {
                for (int i = 0; i < model.addresses.length; i++) {
                  if (model.insuredPerson.addressType.id ==
                      model.addresses[i].addressType.id) {
                    model.insuredPerson.address = model.addresses[i].address;
                    break;
                  } else {
                    model.insuredPerson.address = null;
                  }
                }
              }
            }
            setState(() {});
          },
          textValue: model.insuredPerson?.addressType?.instanceName ?? '',
        ),


          FieldBones(
          placeholder: S.current.adress,
          isRequired: true,
          editable: true,
            isTextField: true,
          textValue: model.insuredPerson?.address ?? '',
          onChanged: (String val) {
            model.insuredPerson?.address = val;
          },
        ),

      ],
    );
  }

  Column personDocumentFields({@required InsuredPersonModel model}) {
    return Column(
      children: [
        FieldBones(
          placeholder: S.current.documentType,
          isRequired: true,
          iconAlignEnd: true,
          icon: model.insuredPerson.documentType == null
              ? Icons.keyboard_arrow_down
              : Icons.cancel_outlined,
          iconTap: () async {
            if (model.insuredPerson?.documentType != null) {
              model.insuredPerson?.documentType = null;
              model.insuredPerson.documentNumber = null;
              isNotNullDocument = true;
            } else {
              await model.getDocType();
              selectDocType(model);

              if (model.personDocuments.isNotEmpty) {
                for (int i = 0; i < model.personDocuments.length; i++) {
                  if (model.personDocuments[i].documentType.id ==
                      model.insuredPerson?.documentType?.id) {
                    model.insuredPerson.documentNumber =
                        model.personDocuments[i].documentNumber;
                    isNotNullDocument = false;
                    break;
                  } else {
                    model.insuredPerson.documentNumber = null;
                    isNotNullDocument = true;
                  }
                }
              } else {
                isNotNullDocument = true;
              }
            }
            setState(() {});
            model.setBusy(false);
          },
          selector: () async {
            await model.getDocType();
            selectDocType(model);
            if (model.personDocuments.isNotEmpty) {
              for (int i = 0; i < model.personDocuments.length; i++) {
                if (model.personDocuments[i].documentType.id ==
                    model.insuredPerson?.documentType?.id) {
                  model.insuredPerson.documentNumber =
                      model.personDocuments[i].documentNumber;
                  isNotNullDocument = false;
                  break;
                } else {
                  model.insuredPerson.documentNumber = null;
                  isNotNullDocument = true;
                }
              }
            } else {
              isNotNullDocument = true;
            }
            setState(() {});
          },
          iconColor: model.insuredPerson.documentType == null
              ? null
              : Colors.redAccent,
          textValue: model.insuredPerson?.documentType?.instanceName ?? '',
        ),
        FieldBones(
          placeholder: S.current.militaryDocumentNumber,
          isRequired: true,
          isTextField: isNotNullDocument,
          textValue: model.insuredPerson?.documentNumber ?? '',
          onChanged: (String val) {
            model?.insuredPerson?.documentNumber = val;
            model.setBusy(false);
          },
        ),
      ],
    );
  }

  Widget contractView({@required InsuredPersonModel model}) {
    if(model.insuredPerson?.id != null &&  model.assistanceList!=null){
      for (int i = 0; i < model.assistanceList.length; i++) {
        if(model.getContractAssistance?.id!=null ){
          if (model.assistanceList[i].assistance.id == model.getContractAssistance.id) {
            model.insuredPerson.assistance =  model.assistanceList[i];
            break;
          }
        }
      }
    }
    return KzmContentShadow(
      title: S.current.insuranceInformation,
      child: Column(
        children: [
            FieldBones(
              placeholder: S.current.insuranceContract,
              isRequired: true,
              editable: false,
              iconAlignEnd: true,
              icon: Icons.keyboard_arrow_down,
              textValue:
                  model?.insuredPerson?.insuranceContract?.contract ?? '',
            ),
            FieldBones(
              placeholder: S.current.assistance,
              editable: false,
              isRequired: true,
              textValue: model.insuredPerson?.assistance?.instanceName ?? '',
            ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.dateFrom,
            editable: false,
            textValue: formatShortly(
                    model?.insuredPerson?.insuranceContract?.startDate) ??
                '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.dateTo,
            editable: false,
            textValue: formatShortly(
                    model?.insuredPerson?.insuranceContract?.expirationDate) ??
                '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.attachDate,
            editable: false,
            textValue: formatShortly(model?.insuredPerson?.attachDate) ?? '',
          ),
          if(model.insuredPerson.statusRequest.code == "EXCLUDED")
            FieldBones(
              leading: calendarWidgetForFormFiled,
              placeholder: S.current.exclusionDate,
              editable: false,
              textValue: formatShortly(model?.insuredPerson?.exclusionDate) ?? '',
            ),
          FieldBones(
            placeholder: S.current.insuranceStatus,
            editable: false,
            textValue: model?.insuredPerson?.statusRequest?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.insuredProgram,
            editable: false,
            textValue: model?.insuredPerson?.insuranceProgram ?? '',
          ),
            FieldBones(
              placeholder: S.current.region,
              icon: Icons.keyboard_arrow_down,
              iconAlignEnd: true,
              editable: false,
              isRequired: true,
              textValue: model?.insuredPerson?.region?.instanceName ?? '',
            ),
            FieldBones(
              placeholder: S.current.totalAmountKzt,
              editable: false,
              textValue: model?.insuredPerson?.totalAmount.toString() ?? '',
            ),
        ],
      ),
    );
  }


  Widget contractEdit({@required InsuredPersonModel model}) {
    return KzmContentShadow(
      title: S.current.insuranceInformation,
      child: Column(
        children: [
          if (model.insuredPerson?.id == null)
            FieldBones(
              placeholder: S.current.insuranceContract,
              isRequired: true,
              iconAlignEnd: true,
              textValue:
              model?.insuredPerson?.insuranceContract?.contract ?? '',
            ),
            FieldBones(
                placeholder: S.current.assistance,
                isRequired: true,
                iconAlignEnd: true,
                icon: Icons.keyboard_arrow_down,
                selector: () async {
                  await model.getAssistanceContract(model.insuredPerson.insuranceContract.id);
                  selectContract(model);
                },
                textValue:  model.insuredPerson?.assistance?.instanceName ?? ''
            ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.dateFrom,
            editable: false,
            textValue: formatShortly(
                model?.insuredPerson?.insuranceContract?.startDate) ??
                '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.dateTo,
            editable: false,
            textValue: formatShortly(
                model?.insuredPerson?.insuranceContract?.expirationDate) ??
                '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: S.current.attachDate,
            editable: false,
            textValue: formatShortly(model?.insuredPerson?.attachDate) ?? '',
          ),
          FieldBones(
            placeholder:S.current.insuranceStatus,
            editable: false,
            textValue: model?.insuredPerson?.statusRequest?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.insuredProgram,
            editable: false,
            textValue: model?.insuredPerson?.insuranceProgram ?? '',
          ),
            FieldBones(
              placeholder: S.current.region,
              isRequired: true,
              icon: Icons.keyboard_arrow_down,
              iconAlignEnd: true,
              selector: () async {
                await model.getRegions();
                selectRegion(model);
              },
              textValue: model?.insuredPerson?.region?.instanceName ?? '',
            ),
        ],
      ),
    );
  }


  Widget documentView({@required InsuredPersonModel model}) {
    return KzmContentShadow(
      title: S.current.annexes,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.insuredPerson.insuranceContract.attachments.map((e){
         return Container(
           margin: EdgeInsets.all(4.w),
           padding: EdgeInsets.all(8.w),
           decoration: BoxDecoration(
             color: Styles.appBrightBlueColor,
             borderRadius: BorderRadius.circular(8.w)
           ),
           child: InkWell(
              child: Text(e.attachment.name ?? ''),
              onTap: (){
                PickerFileServices.downloadFile(e.attachment);
              },
            ),
         );
        }).toList(),
      ),
    );
  }

  Widget documentEmptyView({@required InsuredPersonModel model}) {
    return KzmContentShadow(
      title:  S.current.annexes,
      child: Center(
        child: Text(S.current.notAnnexes),
      ),
    );
  }

  void actionSheetMethod(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                _getImageCamera();
                GlobalNavigator.pop();
              },
              child:  Text(S.current.camera),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _getImage();
                GlobalNavigator.pop();
              },
              child: Text(S.current.photo),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _openFileExplorer();
                GlobalNavigator.pop();
              },
              child: Text(S.current.document),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              S.current.cancel,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: () =>GlobalNavigator.pop(),
          ),
        );
      },
    );
  }

  selectContract(InsuredPersonModel model) {
    var size = MediaQuery.of(context).size;
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
      builder: (_) => Container(
        color: Colors.transparent,
        height: size.height * (0.5),
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
                S.current.assistance,
                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Scrollbar(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (_, int i) {
                      bool current = false;
                      if (model?.insuredPerson?.assistance != null) {
                        current = model.assistanceContract[i].id == model.insuredPerson.assistance.id;
                      }
                      return Container(
                        color: Styles.appWhiteColor,
                        child: InkWell(
                          child: SelectItem(
                            model.assistanceContract[i].instanceName ?? '',
                            current,
                          ),
                          onTap: () => setState(() {
                            if (!current) {
                              model?.insuredPerson?.assistance = model.assistanceContract[i];
                              setState(() {});
                              GlobalNavigator.pop();
                            }
                          }),
                        ),
                      );
                    },
                    separatorBuilder: (_, int index) => const SizedBox(),
                    itemCount:model.assistanceContract?.length ?? 0,
                  ),
              ),
            ),
          ],
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
        select: model.insuredPerson.region,
        list: model.region ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model?.insuredPerson?.region != null) {
              current = model.region[i].id == model?.insuredPerson?.region.id;
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
                    model?.insuredPerson?.region = model.region[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount:model.region?.length ?? 0,
        ),
      ),
    );
  }

  selectAddress(InsuredPersonModel model) {
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
        title: S.current.addressType,
        select: model.insuredPerson.addressType,
        list: model.addressType ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model?.insuredPerson?.addressType != null) {
              current = model.addressType[i].id == model?.insuredPerson?.addressType.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.addressType[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model?.insuredPerson?.addressType = model.addressType[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount:model.addressType?.length ?? 0,
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
        title:S.current.documentType,
        select: model.insuredPerson.documentType,
        list: model.docType ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.insuredPerson.documentType != null) {
              current = model.docType[i].id == model.insuredPerson.documentType.id;
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
                    model.insuredPerson.documentType = model.docType[i];
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

  Column infoMembers({@required InsuredPersonModel model}) {
    if(model.insuredPerson.attachDate!= null && model.insuredPerson.insuranceContract.attachingFamily!=null){
      var attachDates = DateTime.now().difference(model.insuredPerson.attachDate).inDays;
      if(attachDates > model.insuredPerson.insuranceContract.attachingFamily){
        attachFamily = false;
      }
    }
    var sum = 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (attachFamily)
          Row(
          children: [
            Expanded(
              child: Padding(
                padding: paddingHorizontal(top: 20),
                child: KzmButton(
                  onPressed: () async {
                    await model.getMemberDefaultValue();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>
                        InsuredPersonMember(
                          model: model,
                        ),
                    )).then(
                      (value) async {
                        await model.dms;
                        setState(() {});
                      },
                    );
                  },
                  outlined: true,
                  borderColor: Styles.appDarkYellowColor,
                  textColorForOutline: Styles.appDarkBlueColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: const Icon(Icons.person_add_alt_1_outlined),
                      ),
                      Text(S.current.addFamilyMember,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ) else const SizedBox(),
        contentShadow(
          title: S.current.informationMember,
          child: Column(
            children: [
              if (model.memberList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.memberList.map((InsuredPerson e) {
                   sum  += e.amount;
                   model.insuredPerson.totalAmount = sum;
                    final String title = e.firstName +
                        ' ${e.secondName}' +
                        " ${e.middleName ?? ''}";
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4.w),
                      child: contentShadow(
                          hideMargin: true,
                          child: KzmExpansionTile(
                            title: title,
                            children: [
                              if (e.statusRequest.langValue3 != 'Insured')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  KzmButton(
                                    child: const Icon(Icons.edit_outlined),
                                    onPressed: () async {
                                      await model.setMember(e);
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>
                                          InsuredPersonMember(
                                            model: model,
                                          ),
                                      )).then((value) => setState(() {}));
                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  KzmButton(
                                    child: const Icon(Icons.delete_outline),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "${S.current.deleteSure} ${"${e.firstName} ${e.secondName}"}?",
                                              // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                            actions: [
                                              // OutlineButton(
                                              OutlinedButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                // textColor: Colors.black87,
                                                // padding: EdgeInsets.symmetric(horizontal: 16.w),
                                                child:  Text(S.current.cancel),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: MaterialButton(
                                                  color:
                                                      const Color(0xff025487),
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w),
                                                  child:  Text(
                                                    S.current.delete,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            elevation: 24,
                                          );
                                        },
                                      ).then((exit) async {
                                        setState(() {});
                                        if (exit == null) return;
                                        if (exit as bool) {
                                          final bool isDeleted = await model
                                              .delete(entityId: e.id);
                                          if (isDeleted) {
                                            await model.members;
                                            setState(() {});
                                          }
                                        } else {
                                          return;
                                        }
                                      });
                                    },
                                  )
                                ],
                              )  else const SizedBox(),
                              FieldBones(
                                isMinWidthTiles: true,
                                editable: false,
                                placeholder: S.current.relative,
                                textValue: e.relative?.instanceName ?? '',
                              ),
                              FieldBones(
                                isMinWidthTiles: true,
                                editable: false,
                                placeholder: S.current.sex,
                                textValue: e.sex?.instanceName ?? '',
                              ),
                              FieldBones(
                                editable: false,
                                isMinWidthTiles: true,
                                placeholder: S.current.beneficiaryBirthDate,
                                textValue: formatShortly(e.birthdate),
                              ),
                              FieldBones(
                                editable: false,
                                isMinWidthTiles: true,
                                placeholder: S.current.amountKzt,
                                textValue: e.amount.toString() ?? '',
                              ),
                              FieldBones(
                                editable: false,
                                isMinWidthTiles: true,
                                placeholder: S.current.status,
                                textValue: e.statusRequest.instanceName.toString() ?? '',
                              ),
                            ],
                          ),
                        ),
                    );
                  }).toList(),
                )
              else
                noData,
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
