import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_person_awards_degrees.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/awards_degrees/award_degrees_request_model.dart';
import 'package:provider/provider.dart';

class AwardsDegrees extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const AwardsDegrees({
    @required this.id,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final AwardDegreesRequestModel _awardDegreesRequestModel = Provider.of<AwardDegreesRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.awardsDegrees,
      action: GestureDetector(
        onTap: () => _awardDegreesRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.awardsDegrees == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.awardsDegrees.map(
                      (TsadvPersonAwardsDegrees e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.instanceName,
                            subtitle: '${formatFullNotMilSec(e.startDate)} - ${formatFullNotMilSec(e.endDate)}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.awardsDegreesType,
                                textValue: e.type?.instanceName,
                              ),
                              FieldBones(
                                placeholder: S.current.awardsDegreesKind,
                                textValue: e.kind?.instanceName,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
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
