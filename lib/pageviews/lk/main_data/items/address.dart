//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_address.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_request_model.dart';
import 'package:provider/provider.dart';

class Address extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Address({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final AddressRequestModel _addressRequestModel =
        Provider.of<AddressRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.adress,
      action: GestureDetector(
        onTap: () => _addressRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.address == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.address.map(
                      (TsadvAddress e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.addressType?.instanceName,
                            // subtitle: '${formatFullNotMilSec(e.startDate)} - ${formatFullNotMilSec(e.endDate)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.addressPostalCode,
                                textValue: e.postalCode,
                              ),
                              FieldBones(
                                placeholder: S.current.addressCountry,
                                textValue: e.country?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.addressKATO,
                                textValue: e.kato?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.addressStreetType,
                                textValue: e.streetType?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.street,
                                textValue: e.streetName ?? '',
                              ),
                              FieldBones(
                                placeholder: S.current.homeNum,
                                textValue: e.building ?? '',
                              ),
                              FieldBones(
                                placeholder: S.current.homeBlock,
                                textValue: e.block,
                              ),
                              FieldBones(
                                placeholder: S.current.kv,
                                textValue: e.flat,
                              ),
                              FieldBones(
                                placeholder: S.current.dateFrom,
                                textValue: formatShortly(e.startDate),
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              KzmOutlinedBlueButton(
                                caption: S.current.editText,
                                enabled: true,
                                onPressed: () => _addressRequestModel.openRequestById(e.id),
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
