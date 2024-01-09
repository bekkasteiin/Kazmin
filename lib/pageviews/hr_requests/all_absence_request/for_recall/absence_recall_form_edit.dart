import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/bpm/bpm_roles_definer.dart';
import 'package:kzm/core/models/bpm/not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/my_team/my_team.dart';
// import 'package:kinfolk/model/url_types.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/absence_for_recall_model.dart';
import 'package:kzm/viewmodels/bpm_requests/change_absence_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/hr_requests/all_absence_request/for_recall/absence_recall_form_edit.dart';

class AbsenceForRecallFormEdit extends StatefulWidget {
  @override
  _AbsenceForRecallFormEditState createState() => _AbsenceForRecallFormEditState();
}

class _AbsenceForRecallFormEditState extends State<AbsenceForRecallFormEdit> {
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
    final AbsenceForRecallModel model = Provider.of<AbsenceForRecallModel>(context, listen: false);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            fields(model: model),
            BpmTaskList(model),
            StartBpmProcess(model),
          ],
        ),
      ),
    );
  }

  Widget fields({AbsenceForRecallModel model}) {
    final Container war = Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(vertical: 10.w),
      color: Styles.appErrorColor.withOpacity(0.2),
      child: Column(
        // ignore: always_specify_types
        children: const [
          Text(
            'Согласно трудовому законодательству РК '
            'не допускается отзыв из оплачиваемого ежегодного трудового'
            ' отпуска следующих категорий работников:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            ' - работника, не достигшего восемнадцатилетнего возраста'
            '\n - беременных женщин, предоставивших работодателю справку о беременности'
            '\n - работников, занятых на тяжелых работах, работах с вредными и (или) опасными условиями труда'
            '\n\nСотрудник относится к одной из вышеуказанных категорий, подача заявки запрещена.',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
    bool enableChecks = false;
    if (model.request.id != null && model.tasks != null) {
      enableChecks = model.tasks.last.assigneeOrCandidates.last.id == model.userInfo.id && model.request?.employee?.id == model.pgId;
    }
    log('-->> $fName, fields ->> request: ${model.request.toJson()}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        pageTitle(title: S.current.absenceForRecall),
        if (model.request.id == null && model.request.employee != null && !model.isHarmfulCondition) war,
        KzmContentShadow(
          //Если новый
          // child: model.request.id == null
          child: model.isEditable
              ? Column(
                  children: [
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.requestNumber,
                      textValue: model.request?.requestNumber.toString() ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.status,
                      textValue: model.request?.status?.instanceName ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.requestDate,
                      textValue: formatShortly(model.request?.requestDate),
                    ),
                    if (model.request?.status?.id != toBeRevisedID)
                      FieldBones(
                        editable: model.isEditable,
                        isRequired: true,
                        placeholder: S.current.employee,
                        hintText: S.current.select,
                        icon: Icons.keyboard_arrow_down,
                        textValue: model.child?.fullName,
                        maxLinesSubTitle: 2,
                        selector: model.isEditable
                            ? () async {
                                model.child = await selector(
                                  type: Types.services,
                                  entityName: 'tsadv_MyTeamService',
                                  methodName: 'getChildren',
                                  body: json.encode(
                                    <String, dynamic>{
                                      'parentPositionGroupId': (await model.personGroupForAssignment)?.currentAssignment?.positionGroup?.id,
                                    },
                                  ),
                                  fromMap: (Map<String, dynamic> j) {
                                    return MyTeamNew.fromMap(j);
                                  },
                                  isPopUp: true,
                                ) as MyTeamNew;
                                // if (!(await model.checkSelectedUserExists(pgId: model.child?.personGroupId))) model.child = null;
                                if (model.child?.personGroupId == null) model.child = null;
                                model.harmfulCondition = await RestServices.getPositionHarmfulConditionByPG(pgId: model.child.personGroupId);
                                model.personProfile = await RestServices.getPersonProfileByPersonGroupId(pgId: model.child.personGroupId);
                                model.checkHarmfulCondition();
                                model.request.vacation = null;
                                model.request.purpose = null;
                                setState(() {});
                              }
                            : null,
                      )
                    else
                      FieldBones(
                        isRequired: true,
                        placeholder: S.current.employee,
                        textValue: model.request?.employee?.instanceName ?? '',
                      ),
                    if (model.request?.status?.id != toBeRevisedID)
                      FieldBones(
                        isRequired: true,
                        icon: Icons.keyboard_arrow_down,
                        placeholder: S.current.changeAbsenceVacation,
                        textValue: model.request?.vacation?.instanceName ?? '',
                        selector: model.isEditable && model.child != null
                            ? () async {
                                final List<Absence> ab =
                                    await Provider.of<ChangeAbsenceModel>(context, listen: false).getAbsence(model.child.personGroupId, forRecall: true);
                                final List<KzmCommonItem> kzmList = [];
                                for (final Absence element in ab) {
                                  kzmList.add(KzmCommonItem(id: element.id, text: element.instanceName));
                                }
                                final KzmCommonItem kz = await selector(
                                  entity:  model.request?.vacation,
                                  values: kzmList,
                                  isPopUp: true,
                                ) as KzmCommonItem;
                                if (kz != null) {
                                  model.request.vacation = ab.firstWhere((Absence element) => element.id == kz.id);
                                  model.request.absenceType = model.request.vacation.type;
                                  // model.request.scheduleStartDate = model.request.vacation.dateFrom;
                                  // model.request.scheduleEndDate = model.request.vacation.dateTo;
                                }

                                // if (!(await model.checkSelectedUserExists(pgId: model.child?.personGroupId))) model.child = null;
                                if (model.child?.personGroupId == null) model.child = null;
                                // model.request.vacation = null;
                                model.request.purpose = null;
                                setState(() {});
                              }
                            : null,
                      )
                    else
                      FieldBones(
                        isRequired: true,
                        placeholder: S.current.changeAbsenceVacation,
                        textValue: model.request?.vacation?.instanceName ?? '',
                      ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.changeAbsenceVacationType,
                      textValue: model.request?.absenceType?.instanceName ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.dateRecallFrom,
                      textValue: model.request?.recallDateFrom != null ? formatShortly(model.request?.recallDateFrom) : '__ ___, _____',
                      selector: () => DateTimeSelector(
                        minimumDate: model.request?.requestDate,
                        maximumDate: model.request?.vacation?.dateTo,
                        startDate: model.request?.recallDateFrom,
                        onDateTimeChanged: (DateTime newDT) {
                          model.request?.recallDateFrom = newDT;
                          setState(() {});
                        },
                      ),
                      icon: model.request?.recallDateFrom != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
                      iconColor: model.request?.recallDateFrom != null ? Colors.red : null,
                      iconTap: model.request?.recallDateFrom != null
                          ? () {
                              model.request?.recallDateFrom = null;
                              setState(() {});
                            }
                          : null,
                      iconAlignEnd: true,
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.dateRecallTo,
                      textValue: model.request?.recallDateTo != null ? formatShortly(model.request?.recallDateTo) : '__ ___, _____',
                      selector: () => DateTimeSelector(
                        minimumDate: model.request?.requestDate,
                        maximumDate: model.request?.vacation?.dateTo,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDT) {
                          model.request?.recallDateTo = newDT;
                          setState(() {});
                        },
                      ),
                      icon: model.request?.recallDateTo != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
                      iconColor: model.request?.recallDateTo != null ? Colors.red : null,
                      iconTap: model.request?.recallDateTo != null
                          ? () {
                              model.request?.recallDateTo = null;
                              setState(() {});
                            }
                          : null,
                      iconAlignEnd: true,
                    ),
                    KzmCheckboxListTile(
                      value: model.request?.leaveOtherTime,
                      onChanged: (bool newVal) {
                        if (!newVal) {
                          model?.request?.dateFrom = null;
                          model?.request?.dateTo = null;
                        }
                        setState(() {
                          model.request?.leaveOtherTime = newVal;
                          model.request?.compensationPayment = !newVal;
                          if (model.request.leaveOtherTime) {
                            final S translation = S.of(Get.overlayContext);
                            showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        translation.leaveOtherTimeAlertTitle,
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Styles.appDarkGrayColor,
                                    )
                                  ],
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translation.leaveOtherTimeAlertContent,
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('OK'),
                                  )
                                ],
                              ),
                            ).then((bool exit) async {
                              if (exit == null) return;
                              if (exit) {
                                return;
                              } else {
                                //exit
                              }
                            });
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Text('* ',
                              style: Styles.mainTS.copyWith(
                                color: Colors.redAccent,
                              ),),
                          Flexible(
                            child: Text(S.current.absenseInAnotherTime,
                                style: Styles.mainTS.copyWith(
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                                textAlign: TextAlign.left,),
                          )
                        ],
                      ),
                    ),
                    KzmCheckboxListTile(
                      value: model.request?.compensationPayment,
                      onChanged: (bool newVal) {
                        if (newVal) {
                          model?.request?.dateFrom = null;
                          model?.request?.dateTo = null;
                        }
                        setState(() {
                          model.request?.leaveOtherTime = !newVal;
                          model.request?.compensationPayment = newVal;
                          if (model.request.leaveOtherTime) {
                            showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        S.current.leaveOtherTimeAlertTitle,
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Styles.appDarkGrayColor,
                                    )
                                  ],
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.current.leaveOtherTimeAlertContent,
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('OK'),
                                  )
                                ],
                              ),
                            ).then((bool exit) async {
                              if (exit == null) return;
                              if (exit) {
                                return;
                              } else {
                                //exit
                              }
                            });
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Text('* ',
                              style: Styles.mainTS.copyWith(
                                color: Colors.redAccent,
                              ),),
                          Text(S.current.compensationPay,
                              style: Styles.mainTS.copyWith(
                                fontSize: 14,
                                color: Styles.appDarkGrayColor,
                              ),),
                        ],
                      ),
                    ),
                    if (model.request.leaveOtherTime) Column(
                            children: [
                              FieldBones(
                                isRequired: model.request?.leaveOtherTime,
                                placeholder: S.current.unusedDaysFrom,
                                textValue: model.request?.dateFrom != null ? formatShortly(model.request?.dateFrom) : '__ ___, _____',
                                selector: () => DateTimeSelector(
                                    minimumDate: model.request?.requestDate,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (DateTime newDT) {
                                      model.request?.dateFrom = newDT;
                                      setState(() {});
                                    },
                                    startDate: model.request?.dateFrom,),
                                icon: model.request?.dateFrom != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
                                iconColor: model.request?.dateFrom != null ? Colors.red : null,
                                iconTap: model.request?.dateFrom != null
                                    ? () {
                                        model.request?.dateFrom = null;
                                        setState(() {});
                                      }
                                    : null,
                                iconAlignEnd: true,
                              ),
                              FieldBones(
                                isRequired: model.request?.leaveOtherTime,
                                placeholder: S.current.unusedDaysTo,
                                textValue: model.request?.dateTo != null ? formatShortly(model.request?.dateTo) : '__ ___, _____',
                                selector: () => DateTimeSelector(
                                  minimumDate: model.request?.requestDate,
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime newDT) {
                                    model.request?.dateTo = newDT;
                                    setState(() {});
                                  },
                                ),
                                icon: model.request?.dateTo != null ? Icons.cancel_outlined : Icons.keyboard_arrow_down,
                                iconColor: model.request?.dateTo != null ? Colors.red : null,
                                iconTap: model.request?.dateTo != null
                                    ? () {
                                        model.request?.dateTo = null;
                                        setState(() {});
                                      }
                                    : null,
                                iconAlignEnd: true,
                              ),
                            ],
                          ) else Column(),
                    // FieldBones(
                    //   isRequired: true,
                    //   placeholder: "Обоснование",
                    //   textValue:
                    //       model.request?.purpose?.instanceName ?? '',
                    //   iconAlignEnd: true,
                    //   icon: Icons.keyboard_arrow_down,
                    //   selector: () async {
                    //     model.request?.purpose = await selector(
                    //         entityName: 'tsadv_DicAbsencePurpose',
                    //         fromMap: (json) => AbstractDictionary.fromMap(json),
                    //         isPopUp: true);
                    //     if (model.request?.purpose == null ||
                    //         model.request?.purpose?.code == null ||
                    //         !(model.request?.purpose?.code ==
                    //             'OTHER')) {
                    //       model?.request?.purposeText = null;
                    //     }
                    //     setState(() {});
                    //     model.setBusy(false);
                    //   },
                    // ),
                    // model.request?.purpose?.code == "OTHER"
                    //     ?
                    FieldBones(
                      isTextField: true,
                      // isRequired: true,
                      placeholder: S.current.purpose,
                      onChanged: (String val) {
                        model?.request?.purposeText = val;
                      },
                      textValue: model.request?.purposeText ?? '',
                    )
                    // : Column()
                    ,
                    filesContainer(model: model),
                  ],
                )
              : Column(
                  children: [
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.requestNumber,
                      textValue: model.request?.requestNumber.toString() ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.status,
                      textValue: model.request?.status?.instanceName ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.requestDate,
                      textValue: formatShortly(model.request?.requestDate),
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.employee,
                      textValue: model.request?.employee?.instanceName ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.changeAbsenceVacation,
                      textValue: model.request?.vacation?.instanceName ?? '',
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.dateRecallFrom,
                      textValue: formatShortly(model.request?.recallDateFrom),
                      icon: Icons.keyboard_arrow_down,
                      iconAlignEnd: true,
                    ),
                    FieldBones(
                      isRequired: true,
                      placeholder: S.current.dateRecallTo,
                      textValue: formatShortly(model.request?.recallDateTo),
                      icon: Icons.keyboard_arrow_down,
                      iconAlignEnd: true,
                    ),
                    KzmCheckboxListTile(
                      value: model.request?.leaveOtherTime,
                      onChanged: null,
                      title: Row(
                        children: [
                          Text('* ',
                              style: Styles.mainTS.copyWith(
                                color: Colors.redAccent,
                              ),),
                          Flexible(
                            child: Text(S.current.absenseInAnotherTime,
                                style: Styles.mainTS.copyWith(
                                  fontSize: 16,
                                  color: Colors.black45,
                                ),
                                textAlign: TextAlign.left,),
                          )
                        ],
                      ),
                    ),
                    KzmCheckboxListTile(
                      value: model.request?.compensationPayment,
                      onChanged: null,
                      title: Row(
                        children: [
                          Text('* ',
                              style: Styles.mainTS.copyWith(
                                color: Colors.redAccent,
                              ),),
                          Flexible(
                            child: Text(S.current.compensationPay,
                                style: Styles.mainTS.copyWith(
                                  fontSize: 16,
                                  color: Styles.appDarkGrayColor,
                                ),),
                          ),
                        ],
                      ),
                    ),
                    if (model.request.leaveOtherTime)
                      Column(
                        children: [
                          FieldBones(
                            isRequired: model.request?.leaveOtherTime,
                            placeholder: S.current.unusedDaysFrom,
                            textValue: formatShortly(model.request?.dateFrom),
                            icon: Icons.keyboard_arrow_down,
                          ),
                          FieldBones(
                            isRequired: model.request?.leaveOtherTime,
                            placeholder: S.current.unusedDaysTo,
                            textValue: formatShortly(model.request?.dateTo),
                            icon: Icons.keyboard_arrow_down,
                          ),
                        ],
                      )
                    else
                      Column(),
                    // FieldBones(
                    //   isRequired: true,
                    //   placeholder: "Обоснование",
                    //   textValue:
                    //       model.request?.purpose?.instanceName ?? '',
                    //   iconAlignEnd: true,
                    //   icon: Icons.keyboard_arrow_down,
                    // ),
                    // model.request?.purpose?.code == "OTHER"
                    //     ?
                    FieldBones(
                      // isRequired: true,
                      placeholder: S.current.purpose,
                      textValue: model.request?.purposeText ?? '',
                    )
                    // : Column()
                    ,
                    filesContainer(model: model),
                    // KzmCheckboxListTile(
                    //   value: model.request?.isAgree,
                    //   onChanged: enableChecks
                    //       ? (bool newVal) {
                    //           setState(() {
                    //             model.request?.isAgree = newVal;
                    //           });
                    //         }
                    //       : null,
                    //   title: Text(
                    //     "Согласен",
                    //     style: Styles.mainTS.copyWith(
                    //       fontSize: 16,
                    //       color: Styles.appDarkGrayColor,
                    //     ),
                    //   ),
                    // ),
                    // KzmCheckboxListTile(
                    //   value: model.request?.isFamiliarization,
                    //   onChanged: enableChecks
                    //       ? (bool newVal) {
                    //           setState(() {
                    //             model.request?.isFamiliarization = newVal;
                    //           });
                    //         }
                    //       : null,
                    //   title: Text(
                    //     'Ознакомлен',
                    //     style: Styles.mainTS.copyWith(
                    //       fontSize: 16,
                    //       color: Styles.appDarkGrayColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
        ),
      ],
    );
  }

  // Widget users({AbsenceForRecallModel model}) {
  //   bool showOutcomes = false;
  //   if (model.formData.outcomes != null)
  //     for (int i = 0; i < model.tasks.last.assigneeOrCandidates.length; i++) {
  //       if (model.tasks.last.assigneeOrCandidates[i].id == model.userInfo.id) {
  //         showOutcomes = true;
  //         break;
  //       }
  //     }
  //   return KzmContentShadow(
  //       title: "Участники процесса утверждения",
  //       child: Column(
  //         children: [
  //           Column(
  //             children: model.tasks != null
  //                 ? model.tasks.map((ExtTaskData e) {
  //                     String users = "";
  //                     String countUser = e.assigneeOrCandidates.length > 1 ? " [${e.assigneeOrCandidates.length}]" : "";
  //                     for (int i = 0; i < e.assigneeOrCandidates.length; i++) {
  //                       if (i != e.assigneeOrCandidates.length - 1) {
  //                         users = "$users${e.assigneeOrCandidates[i].fullName}[${e.assigneeOrCandidates[i].login}], ";
  //                       } else {
  //                         users = "$users${e.assigneeOrCandidates[i].fullName}[${e.assigneeOrCandidates[i].login}]";
  //                       }
  //                     }
  //                     return Padding(
  //                       padding: EdgeInsets.symmetric(vertical: 5),
  //                       child: KzmContentShadow(
  //                           hideMargin: true,
  //                           child: KzmExpansionTile(title: "Пользователь$countUser", subtitle: users, children: [
  //                             FieldBones(
  //                               placeholder: "Роль",
  //                               textValue: e.hrRole?.instanceName ?? '',
  //                             ),
  //                             FieldBones(
  //                               placeholder: "Дата создания",
  //                               textValue: formatFullRestNotMilSec(e.createTime) ?? "",
  //                             ),
  //                             FieldBones(
  //                               placeholder: "Дата окончания",
  //                               textValue: formatFullRestNotMilSec(e.endTime) ?? "",
  //                             ),
  //                             FieldBones(
  //                               placeholder: "Решение",
  //                               textValue: getOutcomeNameById(e.outcome),
  //                             ),
  //                             FieldBones(
  //                               placeholder: "Комментарий",
  //                               textValue: e.comment ?? "",
  //                             ),
  //                           ])),
  //                     );
  //                   }).toList()
  //                 : [Container()],
  //           ),
  //           if (showOutcomes)
  //             Align(
  //               alignment: Alignment.topLeft,
  //               child: Wrap(
  //                 spacing: 4,
  //                 alignment: WrapAlignment.spaceBetween,
  //                 children: model.formData.outcomes.map((Outcome e) {
  //                   final TextEditingController _commentController = TextEditingController();
  //                   return outcomeButton(
  //                       outcomeId: e.id,
  //                       onTap: () {
  //                         if (model.validateOutcomeById(id: e.id, isAgree: model.request.isAgree, isFamiliarization: model.request.isFamiliarization)) {
  //                           showDialog<bool>(
  //                             context: context,
  //                             builder: (_) => AlertDialog(
  //                               titlePadding: EdgeInsets.zero,
  //                               title: Column(
  //                                 children: [
  //                                   Padding(
  //                                     padding: EdgeInsets.only(left: 20),
  //                                     child: Row(
  //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           getOutcomeNameById(e.id),
  //                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  //                                         ),
  //                                         IconButton(
  //                                             icon: Icon(
  //                                               Icons.close,
  //                                               size: 16,
  //                                             ),
  //                                             onPressed: () => Get.back())
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Divider(
  //                                     height: 2,
  //                                     color: Styles.appDarkGrayColor,
  //                                   )
  //                                 ],
  //                               ),
  //                               content: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     'Комментарий',
  //                                     style: TextStyle(fontSize: 12),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),
  //                                   TextField(
  //                                     controller: _commentController,
  //                                     maxLines: 3,
  //                                     // enabled: false,
  //                                     decoration: new InputDecoration(
  //                                       border: new OutlineInputBorder(borderSide: new BorderSide(color: Styles.appPrimaryColor)),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                               actions: [
  //                                 KzmButton(
  //                                   child: Text('Отмена'),
  //                                   onPressed: () => Navigator.pop(context, false),
  //                                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                                   outlined: true,
  //                                   borderColor: Styles.appGrayColor,
  //                                 ),
  //                                 KzmButton(
  //                                   child: Text('OK'),
  //                                   onPressed: () {
  //                                     S translation = S.of(Get.overlayContext);
  //                                     if (e.id == "REVISION" || e.id == "REJECT" || e.id == 'REVISION') {
  //                                       _commentController.text == "" || _commentController.text == null
  //                                           ? Get.snackbar(translation.attention, "Заполните поле \"Комментарий\"")
  //                                           : Navigator.pop(context, true);
  //                                     } else {
  //                                       Navigator.pop(context, true);
  //                                     }
  //                                   },
  //                                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                                 )
  //                               ],
  //                             ),
  //                           ).then((bool exit) async {
  //                             if (exit == null) return;
  //                             if (exit) {
  //                               await model.completeWithOutcome(outcomeId: e.id, currentTask: model.tasks.last, comment: _commentController.text);
  //                             } else {
  //                               //exit
  //                             }
  //                           });
  //                         }
  //                       });
  //                 }).toList(),
  //               ),
  //             ),
  //         ],
  //       ));
  // }

  // Widget actions({@required AbsenceForRecallModel model}) {
  //   return CancelAndSaveButtons(
  //     saveText: "Запустить процесс",
  //     cancelText: 'Отменить',
  //     onTapCancel: model.busy
  //         ? null
  //         : () {
  //             Get.back();
  //           },
  //     disabled: model.busy || !model.isHarmfulCondition || model.tasks != null || model.formData != null ? model.request?.id != null : false,
  //     onTapSave: () async {
  //       await model.getRolesDefinerAndNotRersisitActors();
  //       if (model.notPersisitBprocActors != null) {
  //         await dialog(context, model);
  //       }
  //     },
  //   );
  // }

  Widget filesContainer({AbsenceForRecallModel model}) {
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

  actionSheetMethod(BuildContext context, AbsenceForRecallModel model) {
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
                    if (picker != null && multiFile.isNotEmpty) {
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

  Future dialog(BuildContext context, AbsenceForRecallModel model) async {
    User user;
    HrRole hrRole = HrRole();
    String bprocUserTaskCode;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text(
                'Запуск процесса',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList().isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: const Text('Роль'),
                                    subtitle: Text(hrRole?.instanceName ?? 'выбрать'),
                                    onTap: () => showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 200,
                                              alignment: Alignment.center,
                                              child: ListView.separated(
                                                  itemCount: model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList().length,
                                                  separatorBuilder: (BuildContext context, int int) {
                                                    return const Divider();
                                                  },
                                                  itemBuilder: (BuildContext context, int index) {
                                                    final List<Link> ll = model.bpmRolesDefiner.links.where((Link element) => element.isAddableApprover).toList();
                                                    return GestureDetector(
                                                      child: Text(
                                                        ll[index].hrRole.instanceName,
                                                        style: const TextStyle(fontSize: 18),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          hrRole = ll[index].hrRole;
                                                          bprocUserTaskCode = ll[index].bprocUserTaskCode;
                                                          model.rebuild();
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                    );
                                                  },),);
                                        },),
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                  ListTile(
                                    title: const Text('Пользователь'),
                                    subtitle: Text(user?.fullName ?? 'выбрать'),
                                    onTap: () async {
                                      user = await selector(
                                        entityName: 'tsadv\$UserExt',
                                        isPopUp: true,
                                        fromMap: (Map<String, dynamic> json) => User.fromMap(json),
                                      ) as User;
                                      setState(() {
                                        user.fullNameWithLogin = '${user.fullName}[${user.login}]';
                                      });
                                      model.rebuild();
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MaterialButton(
                                            child: const Text('Добавить'),
                                            onPressed: () => setState(() {
                                                  if (user != null && hrRole != null) {
                                                    for (int i = 0; i < model.notPersisitBprocActors.length; i++) {
                                                      if (hrRole.id == model.notPersisitBprocActors[i].hrRole.id) {
                                                        for (int j = 0; j < model.notPersisitBprocActors[i].users.length; j++) {
                                                          if (user.id == model.notPersisitBprocActors[i].users[j].id) {
                                                            final S translation = S.of(Get.overlayContext);
                                                            GlobalNavigator().errorBar(title: '${user.instanceName} уже есть в роль: ${hrRole.instanceName}');
                                                            return;
                                                          }
                                                        }
                                                      }
                                                    }

                                                    final List<User> users = [];
                                                    final NotPersisitBprocActors addNotPersisitBprocActor = NotPersisitBprocActors();
                                                    users.add(user);
                                                    addNotPersisitBprocActor.users = users;
                                                    addNotPersisitBprocActor.hrRole = hrRole;
                                                    addNotPersisitBprocActor.bprocUserTaskCode = bprocUserTaskCode;
                                                    model.notPersisitBprocActors.add(addNotPersisitBprocActor);
                                                    user = null;
                                                    hrRole = null;
                                                  } else {}
                                                }),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : null,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: model.notPersisitBprocActors != null
                          ? model.notPersisitBprocActors.map((NotPersisitBprocActors e) {
                              String users = '';
                              final String countUser = e.users.length > 1 ? ' [${e.users.length}]' : '';
                              for (int i = 0; i < e.users.length; i++) {
                                if (i != e.users.length - 1) {
                                  users = "$users${e.users[i].fullName}[${e.users[i].login}], ";
                                } else {
                                  users = "$users${e.users[i].fullName}[${e.users[i].login}]";
                                }
                              }
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(e.hrRole.instanceName + countUser),
                                    subtitle: Text(users),
                                    trailing: e.id == null
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () => setState(() {
                                                  model.notPersisitBprocActors.remove(e);
                                                }),)
                                        : null,
                                  ),
                                  Container(
                                    child: model.notPersisitBprocActors?.last?.hrRole?.id != e.hrRole.id
                                        ? const Divider(
                                            height: 5,
                                            thickness: 1,
                                            indent: 15,
                                            endIndent: 15,
                                          )
                                        : null,
                                  )
                                ],
                              );
                            }).toList()
                          : [Container()],
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context, false),
                  // passing false
                  child: const Text('Отмена'),
                ),
                MaterialButton(
                  color: Colors.green[400],
                  onPressed: () => Navigator.pop(context, true),
                  // passing true
                  child: const Text('OK'),
                ),
              ],
              elevation: 24,
            );
          },
        );
      },
    ).then((bool exit) async {
      setState(() {});
      if (exit == null) return;
      if (exit) {
        await model.saveBprocActors();
      } else {
        return;
      }
    });
  }
}
