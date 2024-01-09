import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_person.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request_model.dart';
import 'package:provider/provider.dart';

const String fName =
    'lib/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_form_edit.dart';

class BeneficiaryRequestFormEdit extends StatefulWidget {
  bool update;
  BeneficiaryRequestFormEdit({this.update = false});
  @override
  _BeneficiaryRequestFormEditState createState() =>
      _BeneficiaryRequestFormEditState();
}

class _BeneficiaryRequestFormEditState
    extends State<BeneficiaryRequestFormEdit> {
  bool isRequired = true;
  bool fileRequired = true;
  bool isEditable = true;
  String fullName;

  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryRequestModel>(
      builder: (BuildContext context, BeneficiaryRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.beneficiary,
                ),
                fields(model: model),
                memberWorkKazmin(model: model),
                if (!widget.update)
                  edit(model: model)
                else
                  updates(model: model),
                KzmContentShadow(
                  child: FilesWidget<BeneficiaryRequestModel>(
                    isRequired: fileRequired,
                    model: model,
                    // editable: !model.historyExists,
                    editable: model.isEditable,
                  ),
                ),
                BpmTaskList<BeneficiaryRequestModel>(model),
                StartBpmProcess<BeneficiaryRequestModel>(model,
                    hideCancel: false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required BeneficiaryRequestModel model}) {
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
            textValue: model.request?.status?.instanceName,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName,
          ),
        ],
      ),
    );
  }

  Widget memberWorkKazmin({@required BeneficiaryRequestModel model}) {
    DateTime _dt = DateTime.now();
    return KzmContentShadow(
      child: Column(
        children: [
          pageTitle(
            title: S.current.beneficiaryWorkKazmin,
          ),
          const SizedBox(
            height: 8,
          ),
          if (widget.update)
            FieldBones(
              editable: model.isEditable,
              isRequired: false,
              placeholder: S.current.beneficiaryFio,
              isTextField: model.isEditable,
              textValue: model.request?.personGroupChild?.instanceName ?? '',
            )
          else
            Autocomplete<RelevantPerson>(
              optionsMaxHeight: 300,
              optionsBuilder: (TextEditingValue textEditingValue) async {
                List<RelevantPerson> list =
                    await RestServices.getNameByUserName(
                        name: textEditingValue.text,
                        companyName: model.company.code);
                return list;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return SizedBox(
                  height: 40,
                  child: TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (String value) => onFieldSubmitted(),
                    style: Styles.mainTS, // Customize text style
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Customize border radius
                      ),
                    ),
                  ),
                );
              },
              displayStringForOption: (option) => option.instanceName,
              onSelected: (RelevantPerson selection) {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  isRequired = false;
                  isEditable = false;
                });
                model.request.personGroupChild = PersonGroup(id: selection.id);
                model.isEditableText = false;
                fullName = selection.instanceName;
              },
            ),
          if (model.request.personGroupChild != null)
            FieldBones(
              editable: model.isEditable,
              isRequired: true,
              placeholder: S.current.beneficiaryRelationshipType,
              textValue:
                  model.request?.entityData?.relationshipType?.instanceName,
              selector: !model.isEditable
                  ? null
                  : () async {
                      model.request.entityData.relationshipType =
                          await selector(
                        entity: model.request.entityData.relationshipType,
                        entityName: 'kzm_DicRelationshipTypeKzm',
                            methodName: 'search',
                            filter: CubaEntityFilter(
                              filter: Filter(
                                conditions: [
                                  FilterCondition(
                                    group: 'OR',
                                    conditions: [
                                      ConditionCondition(
                                        property: 'endDate',
                                        conditionOperator: Operators.equals,
                                        value: '',
                                      ),
                                      ConditionCondition(
                                        property: 'endDate',
                                        conditionOperator: Operators.greaterThanEqual,
                                        value: formatFullRestNotMilSec(_dt),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              view: 'dicRelationshipType-browse',
                            ),
                        fromMap: (Map<String, dynamic> json) =>
                            AbstractDictionary.fromMap(json),
                        isPopUp: true,
                      ) as AbstractDictionary;
                      if (model.request.entityData.relationshipType
                              .closeRelative ==
                          true) {
                        setState(() {
                          fileRequired = true;
                         model.isFile = true;
                         model.isEditableText = false;
                        });
                      }else{
                        setState(() {
                          fileRequired = false;
                          model.isFile = false;
                          model.isEditableText = false;
                        });
                      }
                    },
            )
          else
            SizedBox(),
        ],
      ),
    );
  }

  Widget edit({@required BeneficiaryRequestModel model}) {
    DateTime _dt = DateTime.now();
    return KzmContentShadow(
      child: Column(
        children: [
          pageTitle(
            title: S.current.familyMember,
          ),
          if (isEditable)
            FieldBones(
              editable: isEditable,
              isRequired: isRequired,
              placeholder: S.current.beneficiaryRelationshipType,
              textValue:
                  model.request?.entityData?.relationshipType?.instanceName,
              selector: !isEditable
                  ? null
                  : () async {
                      model.request.entityData.relationshipType =
                      await selector(
                        entity: model.request.entityData.relationshipType,
                        entityName: 'kzm_DicRelationshipTypeKzm',
                        methodName: 'search',
                        filter: CubaEntityFilter(
                          filter: Filter(
                            conditions: [
                              FilterCondition(
                                property: 'closeRelative',
                                conditionOperator: Operators.equals,
                                value: 'TRUE',
                              ),
                              FilterCondition(
                                group: 'OR',
                                conditions: [
                                  ConditionCondition(
                                    property: 'endDate',
                                    conditionOperator: Operators.equals,
                                    value: '',
                                  ),
                                  ConditionCondition(
                                    property: 'endDate',
                                    conditionOperator: Operators.greaterThanEqual,
                                    value: formatFullRestNotMilSec(_dt),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          view: 'dicRelationshipType-browse',
                        ),
                        fromMap: (Map<String, dynamic> json) =>
                            AbstractDictionary.fromMap(json),
                        isPopUp: true,
                      ) as AbstractDictionary;
                      setState(() {
                        model.isFile = true;
                      });
                    },
            )
          else
            SizedBox(),
          FieldBones(
              editable: isEditable,
              isRequired: isRequired,
              placeholder: S.current.beneficiaryLastName,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.lastName,
              onChanged: (String data) {
                model.request.entityData.lastName = data;
                model.request.lastName = data;
              }),
          FieldBones(
              editable: isEditable,
              isRequired: isRequired,
              placeholder: S.current.beneficiaryFirstName,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.firstName,
              onChanged: (String data) {
                model.request.entityData.firstName = data;
                model.request.firstName = data;
              }),
          FieldBones(
              editable: isEditable,
              isRequired: false,
              placeholder: S.current.beneficiaryMiddleName,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.middleName,
              onChanged: (String data) {
                model.request.entityData.middleName = data;
                model.request.middleName = data;
              }),
          FieldBones(
              editable: isEditable,
              isRequired: isRequired,
              placeholder: S.current.beneficiaryLastNameLatin,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.lastNameLatin,
              onChanged: (String data) {
                model.request.entityData.lastNameLatin = data;
                model.request.lastNameLatin = data;
              }),
          FieldBones(
              editable: isEditable,
              isRequired: isRequired,
              placeholder: S.current.beneficiaryFirstNameLatin,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.firstNameLatin,
              onChanged: (String data) {
                model.request.entityData.firstNameLatin = data;
                model.request.firstNameLatin = data;
              }),
          FieldBones(
            editable: isEditable,
            isRequired: isRequired,
            placeholder: S.current.beneficiaryBirthDate,
            textValue: model.request?.entityData?.birthDate == null
                ? '__ ___, _____'
                : formatShortly(model.request?.entityData?.birthDate),
            selector: !isEditable
                ? null
                : () => DateTimeSelector(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime newDT) {
                        model.request?.entityData?.birthDate = newDT;
                        model.request?.birthDate = newDT;
                        setState(() {});
                      },
                    ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.entityData?.birthDate != null
                ? Colors.red
                : Styles.appCorporateColor,
            iconTap: model.request?.entityData?.birthDate != null
                ? () {
                    model.request?.entityData?.birthDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
              editable: isEditable,
              isRequired: false,
              placeholder: S.current.beneficiaryWorkLocation,
              isTextField: isEditable,
              keyboardType: TextInputType.text,
              textValue: model.request?.entityData?.workLocation,
              onChanged: (String data) {
                model.request.entityData.workLocation = data;
                model.request.workLocation = data;
              }),
          FieldBones(
            editable: isEditable,
            isRequired: false,
            placeholder: S.current.beneficiaryAdditionalContact,
            isTextField: isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.entityData?.additionalContact,
            onChanged: (String data) =>
                model.request.entityData.additionalContact = data,
          ),
        ],
      ),
    );
  }

  Widget updates({@required BeneficiaryRequestModel model}) {
    DateTime _dt = DateTime.now();
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          pageTitle(
            title: S.current.familyMember,
          ),
          if (widget.update && model.request.personGroupChild != null)
        SizedBox()else
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryRelationshipType,
            textValue:
                model.request?.entityData?.relationshipType?.instanceName,
            selector: () async {
              await selector(
                entity: model.request.entityData.relationshipType,
                entityName: 'kzm_DicRelationshipTypeKzm',
                methodName: 'search',
                filter: CubaEntityFilter(
                  filter: Filter(
                    conditions: [
                      FilterCondition(
                        property: 'closeRelative',
                        conditionOperator: Operators.equals,
                        value: 'true',
                      ),
                      FilterCondition(
                        group: 'OR',
                        conditions: [
                          ConditionCondition(
                            property: 'endDate',
                            conditionOperator: Operators.equals,
                            value: '',
                          ),
                          ConditionCondition(
                            property: 'endDate',
                            conditionOperator: Operators.greaterThanEqual,
                            value: formatFullRestNotMilSec(_dt),
                          ),
                        ],
                      ),
                    ],
                  ),
                  view: 'dicRelationshipType-browse',
                ),
                fromMap: (Map<String, dynamic> json) =>
                    AbstractDictionary.fromMap(json),
                isPopUp: true,
              ) as AbstractDictionary;
              setState(() {
                model.isFile = true;
              });
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryLastName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue:
                model.request?.lastName ?? '',
            onChanged: (String data) =>model.request?.lastName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryFirstName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue:
                model.request?.firstName ?? '',
            onChanged: (String data) => model.request?.firstName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.beneficiaryMiddleName,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue:
                model.request?.middleName ?? '',
            onChanged: (String data) => model.request?.middleName= data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryLastNameLatin,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model
                .request?.lastNameLatin,
            onChanged: (String data) => model
                .request?.lastNameLatin = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryFirstNameLatin,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model
                .request?.firstNameLatin,
            onChanged: (String data) => model
                .request?.firstNameLatin = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.beneficiaryBirthDate,
            textValue: model.request?.birthDate==
                    null
                ? '__ ___, _____'
                : formatShortly(model.request?.birthDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.birthDate = newDT;
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.birthDate !=
                    null
                ? Colors.red
                : Styles.appCorporateColor,
            iconTap:model.request?.birthDate !=
                    null
                ? () {
              model.request?.birthDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.beneficiaryWorkLocation,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.workLocation,
            onChanged: (String data) =>
                model.request.workLocation = data,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: false,
            placeholder: S.current.beneficiaryAdditionalContact,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.entityData?.additionalContact,
            onChanged: (String data) =>
                model.request.entityData.additionalContact = data,
          ),
        ],
      ),
    );
  }
}
