import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/person_other_info/person_other_info_model.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class PersonOtherInfo extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const PersonOtherInfo({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final PersonOtherInfoRequestModel _personOtherInfoRequestModel = Provider.of<PersonOtherInfoRequestModel>(context, listen: false);
    return GetBuilder<KzmLKController>(
      id: id,
      builder: (KzmLKController _) {
        return KzmContentShadow(
          title: S.current.personExt,
          action: (model.personExt?.isEmpty ?? false)
              ? GestureDetector(
                  onTap: () => _personOtherInfoRequestModel.getRequestDefaultValue(),
                  child: KzmIcons.add,
                )
              : null,
          child: (model.personExt == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.personExt.map(
                      (BasePersonExt e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: S.current.childUnder,
                            // subtitle: '${formatFullNotMilSec(e.dateFrom)} - ${formatFullNotMilSec(e.dateTo)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.childUnderTo18,
                                textValue: kzmOverrideAllHoursByDay
                                    .firstWhere(
                                      (KzmCommonItem item) => item.id == (e.childUnder14WithoutFatherOrMother ?? 'NO'),
                                      orElse: () => null,
                                    )
                                    ?.text,
                              ),
                              FieldBones(
                                placeholder: S.current.childUnderTo14,
                                textValue: kzmOverrideAllHoursByDay
                                    .firstWhere(
                                      (KzmCommonItem item) => item.id == (e.childUnder18WithoutFatherOrMother ?? 'NO'),
                                      orElse: () => null,
                                    )
                                    ?.text,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _personOtherInfoRequestModel.openRequestById(e.id),
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
