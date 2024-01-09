//@dart=2.18
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_person_document.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/documents/document_request_model.dart';
import 'package:provider/provider.dart';

class Documents extends StatelessWidget {
  final UniqueKey id;
  final KzmLKModel model;

  const Documents({
    required this.id,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final PersonDocumentRequestModel personDocumentRequestModel =
        Provider.of<PersonDocumentRequestModel>(context, listen: false);
    return KzmContentShadow(
      title: S.current.documents,
      action: GestureDetector(
        onTap: () => personDocumentRequestModel.getRequestDefaultValue(),
        child: KzmIcons.add,
      ),
      child: GetBuilder<KzmLKController>(
        id: id,
        builder: (KzmLKController _) {
          return (model.personDocuments == null)
              ? const LoaderWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...model.personDocuments!.map(
                      (TsadvPersonDocument e) => Padding(
                        padding: EdgeInsets.only(bottom: Styles.appQuadMargin),
                        child: KzmContentShadow(
                          hideMargin: true,
                          bottomPadding: 0,
                          child: KzmExpansionTile(
                            title: e.documentType.langValue,
                            // subtitle:
                            //     '${(e?.issueDate != null) ? formatFullNotMilSec(dateFormatFullRestNotMilSec.parse(e.issueDate)) : ''} - ${(e?.expiredDate != null) ? formatFullNotMilSec(dateFormatFullRestNotMilSec.parse(e.expiredDate)) : ''}',
                            children: <Widget>[
                              FieldBones(
                                placeholder: S.current.documentType,
                                textValue: e.documentType.langValue,
                              ),
                              FieldBones(
                                placeholder: S.current.issuingAuthority,
                                textValue: e.issuingAuthority?.langValue,
                              ),
                              FieldBones(
                                placeholder: S.current.issuingAuthorityExpats,
                                textValue: e.issuedBy ?? '',
                              ),
                              FieldBones(
                                placeholder: S.current.validFromDate,
                                textValue: e.issueDate == null
                                    ? ''
                                    : formatShortly(
                                        DateTime.parse(e.issueDate),
                                      ),
                              ),
                              FieldBones(
                                placeholder: S.current.validToDate,
                                textValue: e.expiredDate == null
                                    ? ''
                                    : formatShortly(
                                        DateTime.parse(e.expiredDate),
                                      ),
                              ),
                              FieldBones(
                                placeholder: S.current.documentNumber,
                                textValue: e.documentNumber,
                              ),
                              SizedBox(height: Styles.appQuadMargin),
                              //KzmOutlinedBlueButton(
                              //  caption: S.current.editText,
                              //  enabled: true,
                              //  onPressed: () => personDocumentRequestModel
                              //      .openRequestById(e.id),
                              //),
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
