//@dart=2.18
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_person_education.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/education/education_request_model.dart';
import 'package:provider/provider.dart';

const String fName = 'lib/pageviews/lk/main_data/items/education.dart';

class Education extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Education({
    required this.id,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final EducationRequestModel educationRequestModel =
        Provider.of<EducationRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.education,
      action: GestureDetector(
        onTap: () => educationRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.education == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...?model.education?.map(
                      (TsadvPersonEducation e) {
                        // log('-->> $fName, TsadvPersonEducation -->> e: ${e.toJson()}');
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: Styles.appQuadMargin),
                          child: KzmContentShadow(
                            hideMargin: true,
                            bottomPadding: 0,
                            child: KzmExpansionTile(
                              title: e.specialization,
                              // subtitle: '${e.startYear} - ${e.endYear}',
                              children: <Widget>[
                                FieldBones(
                                  placeholder: S.current.educationSchool,
                                  textValue: e.school,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationType,
                                  textValue: e.educationType?.instanceName,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationDiplomaNumber,
                                  textValue: e.diplomaNumber,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationFaculty,
                                  textValue: e.faculty,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationQualification,
                                  textValue: e.qualification,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationFormStudy,
                                  textValue: e.formStudy?.instanceName,
                                ),
                                FieldBones(
                                  placeholder: S.current.educationStartYear,
                                  textValue: e.startYear?.toString(),
                                ),
                                FieldBones(
                                  placeholder: S.current.educationEndYear,
                                  textValue: e.endYear?.toString(),
                                ),
                                SizedBox(height: Styles.appQuadMargin),
                                //KzmOutlinedBlueButton(
                                //  caption: S.current.editText,
                                //  enabled: true,
                                //  onPressed: () => educationRequestModel
                                //      .openRequestById(e.id),
                                //),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // SizedBox(height: Styles.appQuadMargin),
                  ],
                );
        },
      ),
    );
  }
}
