import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/date_time_input.dart';
//import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
//import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_model.dart';
import 'package:kzm/pageviews/hr_requests/dismissal/dismissal_request.dart';
import 'package:provider/provider.dart';

//
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/entities/other/person_profile.dart';

const String fName =
    'lib/pageviews/hr_requests/dismissal/view/dismissal_requests_view.dart';

class DismissalRequestsView extends StatefulWidget {
  final DismissalModel model;

  const DismissalRequestsView({Key key, this.model}) : super(key: key);

  @override
  State<DismissalRequestsView> createState() => _DismissalRequestsViewState();
}

class _DismissalRequestsViewState extends State<DismissalRequestsView> {
  //@override
  //void initState() {
  // list();
  //widget.model.refreshData = refreshData;
  //widget.model.getRequest().then((DismissalRequest value) => setState(() {}));
  //super.initState();
  //}

  //void refreshData() {
  //widget.model.getRequest().then((DismissalRequest value) => setState(() {}));
  //}
  File file;
  List<File> multiFile = [];
  bool enableFloatingButton = true;
  bool isLoading = true;

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
  void initState() {
    widget.model.getRequest().then((DismissalRequest value) => setState(() {
      isLoading = false;
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DismissalModel>(
      builder: (BuildContext context, DismissalModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.dismissal,
                ),
                fields(model: model),
                BpmTaskList<DismissalModel>(model),
                StartBpmProcess<DismissalModel>(model, hideCancel: false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required DismissalModel model}) {
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            //isRequired: true,
            placeholder: S.current.requestNum,
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
            //isRequired: true,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? ' ',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.dismissalFIO,
            textValue: model.request?.personProfile
                ?.fullName, //model.child?.fullName,//request?.personProfile.fullName,//employee?.instanceName,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Text.rich(
                  TextSpan(
                    text: S.current.dismissalPosition,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                  EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Styles.appBorderColor,
                      width: 1,
                    ),
                    color: Styles.appBrightGrayColor.withOpacity(0.6),
                    borderRadius:
                    BorderRadius.circular(Styles.appDefaultBorderRadius),
                    // color: isTextField ? appWhiteColor : appGrayColor
                  ),
                  child:
                  Text(model.request?.personProfile?.positionName ?? '')),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Text.rich(
                  TextSpan(
                    text: S.current.dismissalSubdivision,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Styles.appBorderColor,
                    width: 1,
                  ),
                  color: Styles.appBrightGrayColor.withOpacity(0.6),
                  borderRadius:
                  BorderRadius.circular(Styles.appDefaultBorderRadius),
                  // color: isTextField ? appWhiteColor : appGrayColor
                ),
                child:
                Text(model.request?.personProfile
                    ?.organizationName ?? ''),
              ),
            ],
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.dismissalHiredate,
            textValue: formatFullNotMilSec(model.request.personProfile
                ?.hireDate), //request?.personProfile.fullName,//employee?.instanceName,
          ),
          KzmDateTimeInput(
            caption: S.current.dismissalDate,
            formatDateTime: dateFormatFullNumeric,
            initialDateTime: formatFullNumeric(model.request?.dateOfDismissal),
            isLoading: false,
            isRequired: true,
            isActive: model.isEditable,
            onChanged: (DateTime val) {
              model.request.dateOfDismissal =
                  val.subtract(Duration(minutes: val.minute));
              setState(() {});
            },
          ),
          KzmOutlinedBlueButton(
            caption: S.current.dismissalDownloadButton,
            enabled: true,//model.isEditable,
            onPressed: () =>
                model.getReport(),
          ),
          Row(
            children: [
              Text(
                '* ',
                style: Styles.mainTS.copyWith(
                  color: Colors.redAccent,
                ),
              ),
              Flexible(
                child: Text(
                  S.current.dismissalDownloadText,
                  style: Styles.mainTS.copyWith(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.attachments,
            isRequired: true,
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
            icon: model.request.attachment == null
                ? Icons.attach_file
                : Icons.delete_forever,
            iconColor:
            model.request.attachment == null ? null : Colors.redAccent,
            textValue: model.request?.attachment?.name ?? '',
            hintText: 'файл не выбран',
          ),
          if (!model.isEditable)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(S.current.comment, textAlign: TextAlign.left),
                TextField(
                  enabled: model.isEditable,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(hintText: model.request?.reason),
                )
              ],
            ),
          if (model.isEditable)
            FieldBones(
              isTextField: true,
              isRequired: model.request?.type?.isJustRequired ?? false,
              placeholder: S.current.comment,
              onChanged: (String val) {
                model?.request?.reason = val;
              },
              textValue: model.request?.reason ?? '',
            ),
        ],
      ),
    );
  }

  actionSheetMethod(BuildContext context, DismissalModel model) {
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
              child: const Text('Камера'),
            ),
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
              child: const Text('Фото'),
            ),
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
              child: const Text('Документ'),
            ),
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
      },
    );
  }
}