import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/service/kinfolk/global_variables.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/items/personal_data.dart';

class PersonalData extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const PersonalData({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final PersonalDataRequestModel _personalDataRequestModel = Provider.of<PersonalDataRequestModel>(context, listen: false);
    return KzmContentShadow(
            child: GetBuilder<KzmLKController>(
              id: id,
              builder: (KzmLKController _) {
                return (model.personProfile?.ext == null)
                    ? const LoaderWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          KzmExpansionTile(
                            initiallyExpanded: true,
                            title: model.personProfile?.ext?.instanceName,
                            subtitle: model.personProfile?.ext?.nationalIdentifier,
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.lastName,
                                textValue:
                                    GlobalVariables.lang.toUpperCase() == 'EN' ? model.personProfile?.ext?.lastNameLatin : model.personProfile?.ext?.lastName,
                              ),
                              FieldBones(
                                placeholder: S.current.personName,
                                textValue:
                                    GlobalVariables.lang.toUpperCase() == 'EN' ? model.personProfile?.ext?.firstNameLatin : model.personProfile?.ext?.firstName,
                              ),
                              FieldBones(
                                placeholder: S.current.middleName,
                                textValue: GlobalVariables.lang.toUpperCase() == 'EN'
                                    ? model.personProfile?.ext?.middleNameLatin
                                    : model.personProfile?.ext?.middleName,
                              ),
                              FieldBones(
                                placeholder: S.current.bithDate,
                                textValue: formatShortly(model.personProfile?.birthDate),
                                leading: KzmIcons.date,
                              ),
                              FieldBones(
                                placeholder: S.current.sex,
                                textValue: model.personProfile?.sex,
                              ),
                              FieldBones(
                                placeholder: S.current.nation,
                                textValue: model.personProfile?.nationality,
                              ),
                              FieldBones(
                                placeholder: S.current.cityOfResidence,
                                textValue: model.personProfile?.cityOfResidence,
                              ),
                              FieldBones(
                                placeholder: S.current.familyStatus,
                                textValue: model.personProfile?.ext?.maritalStatus?.instanceName ?? '',
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _personalDataRequestModel.openRequestById(null),
                              ),
                            ],
                          ),
                        ],
                      );
              },
            ),
          );
  }
}
