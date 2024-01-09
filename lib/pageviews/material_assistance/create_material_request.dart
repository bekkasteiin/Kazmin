import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/sur_change_request.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/material_assistans_model.dart';
import 'package:provider/provider.dart';

class CreateMaterialRequest extends StatelessWidget {
  const CreateMaterialRequest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MaterialAssistantViewModel model = Provider.of<MaterialAssistantViewModel>(context);
    final SurChargeRequest request = model.request;
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
        appBar: KzmAppBar(context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              pageTitle(title: '${S.current.request} ${request.requestNumber}'),
              KzmContentShadow(
                child: Column(
                  children: <Widget>[
                    FieldBones(
                      isRequired: true,
                      editable: false,
                      placeholder: S.current.status,
                      textValue: request?.status?.instanceName,
                    ),
                    FieldBones(
                      isRequired: true,
                      editable: false,
                      placeholder: S.current.requestDate,
                      leading: calendarWidgetForFormFiled,
                      textValue: formatShortly(request.requestDate),
                    ),
                    FieldBones(
                      placeholder: S.current.materialAssistanceAidType,
                      hintText: S.current.select,
                      textValue: request?.aidType?.instanceName,
                      icon: Icons.keyboard_arrow_down,
                      maxLinesSubTitle: 2,
                      isRequired: true,
                      selector: () async {
                        request.aidType = await selector(
                          entityName: 'tsadv\$SurChargeName',
                          fromMap: (Map<String, dynamic> json) => AbstractDictionary.fromMap(json),
                          isPopUp: true,
                          filter: CubaEntityFilter(
                            filter: Filter(

                              conditions: <FilterCondition>[
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
                                      value: model.company?.id ?? '',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            view: '_local',
                          ),
                        ) as AbstractDictionary;
                        model.setBusy(false);
                      },
                    ),
                    FieldBones(
                      isTextField: true,
                      isRequired: true,
                      placeholder: S.current.purpose,
                      onChanged: (String val) {
                        request.justification = val;
                      },
                      textValue: request?.justification,
                    ),
                    // ignore: always_specify_types
                    FilesWidget(
                      model: model,
                      isRequired: true,
                    ),
                    StartBpmProcess(
                      model,
                      hideCancel: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
