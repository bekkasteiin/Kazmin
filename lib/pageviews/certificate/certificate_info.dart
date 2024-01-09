import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/bpm_helpers/task/task_list.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';

class CertificateInfoPage extends StatefulWidget {
  @override
  _CertificateInfoPageState createState() => _CertificateInfoPageState();
}

class _CertificateInfoPageState extends State<CertificateInfoPage> {
  @override
  Widget build(BuildContext context) {
    final CertificateModel model = Provider.of<CertificateModel>(context);
    print(model.request.receivingType.code);
    return Scaffold(
      // appBar: defaultAppBar(context),
      appBar: KzmAppBar(context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pageTitle(title: S.current.jclRequest),
              infoPanel(model: model),
              BpmTaskList(model),
              StartBpmProcess(model, disableSaveButton: model.request.receivingType.code == 'SCAN_VERSION',)
            ],
          ),
        ),
      ),
    );
  }

  Widget infoPanel({@required CertificateModel model}) {
    return KzmContentShadow(
      child: Column(
        children: [
          FieldBones(
            placeholder: 'Номер заявки',
            textValue: model.request?.requestNumber.toString(),
          ),
          FieldBones(
            placeholder: 'Статус',
            textValue: model.request?.status?.instanceName ?? '',
          ),
          FieldBones(
            leading: calendarWidgetForFormFiled,
            placeholder: 'Дата заявки',
            textValue: formatShortly(model.request?.requestDate),
          ),
          FieldBones(
            placeholder: 'Способ получения',
            textValue: model.request?.receivingType?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: 'Тип справки',
            textValue: model.request?.certificateType?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: 'Язык',
            textValue: model.request?.language?.instanceName ?? '',
          ),
          FieldBones(
            placeholder: S.current.displaySalary,
            textValue: model.request.showSalary ? 'Да' : 'Нет',
          ),
          if (model.request?.receivingType?.code == 'ON_HAND')
            FieldBones(
              editable: false,
              placeholder: S.current.numberOfCopies,
              isTextField: true,
              textValue: model.request?.numberOfCopy?.toString() ?? '',
            ),
          if (model.request?.receivingType?.code == 'ON_HAND')
            FieldBones(
              editable: false,
              placeholder: S.current.additionalReqsforDoc,
              isTextField: true,
              textValue: model.request?.additionalRequirements?.toString() ?? '',
            )
        ],
      ),
    );
  }
}
