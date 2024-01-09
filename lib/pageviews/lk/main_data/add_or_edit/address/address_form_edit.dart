import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/file_utils/files_widget.dart';
import 'package:kzm/core/models/entities/base_dic_country.dart';
import 'package:kzm/core/models/entities/tsadv_dic_address_type.dart';
import 'package:kzm/core/models/entities/tsadv_dic_kato.dart';
import 'package:kzm/core/models/entities/tsadv_dic_street_type.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/address/address_request_model.dart';
import 'package:provider/provider.dart';

class AddressRequestFormEdit extends StatefulWidget {
  @override
  _AddressRequestFormEditState createState() => _AddressRequestFormEditState();
}

class _AddressRequestFormEditState extends State<AddressRequestFormEdit> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressRequestModel>(
      builder: (BuildContext context, AddressRequestModel model, _) {
        return Scaffold(
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                pageTitle(
                  title: S.current.addressCaption,
                ),
                fields(model: model),
                BpmTaskList<AddressRequestModel>(model),
                StartBpmProcess<AddressRequestModel>(model, hideCancel: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget fields({@required AddressRequestModel model}) {
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
            textValue: formatFullNotMilSec(dateFormatFullRestNotMilSec.parse(model.request?.requestDate)),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.status,
            textValue: model.request?.status?.langValue,
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employee,
            // textValue: model.personExt?.first?.instanceName,
            textValue: model.request?.employee?.instanceName,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: true,
            placeholder: S.current.dateFrom,
            textValue: model.request?.startDate == null ? '__ ___, _____' : formatShortly(model.request?.startDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.startDate = newDT;
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
            isRequired: true,
            placeholder: S.current.dateTo,
            textValue: model.request?.endDate == null ? '__ ___, _____' : formatShortly(model.request?.endDate),
            selector: () => DateTimeSelector(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDT) {
                model.request?.endDate = newDT;
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
            placeholder: S.current.addressType,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.addressType?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.addressType = await selector(
                entity: model.request.addressType,
                entityName: 'tsadv\$DicAddressType',
                fromMap: (Map<String, dynamic> json) => TsadvDicAddressType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicAddressType;
              model.setBusy(false);
            },
            isRequired: true,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.postalCode,
            // isTextField: !model.historyExists,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.postalCode,
            onChanged: (String data) => model.request.postalCode = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.addressCountry,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.country?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.country = await selector(
                entity: model.request.country,
                entityName: 'base\$DicCountry',
                fromMap: (Map<String, dynamic> json) => BaseDicCountry.fromMap(json),
                filter: CubaEntityFilter(
                  view: '_local',
                  sortType: SortTypes.desc,
                  sort: 'langValue1',
                  returnCount: true,
                  filter: Filter(
                    conditions: <FilterCondition>[
                      FilterCondition(
                        property: 'active',
                        conditionOperator: Operators.equals,
                        value: 'TRUE',
                      ),
                    ],
                  ),
                ),
                isPopUp: true,
              ) as BaseDicCountry;
              model.setBusy(false);
              setState(() {});
            },
            isRequired: true,
          ),
          FieldBones(
            editable: model.isEditable,
            isRequired: model.isKATORequired,
            placeholder: S.current.addressKATOCode,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.kato?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.kato = await selector(
                entity: model.request.kato,
                entityName: 'tsadv_DicKato',
                fromMap: (Map<String, dynamic> json) => TsadvDicKato.fromMap(json),
                useFilterByProperty: 'langValue1',
                isPopUp: true,
              ) as TsadvDicKato;
              model.setBusy(false);
            },
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.addressStreetType,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            textValue: model.request?.streetType?.instanceName,
            maxLinesSubTitle: 2,
            selector: () async {
              model.setBusy(true);
              model.request.streetType = await selector(
                entity: model.request.streetType,
                entityName: 'tsadv_DicStreetType',
                fromMap: (Map<String, dynamic> json) => TsadvDicStreetType.fromMap(json),
                isPopUp: true,
              ) as TsadvDicStreetType;
              model.setBusy(false);
            },
            isRequired: true,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.street,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.streetName,
            onChanged: (String data) => model.request.streetName = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.homeNum,
            isTextField: model.isEditable,
            keyboardType: TextInputType.number,
            textValue: model.request?.building,
            onChanged: (String data) => model.request.building = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.homeBlock,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.block,
            onChanged: (String data) => model.request.block = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.kv,
            isTextField: model.isEditable,
            keyboardType: TextInputType.number,
            textValue: model.request?.flat,
            onChanged: (String data) => model.request.flat = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.adressExpats,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.addressForExpats,
            onChanged: (String data) => model.request.addressForExpats = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.adressKZ,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.addressKazakh,
            onChanged: (String data) => model.request.addressKazakh = data,
          ),
          FieldBones(
            editable: model.isEditable,
            placeholder: S.current.adressENG,
            isTextField: model.isEditable,
            keyboardType: TextInputType.text,
            textValue: model.request?.addressEnglish,
            onChanged: (String data) => model.request.addressEnglish = data,
          ),
          FieldBones(
            editable: model.isEditable,
            maxLines: 3,
            placeholder: S.current.mark,
            isTextField: model.isEditable,
            keyboardType: TextInputType.multiline,
            textValue: model.request?.comment,
            onChanged: (String data) => model.request.comment = data,
          ),
          FilesWidget<AddressRequestModel>(
            model: model,
            // editable: !model.historyExists,
            editable: model.isEditable,
          ),
        ],
      ),
    );
  }
}

//44586
