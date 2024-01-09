import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request_model.dart';
import 'package:provider/provider.dart';

class PersonalDataRequestFormEdit extends StatefulWidget {
  @override
  _PersonalDataRequestFormEditState createState() => _PersonalDataRequestFormEditState();
}

class _PersonalDataRequestFormEditState extends State<PersonalDataRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalDataRequestModel>(
      builder: (BuildContext context, PersonalDataRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.personalDataRequest,
                ),
                fields(model: model),
                BpmTaskList<PersonalDataRequestModel>(model),
                StartBpmProcess<PersonalDataRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required PersonalDataRequestModel model}) {
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
            textValue: formatFullNotMilSec(dateFormatFullRestNotMilSec.parse(model.request?.requestDate)),
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
            editable: false,
            placeholder: S.current.bithDate,
            textValue: formatShortly(model.request?.profile?.birthDate),
            leading: KzmIcons.date,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.nationalIdentifier,
            textValue: model.request?.personExt?.nationalIdentifier,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.sex,
            textValue: model.request?.profile?.sex,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.nation,
            textValue: model.request?.profile?.nationality,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.cityOfResidence,
            textValue: model.request?.profile?.cityOfResidence,
            isTextField: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.lastName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.lastName,
            onChanged: (String data) => model.request.lastName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.personName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.firstName,
            onChanged: (String data) => model.request.firstName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.middleName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.middleName,
            onChanged: (String data) => model.request.middleName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.lastNameLatin,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.lastNameLatin,
            onChanged: (String data) => model.request.lastNameLatin = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.personNameLatin,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.firstNameLatin,
            onChanged: (String data) => model.request.firstNameLatin = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.middleNameLatin,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.middleNameLatin,
            onChanged: (String data) => model.request.middleNameLatin = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.familyStatus,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.maritalStatus?.instanceName ?? '',
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              var companyId = await RestServices().getCompaniesByPersonGroupId();
              model.request?.maritalStatus = await selector(
                entity: model.request.maritalStatus,
                entityName: 'tsadv\$DicMaritalStatus',
                fromMap: (Map<String, dynamic> json) => AbstractDictionary.fromMap(json),
                filter: CubaEntityFilter(
                  returnCount: true,
                  view: '_local',
                  filter: Filter(
                    conditions: <FilterCondition>[
                      FilterCondition(
                        property: 'company.id',
                        conditionOperator: Operators.inList,
                        value: companyId,
                      )
                    ],
                  ),
                ),
                isPopUp: true,
              ) as AbstractDictionary;
              setState(() {});
              model.setBusy(false);
            },
            isRequired: true,
          ),
          FilesWidget<PersonalDataRequestModel>(
            isRequired: true,
            model: model,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}

//44586
