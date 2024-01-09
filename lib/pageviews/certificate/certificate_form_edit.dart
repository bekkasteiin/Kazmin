import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/bpm_helpers/dialog/start_bpm_process.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';

class CertificateFormView extends StatefulWidget {
  @override
  _CertificateFormViewState createState() => _CertificateFormViewState();
}

class _CertificateFormViewState extends State<CertificateFormView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController copyAmountController = TextEditingController(text: '1');
  bool _isOnHandRecieve = false;
  bool _showSalary = false;
  String chosenLng = 'RU';
  bool isHasScan = false;
  String certificateTypeCode = 'CERTIFICATE_OF_EMPLOYMENT';

  @override
  Widget build(BuildContext context) {
    return Consumer<CertificateModel>(
      builder: (BuildContext context, CertificateModel model, Widget l) {
        if (model.isVcmCompany) {
          _isOnHandRecieve = true;
        }
        return Scaffold(
          key: _scaffoldKey,
          // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
          // appBar: AppBar(
          //   flexibleSpace: appBarBg(context),
          //   title: BrandLogo(),
          //   centerTitle: false,
          // ),
          appBar: KzmAppBar(context: context),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  pageTitle(title: S.current.jclRequest),
                  infoPanel(model: model),
                  actions(model: model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget infoPanel({@required CertificateModel model}) {
    var size = MediaQuery.of(context).size;
    return contentShadow(
      // title: "Общие сведения",
      child: Column(
        children: [
          FieldBones(
            placeholder: S.current.requestNumber,
            textValue: model.request?.requestNumber.toString() ?? '',
          ),
          FieldBones(
              placeholder: S.current.status,
              textValue: model.request?.status?.instanceName ?? ''),
          FieldBones(
            dateField: true,
            placeholder: S.current.requestDate,
            textValue: model.request?.requestDate == null
                ? '__ ___, _____'
                : formatShortly(model.request?.requestDate),
          ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.referenceType,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            iconAlignEnd: true,
            textValue: model.request?.certificateType?.instanceName ?? ' ',
            selector: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              elevation: 0.6,
              isDismissible: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.w),
                  topRight: Radius.circular(16.w),
                ),
              ),
              backgroundColor: Colors.white,
              builder: (_) => Container(
                color: Colors.transparent,
                height: size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w),
                      child: Container(
                        height: 5.h,
                        width: size.width / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: Styles.appBrightBlueColor.withOpacity(0.4),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Styles.appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        S.current.referenceType,
                        style: Styles.mainTS
                            .copyWith(color: Styles.appDarkGrayColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (_, int i) {
                            bool current = false;
                            if (model.request?.certificateType != null) {
                              current = model.certificateTypes[i].id ==
                                  model.request?.certificateType.id;
                            }
                            return Container(
                              color: Styles.appWhiteColor,
                              child: InkWell(
                                child: SelectItem(
                                  model.certificateTypes[i].instanceName ?? '',
                                  current,
                                ),
                                onTap: () => setState(() {
                                  if (!current) {
                                    model.request?.certificateType =
                                        model.certificateTypes[i];
                                    setState(() {});
                                    GlobalNavigator.pop();
                                  }
                                }),
                              ),
                            );
                          },
                          separatorBuilder: (_, int index) => const SizedBox(),
                          itemCount: model.certificateTypes?.length ?? 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (model.isVcmCompany == false)
            FieldBones(
              isRequired: true,
              placeholder: S.current.obtainType,
              hintText: S.current.select,
              textValue: model.request?.receivingType?.instanceName ?? ' ',
              icon: Icons.keyboard_arrow_down,
              iconAlignEnd: true,
              selector: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                elevation: 0.6,
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.w),
                    topRight: Radius.circular(16.w),
                  ),
                ),
                backgroundColor: Colors.white,
                builder: (_) => Container(
                  color: Colors.transparent,
                  height: size.height * 0.4,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        child: Container(
                          height: 5.h,
                          width: size.width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: Styles.appBrightBlueColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Styles.appWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          S.current.obtainType,
                          style: Styles.mainTS
                              .copyWith(color: Styles.appDarkGrayColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (_, int i) {
                              bool current = false;
                              if (model.request?.receivingType != null) {
                                current = model.receivingTypes[i].id ==
                                    model.request?.receivingType.id;
                              }
                              return Container(
                                color: Styles.appWhiteColor,
                                child: InkWell(
                                  child: SelectItem(
                                    model.receivingTypes[i].instanceName ?? '',
                                    current,
                                  ),
                                  onTap: () => setState(() {
                                    if (!current) {
                                      model.request?.receivingType =
                                      model.receivingTypes[i];
                                      setState(() {});
                                      GlobalNavigator.pop();
                                    }
                                  }),
                                ),
                              );
                            },
                            separatorBuilder: (_, int index) => const SizedBox(),
                            itemCount: model.receivingTypes?.length ?? 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).then(
                (value) => setState(() {
                  print(model.request?.receivingType?.code);
                  if (model.request?.receivingType?.code == 'SCAN_VERSION') {
                    isHasScan = true;
                  } else {
                    isHasScan = false;
                  }
                  setState(() {});
                }),
              ),
            )
          else
            FieldBones(
              isRequired: true,
              placeholder: S.current.obtainType,
              textValue: model.request?.receivingType?.instanceName ?? '',
            ),
          FieldBones(
            isRequired: true,
            placeholder: S.current.language,
            hintText: S.current.select,
            icon: Icons.keyboard_arrow_down,
            iconAlignEnd: true,
            selector: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              elevation: 0.6,
              isDismissible: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.w),
                  topRight: Radius.circular(16.w),
                ),
              ),
              backgroundColor: Colors.white,
              builder: (_) => Container(
                color: Colors.transparent,
                height: size.height * 0.4,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w),
                      child: Container(
                        height: 5.h,
                        width: size.width / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: Styles.appBrightBlueColor.withOpacity(0.4),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Styles.appWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        S.current.language,
                        style: Styles.mainTS
                            .copyWith(color: Styles.appDarkGrayColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (_, int i) {
                            bool current = false;
                            if (model.request?.language != null) {
                              current = model.languages[i].id ==
                                  model.request?.language.id;
                            }
                            return Container(
                              color: Styles.appWhiteColor,
                              child: InkWell(
                                child: SelectItem(
                                  model.languages[i].instanceName ?? '',
                                  current,
                                ),
                                onTap: () => setState(() {
                                  if (!current) {
                                    model.request?.language =
                                    model.languages[i];
                                    setState(() {});
                                    GlobalNavigator.pop();
                                  }
                                }),
                              ),
                            );
                          },
                          separatorBuilder: (_, int index) => const SizedBox(),
                          itemCount: model.languages?.length ?? 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            textValue: model.request?.language?.instanceName ?? '',
          ),
          if (!model?.isVcmCompany)
            KzmCheckboxListTile(
              value: _showSalary,
              onChanged: (bool newVal) {
                setState(() {
                  model.request?.showSalary = _showSalary = newVal;
                });
              },
              title: Text(S.current.displaySalary),
            ),
          if (!isHasScan && model.request?.receivingType?.code !=null)
            FieldBones(
              keyboardType: TextInputType.number,
              isTextField: true,
              placeholder: S.current.numberOfCopies,
              onChanged: (String val) {
                if(val!='') {
                  model?.request?.numberOfCopy = int.parse(val);
                }
                else
                {
                  model?.request?.numberOfCopy = 1;
                }
              },
              textValue: model.request?.numberOfCopy?.toString() ?? '',
            ),
          if (!isHasScan && model.request?.receivingType?.code !=null)
            FieldBones(
              isTextField: true,
              placeholder: S.current.additionalReqsforDoc,
              onChanged: (String val) {
                model?.request?.additionalRequirements = val;
              },
              textValue: model.request?.additionalRequirements?.toString() ?? '',
            ),
        ],
      ),
    );
  }

  Widget actions({@required CertificateModel model}) {
    return isHasScan
        ? CancelAndSaveButtons(
            saveText: S.current.getCertificate,
            onTapCancel: model.busy
                ? null
                : () {
                    Get.back();
                  },
            onTapSave: model.busy
                ? null
                : () async {
                    await model.saveForScanVersion();
                  },
          )
        : StartBpmProcess(model);
  }
}
