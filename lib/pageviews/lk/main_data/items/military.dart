import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_military_form.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/military/military_request_model.dart';
import 'package:provider/provider.dart';

class Military extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Military({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final MilitaryRequestModel _militaryRequestModel = Provider.of<MilitaryRequestModel>(context, listen: false);
    return GetBuilder<KzmLKController>(
      id: id,
      builder: (KzmLKController _) {
        return KzmContentShadow(
          title: S.current.military,
          action: (model.military?.isEmpty ?? false)
              ? GestureDetector(
                  onTap: () => _militaryRequestModel.getRequestDefaultValue(),
                  child: KzmIcons.add,
                )
              : null,
          child: (model.military == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.military.map(
                      (TsadvMilitaryForm e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.militaryDocumentType?.instanceName,
                            // subtitle: '${formatFullNotMilSec(e.dateFrom)} - ${formatFullNotMilSec(e.dateTo)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.militaryAttitudeToMilitary,
                                textValue: e.attitudeToMilitary?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.militaryDocumentNumber,
                                textValue: e.documentNumber,
                              ),
                              FieldBones(
                                placeholder: S.current.militaryMilitaryType,
                                textValue: e.militaryType?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.militarySuitabilityToMilitary,
                                textValue: e.suitabilityToMilitary?.instanceName,
                              ),
                              // FieldBones(
                              //   placeholder: S.current.militaryUdo,
                              //   textValue: e.udo?.instanceName,
                              // ),
                              FieldBones(
                                placeholder: S.current.militaryMilitaryRank,
                                textValue: e.militaryRank?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.militaryOfficerType,
                                textValue: e.officerType?.instanceName,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _militaryRequestModel.openRequestById(e.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: Styles.appQuadMargin),
                  ],
                ),
        );
      },
    );
  }
}
