import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_beneficiary.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/beneficiary/beneficiary_request_model.dart';
import 'package:provider/provider.dart';

class Beneficiary extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Beneficiary({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final BeneficiaryRequestModel _beneficiaryRequestModel = Provider.of<BeneficiaryRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.beneficiary,
      action: GestureDetector(
        onTap: () => _beneficiaryRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.beneficiary == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.beneficiary.map(
                      (TsadvBeneficiary e){
                        return Padding(
                          padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                          child: KzmContentShadow(
                            hideMargin: true,
                            bottomPadding: 0,
                            child: KzmExpansionTile(
                              title: e.personGroupChild?.instanceName ?? '',
                              subtitle: e.relationshipType?.instanceName,
                              children: <Widget>[
                                FieldBones(
                                  placeholder: S.current.lastName,
                                  textValue: e.personGroupChild?.person?.lastName ?? '',
                                ),
                                FieldBones(
                                  placeholder: S.current.personName,
                                  textValue: e.personGroupChild?.person?.firstName ?? '',
                                ),
                                FieldBones(
                                  placeholder: S.current.middleName,
                                  textValue: e.personGroupChild?.person?.middleName ?? '',
                                ),
                                FieldBones(
                                  placeholder: S.current.beneficiaryBirthDate,
                                  textValue: formatShortly(e.personGroupChild?.person?.dateOfBirth) ?? '',
                                ),
                                FieldBones(
                                  placeholder: S.current.beneficiaryAdditionalContact,
                                  textValue: e.additionalContact,
                                ),
                                SizedBox(height: Styles.appQuadMargin),
                                KzmOutlinedBlueButton(
                                  caption: S.current.editText,
                                  enabled: true,
                                  onPressed: () => _beneficiaryRequestModel.openRequestById(e.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                    ),
                    // SizedBox(height: Styles.appQuadMargin),
                  ],
                );
        },
      ),
    );
  }
}
