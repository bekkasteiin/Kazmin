import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/company_vacation_model.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RecommendVacationView extends StatefulWidget {
  const RecommendVacationView({Key key}) : super(key: key);

  @override
  State<RecommendVacationView> createState() => _RecommendVacationViewState();
}

class _RecommendVacationViewState extends State<RecommendVacationView> {
  File file;
  List<File> multiFile = [];
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
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
      } else {
        print('No image selected');
      }
    });
    return pickerFile;
  }

  @override
  Widget build(BuildContext context) {
    final CompanyVacationModel model =
        Provider.of<CompanyVacationModel>(context, listen: false);
    final UserViewModel userModel =
        Provider.of<UserViewModel>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: KzmAppBar(context: context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
            child: Column(
              children: <Widget>[
                contentShadow(
                  child: field(userModel: userModel, model: model),
                ),
                contentShadow(
                  child: fields(model: model),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: SafeArea(
                    child: Column(
                      children: [
                        KzmOutlinedBlueButton(
                          caption: S.current.recommend,
                          enabled: true,
                          onPressed: () async {
                            final bool isFilled = isMaskFormatterFilled(maskFormatter, model.request?.mobilePhone ?? '');
                            if (isFilled) {
                              if (!model.checkRequiredFields()) return;
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: Text(S.current.sureRefVacation),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      onPressed: () async {
                                        GlobalNavigator.pop();
                                        await model.createCandidate();
                                      },
                                      isDefaultAction: false,
                                      child: Text(S.current.yes),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () => GlobalNavigator.pop(),
                                      child: Text(S.current.no),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              GlobalNavigator().errorBar(title: S.current.fillMobilePhone);
                            }
                          },
                        ),
                        KzmOutlinedBlueButton(
                          caption: S.current.cancel,
                          enabled: true,
                          onPressed: () => GlobalNavigator.pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column field({UserViewModel userModel, CompanyVacationModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.referringInfo,
          style: Styles.mainTS.copyWith(color: Styles.appDarkBlackColor),
        ),
        SizedBox(
          height: 16.h,
        ),
        FieldBones(
          textValue:
              "${userModel.person?.person?.firstName ?? ''}  ${userModel.person?.person?.lastName ?? ''}",
          placeholder: S.current.enterName,
        ),
        FieldBones(
          placeholder: S.current.enterEmail,
          textValue: model.userInfo?.email ?? '',
        ),
      ],
    );
  }

  bool isMaskFormatterFilled(MaskTextInputFormatter maskFormatter, String value) {
    String unmaskedText = value;
    print(maskFormatter.getMask().length);
    print(unmaskedText);
    // Modify this condition as per your needs
    return unmaskedText.length == maskFormatter.getMask().length;
  }

  Column fields({@required CompanyVacationModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.candidateInfo,
          style: Styles.mainTS.copyWith(color: Styles.appDarkBlackColor),
        ),
        SizedBox(
          height: 16.h,
        ),
        FieldBones(
          isTextField: true,
          onChanged: (String val) {
            model.request?.firstName = val;
          },
          textValue: model.request?.firstName ?? '',
          isRequired: true,
          placeholder: S.current.enterCandidateFirstName,
        ),
        FieldBones(
          isTextField: true,
          onChanged: (String val) {
            model.request?.lastName = val;
          },
          textValue: model.request?.lastName ?? '',
          isRequired: true,
          placeholder: S.current.enterCandidateLastName,
        ),
        FieldBones(
          placeholder: S.current.phoneNumber,
          editable: true,
          isRequired: true,
          isTextField: true,
          inputFormatters: [maskFormatter],
          keyboardType: TextInputType.number,
          textValue: model.request?.mobilePhone ?? '',
          onChanged: (String val) {
            model.request?.mobilePhone = val;
          },
        ),
        FieldBones(
          isTextField: true,
          onChanged: (String val) {
            model.request?.email = val;
          },
          textValue: model.request?.email ?? '',
          isRequired: true,
          placeholder: S.current.email,
        ),
        FieldBones(
          placeholder: S.current.bithDate,
          isRequired: true,
          selector: () => DateTimeSelector(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDT) async {
              model.request.birthDate = newDT;
              setState(() {});
              model.setBusy(false);
            },
            startDate: model.request?.birthDate,
          ),
          textValue: formatShortly(model.request?.birthDate),
          iconAlignEnd: true,
          icon: Icons.keyboard_arrow_down,
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.experienceYear,
          textValue: model.request?.workExperience?.instanceName ?? '',
          selector: ()async {
            FocusScope.of(context).requestFocus(FocusNode());
            workExperience(model);
           },
          icon: Icons.arrow_drop_down,
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.city,
          isTextField: true,
          onChanged: (String val) {
            model.request.cityResidence = val;
          },
          textValue: model.request?.cityResidence ?? '',
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.relations,
          textValue: model.request?.relationshipToReferrer?.instanceName ?? '',
          icon: Icons.arrow_drop_down,
          selector: () {
            FocusScope.of(context).requestFocus(FocusNode());
            relationshipToReferrer(model);
          },
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.candidateEducation,
          textValue: model.request?.education?.instanceName ?? '',
          icon: Icons.arrow_drop_down,
          selector: () {
            FocusScope.of(context).requestFocus(FocusNode());
            education(model);
          },
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.candidateEvaluation,
          textValue: model.request?.personalEvaluation?.instanceName ?? '',
          icon: Icons.arrow_drop_down,
          selector: () {
            FocusScope.of(context).requestFocus(FocusNode());
            personalEvaluation(model);
          },
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.attachResume,
          iconTap: () {
            if (model.request.file != null) {
              setState(() {
                file = null;
                model.request.file = null;
              });
            } else {
              actionSheetMethod(context, model);
            }
          },
          selector: () {
            actionSheetMethod(context, model);
          },
          iconAlignEnd: true,
          icon: model.request?.file == null
              ? Icons.attach_file
              : Icons.delete_forever,
          iconColor: model.request?.file == null ? null : Colors.redAccent,
          textValue: model.request?.file?.name ?? '',
          hintText: S.current.notFile,
        ),
      ],
    );
  }

  actionSheetMethod(BuildContext context, CompanyVacationModel model) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final picker = await _getImageCamera();
                if (picker != null) {
                  model.setBusy(true);
                  model.request.file = await RestServices.saveFile(file: file);
                  model.setBusy(false);
                  file = null;
                }
                setState(() {});
              },
              child: Text(S.current.camera),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final picker = await _getImage();
                if (picker != null) {
                  model.setBusy(true);
                  model.request.file = await RestServices.saveFile(file: file);
                  model.setBusy(false);
                  file = null;
                }
                setState(() {});
              },
              child: Text(S.current.photo),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final picker = await _openFileExplorer();
                if (picker != null) {
                  model.setBusy(true);
                  model.request.file =
                      await RestServices.saveFile(file: multiFile.first);
                  model.setBusy(false);
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  relationshipToReferrer(CompanyVacationModel model) {
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
        title: S.current.relations,
        select: model.request.relationshipToReferrer,
        list: model.relationshipToReferrer ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.request.relationshipToReferrer != null) {
              current = model.relationshipToReferrer[i].id == model.request.relationshipToReferrer.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.relationshipToReferrer[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.request.relationshipToReferrer = model.relationshipToReferrer[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount:model.relationshipToReferrer?.length ?? 0,
        ),
      ),
    );
  }

  education(CompanyVacationModel model) {
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
        title: S.current.candidateEducation,
        select: model.request.education,
        list: model.education ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.request.education != null) {
              current = model.education[i].id == model.request.education.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.education[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.request.education = model.education[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.education?.length ?? 0,
        ),
      ),
    );
  }

  personalEvaluation(CompanyVacationModel model) {
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
        title: S.current.candidateEvaluation,
        select: model.request.personalEvaluation,
        list: model.personalEvaluation ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.request.personalEvaluation != null) {
              current = model.personalEvaluation[i].id == model.request.personalEvaluation.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.personalEvaluation[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.request.personalEvaluation = model.personalEvaluation[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.personalEvaluation?.length ?? 0,
        ),
      ),
    );
  }

  workExperience(CompanyVacationModel model) {
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
        title: S.current.experienceYear,
        select: model.request.workExperience,
        list: model.workExperience ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (model.request.workExperience != null) {
              current = model.workExperience[i].id == model.request.workExperience.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.workExperience[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    model.request.workExperience = model.workExperience[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount:model.workExperience?.length ?? 0,
        ),
      ),
    );
  }
}
