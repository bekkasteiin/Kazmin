import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/base_dic_education_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_form_study.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_request_model.dart';
import 'package:provider/provider.dart';

class EducationRequestFormEdit extends StatefulWidget {
  @override
  _EducationRequestFormEditState createState() => _EducationRequestFormEditState();
}

class _EducationRequestFormEditState extends State<EducationRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EducationRequestModel>(
      builder: (BuildContext context, EducationRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.education,
                ),
                fields(model: model),
                BpmTaskList<EducationRequestModel>(model),
                StartBpmProcess<EducationRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required EducationRequestModel model}) {
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            editable: false,
            placeholder: S.current.requestNumber,
            textValue: model.request.requestNumber?.toString(),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.requestDate,
            textValue: formatFullNotMilSec(model.request?.requestDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.langValue,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.educationSchool,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.school,
            onChanged: (String data) => model.request.school = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.educationType,
            textValue: model.request?.educationType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.educationType = await selector(
                entity: model.request.educationType,
                entityName: 'base\$DicEducationType',
                fromMap: (Map<String, dynamic> json) => BaseDicEducationType.fromMap(json),
                isPopUp: true,
              ) as BaseDicEducationType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.educationSpecialization,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.specialization,
            onChanged: (String data) => model.request.specialization = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.educationDiplomaNumber,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.diplomaNumber,
            onChanged: (String data) => model.request.diplomaNumber = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.educationFaculty,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.faculty,
            onChanged: (String data) => model.request.faculty = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.educationStartYear,
            isTextField: model.isEditable,
            keyboardType: TextInputType.number,
            textValue: model.request?.startYear?.toString(),
            onChanged: (String data) => model.request.startYear = int.parse(data),
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.educationEndYear,
            isTextField: model.isEditable,
            keyboardType: TextInputType.number,
            textValue: model.request?.endYear?.toString(),
            onChanged: (String data) => model.request.endYear = int.parse(data),
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.educationQualification,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.qualification,
            onChanged: (String data) => model.request.qualification = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.educationFormStudy,
            textValue: model.request?.formStudy?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.formStudy = await selector(
                entity: model.request.formStudy,
                entityName: 'tsadv_DicFormStudy',
                fromMap: (Map<String, dynamic> json) => TsadvDicFormStudy.fromMap(json),
                isPopUp: true,
              ) as TsadvDicFormStudy;
              model.setBusy(false);
            },
          ),
          FilesWidget<EducationRequestModel>(
            isRequired: true,
            model: model,
            // editable: !model.historyExists,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}

//44586
