
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/collective_payment/collective_model.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/collective_payment_model.dart';
import 'package:provider/provider.dart';

class CollectivePageEdit extends StatefulWidget {
  const CollectivePageEdit({Key key}) : super(key: key);

  @override
  State<CollectivePageEdit> createState() => _CollectivePageEditState();
}

class _CollectivePageEditState extends State<CollectivePageEdit> {

  @override
  Widget build(BuildContext context) {
    final CollectivePaymentModel model = Provider.of<CollectivePaymentModel>(context);

    return Scaffold(
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pageTitle(title: '${S.current.request} ${model.request.requestNumber}'),
            if (model.isEditable) editField(model: model) else viewField(model: model),
            BpmTaskList<CollectivePaymentModel>(model),
            StartBpmProcess(
              model,
              hideCancel: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget editField({CollectivePaymentModel model}){
    return  KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            editable: false,
            placeholder: S.current.requestNumber,
            textValue: model.request?.requestNumber?.toString() ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.requestDate,
            leading: calendarWidgetForFormFiled,
            textValue: formatShortly(model.request.requestDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request.employee?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            icon: Icons.keyboard_arrow_down,
            placeholder: S.current.paymentType,
            textValue: model.request?.paymentType?.instanceName ?? '',
            selector: ()async{
              model.request.paymentType = await selector(
                entityName: 'kzm_DicPaymentType',
                fromMap: (Map<String, dynamic> json) => AbstractDictionary.fromMap(json),
                isPopUp: true,
              ) as AbstractDictionary;

              model.request.paymentAmount = model.request.paymentType.amount;
              model.request.beneficiary = null;
              model.request.relationType = null;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.paymentAmount,
            textValue: model.request?.paymentAmount?.toInt()?.toString() ?? '',
          ),
          FieldBones(
            isRequired: false,
            icon: Icons.keyboard_arrow_down,
            placeholder: S.current.fioRelative,
            textValue: model.request?.beneficiary?.personGroupChild?.instanceName ?? '',
            selector: ()async{
              model.request.beneficiary = await selector(
                entityName: 'tsadv\$Beneficiary',
                methodName: 'search',
                fromMap: (Map<String, dynamic> json) => Beneficiary.fromMap(json),
                filter: CubaEntityFilter(
                  view: 'beneficiary-edit',
                  returnCount: true,
                  filter: Filter(
                    conditions: <FilterCondition>[
                      FilterCondition(property: 'personGroupParent.id', conditionOperator: Operators.equals, value: model.pgId),
                      FilterCondition(property: 'relationshipType.closeRelative', conditionOperator: Operators.equals, value: 'true'),
                    ],
                  ),
                ),
                isPopUp: true,
              ) as Beneficiary;
              model.request.relationType = model.request.beneficiary.relationshipType;
              model.setBusy(false);
            },
          ),
          Text(S.current.relativeText, style: Styles.mainTS.copyWith(fontSize: 15.w, color:  Styles.appYellowButtonBorderColor),),
          FieldBones(
            editable: false,
            placeholder: S.current.relationType,
            textValue: model.request?.relationType?.instanceName ?? '',
          ),
          FilesWidget<CollectivePaymentModel>(
            model: model,
            isRequired: true,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }


  Widget viewField({CollectivePaymentModel model}){
    return  KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            editable: false,
            placeholder: S.current.requestNumber,
            textValue: model.request.requestNumber.toString(),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.requestDate,
            leading: calendarWidgetForFormFiled,
            textValue: formatShortly(model.request.requestDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request.employee?.instanceName ?? '',
          ),
          FieldBones(
            isRequired: true,
            editable: false,
            placeholder: S.current.paymentType,
            textValue: model.request?.paymentType?.instanceName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.paymentAmount,
            textValue: model.request?.paymentAmount?.toInt()?.toString() ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.fioRelative,
            textValue: model.request?.beneficiary?.personGroupChild?.fullName ?? '',
          ),
          Text(S.current.relativeText, style: Styles.mainTS.copyWith(fontSize: 15.w, color:  Styles.appYellowButtonBorderColor),),
          FieldBones(
            editable: false,
            placeholder: S.current.relationType,
            textValue: model.request?.relationType?.instanceName ?? '',
          ),
          FilesWidget<CollectivePaymentModel>(
            model: model,
            isRequired: true,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}