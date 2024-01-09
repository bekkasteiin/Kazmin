import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_person_qualification.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/qualification/qualification_request_model.dart';
import 'package:provider/provider.dart';

class Qualification extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Qualification({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final QualificationRequestModel _qualificationRequestModel = Provider.of<QualificationRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.qualification,
      action: GestureDetector(
        onTap: () => _qualificationRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.qualification == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.qualification.map(
                      (TsadvPersonQualification e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.qualification,
                            subtitle: '${formatFullNotMilSec(e.startDate)} - ${formatFullNotMilSec(e.endDate)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.qualificationEducationalInstitutionName,
                                textValue: e.educationalInstitutionName,
                              ),
                              FieldBones(
                                placeholder: S.current.qualificationDiploma,
                                textValue: e.diploma,
                              ),
                              FieldBones(
                                placeholder: S.current.qualificationIssuedDate,
                                textValue: formatShortly(e.issuedDate),
                                leading: KzmIcons.date,
                              ),
                              FieldBones(
                                placeholder: S.current.educationCourseName,
                                textValue: e.courseName,
                              ),
                              FieldBones(
                                placeholder: S.current.qualificationProfession,
                                textValue: e.profession,
                              ),
                              FieldBones(
                                placeholder: S.current.educationDocumentType,
                                textValue: e.educationDocumentType?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.educationExpiryDate,
                                textValue: formatShortly(e.expiryDate),
                                leading: KzmIcons.date,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _qualificationRequestModel.openRequestById(e.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: Styles.appQuadMargin),
                  ],
                );
        },
      ),
    );
  }
}
