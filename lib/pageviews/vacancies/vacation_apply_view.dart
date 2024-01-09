import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/company_vacation_model.dart';

class VacationApplyView extends StatefulWidget {
  const VacationApplyView({Key key}) : super(key: key);

  @override
  State<VacationApplyView> createState() => _VacationApplyViewState();
}

class _VacationApplyViewState extends State<VacationApplyView> {
  File file;
  List<File> multiFile = [];
  FileDescriptor attachment;

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
    return Scaffold(
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
          child: Column(
            children: <Widget>[
              contentShadow(
                child: field(userModel: userModel, model: model),
              ),
              KzmOutlinedBlueButton(
                caption: S.current.apply,
                enabled: true,
                onPressed: () {
                  if (!checkRequiredFields()) return;
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text(S.current.sureVacation),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          onPressed: () {
                            GlobalNavigator.pop();
                            model.saveApply(attachment);
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
                },
              ),
              KzmOutlinedBlueButton(
                caption: S.current.cancel,
                enabled: true,
                onPressed: ()=>GlobalNavigator.pop()
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkRequiredFields() {
    if (attachment == null) {
      GlobalNavigator().fillAllBar();
      return false;
    }
    return true;
  }

  Column field(
      {@required UserViewModel userModel,
      @required CompanyVacationModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.mainData,
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
        FieldBones(
          isRequired: true,
          placeholder: S.current.attachYouResume,
          iconTap: () {
            if (attachment != null) {
              setState(() {
                file = null;
                attachment = null;
              });
            } else {
              actionSheetMethod(context, model);
            }
          },
          selector: () {
            actionSheetMethod(context, model);
          },
          iconAlignEnd: true,
          icon: attachment == null ? Icons.attach_file : Icons.delete_forever,
          iconColor: attachment == null ? null : Colors.redAccent,
          textValue: attachment?.name ?? '',
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
                GlobalNavigator.pop();
                final picker = await _getImageCamera();
                if (picker != null) {
                  attachment = await RestServices.saveFile(file: file);
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
                  attachment = await RestServices.saveFile(file: file);
                  file = null;
                }
                setState(() {});
              },
              child: Text(S.current.photo),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                GlobalNavigator.pop();
                final picker = await _openFileExplorer();
                if (picker != null) {
                  attachment =
                      await RestServices.saveFile(file: multiFile.first);
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
            onPressed: ()=>GlobalNavigator.pop(),
          ),
        );
      },
    );
  }
}
