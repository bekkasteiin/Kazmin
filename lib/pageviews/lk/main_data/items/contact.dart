import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_person_contact.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_request_model.dart';
import 'package:provider/provider.dart';

class Contact extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Contact({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final PersonContactRequestModel _personContactRequestModel = Provider.of<PersonContactRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.personContact,
      action: GestureDetector(
        onTap: () => _personContactRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.personContact == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.personContact.map(
                      (TsadvPersonContact e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.type?.instanceName,
                            // subtitle: '${formatFullNotMilSec(e.startDate)} - ${formatFullNotMilSec(e.endDate)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.personContactContactValue,
                                textValue: e.contactValue,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _personContactRequestModel.openRequestById(e.id),
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
