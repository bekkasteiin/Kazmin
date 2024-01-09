import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/tsadv_dic_phone_type.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/contact/contact_request_model.dart';
import 'package:provider/provider.dart';

class PersonContactRequestFormEdit extends StatefulWidget {
  @override
  _PersonContactRequestFormEditState createState() => _PersonContactRequestFormEditState();
}

class _PersonContactRequestFormEditState extends State<PersonContactRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonContactRequestModel>(
      builder: (BuildContext context, PersonContactRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.personContact,
                ),
                fields(model: model),
                BpmTaskList<PersonContactRequestModel>(model),
                StartBpmProcess<PersonContactRequestModel>(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required PersonContactRequestModel model}) {
    return KzmContentShadow(
      child: Column(
        children: <Widget>[
          FieldBones(
            editable: false,
            placeholder: S.current.requestNumber,
            textValue: model.request.requestNumber?.toString(),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.requestDate,
            textValue: formatFullNotMilSec(model.request?.requestDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.instanceName,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.startDate,
            textValue: model.request?.startDate == null ? '__ ___, _____' : formatShortly(model.request?.startDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.startDate = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.startDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.startDate != null
                ? () {
                    model.request?.startDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            // isRequired: true,
            placeholder: S.current.endDate,
            textValue: model.request?.endDate == null ? '__ ___, _____' : formatShortly(model.request?.endDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.endDate = newDT;
                // log('$newDT');
                setState(() {});
              },
            ),
            icon: KzmIcons.date.icon,
            iconColor: model.request?.endDate != null ? Colors.red : Styles.appCorporateColor,
            iconTap: model.request?.endDate != null
                ? () {
                    model.request?.endDate = null;
                    setState(() {});
                  }
                : null,
            iconAlignEnd: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.personContactPhoneType,
            textValue: model.request?.phoneType?.instanceName,
            selector: () async {
              model.setBusy(true);
              model.request.phoneType = await selector(
                entity: model.request.phoneType,
                entityName: 'tsadv\$DicPhoneType',
                fromMap: (Map<String, dynamic> json) => TsadvDicPhoneType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicPhoneType;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.personContactContactValue,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.contactValue,
            onChanged: (String data){
              model.request.contactValue = data;
            },
            // textValue: model.personExt.first.instanceName,
          ),
        ],
      ),
    );
  }
}

//44586
