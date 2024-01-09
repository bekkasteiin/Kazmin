import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/files_loader_no_bpm.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/screen.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/tsadv_dic_portal_feedback_type.dart';
import 'package:kzm/core/models/entities/tsadv_portal_feedback.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/pageviews/send_message/misc/sm_ids.dart';
import 'package:kzm/pageviews/send_message/sm_controller.dart';

const String fName = 'lib/pageviews/send_message/sm_view.dart';

class KzmSendMessageView extends GetView<KzmSendMessageController> {
  TsadvPortalFeedback feedback = TsadvPortalFeedback();
  @override
  Widget build(BuildContext context) {
    return KzmScreen(
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(context: context),
      body: KzmContentShadow(
        title: S.current.sendMessage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GetBuilder<KzmSendMessageController>(
              id: KzmSendMessageIDs.categories,
              builder: (_) => FieldBones(
                placeholder: S.current.category,
                hintText: S.current.select,
                icon: Icons.keyboard_arrow_down,
                textValue: controller.model?.categorySelected?.text,
                maxLinesSubTitle: 2,
                selector: () async {
                  final TsadvPortalFeedback feedback = await selector(
                    entity: controller.model?.categorySelected,
                    entityName: 'tsadv_PortalFeedback',
                    filter: CubaEntityFilter(
                      view: 'portalFeedback-portal',
                      filter: Filter(
                        conditions: <FilterCondition>[
                          FilterCondition(
                            property: 'company.id',
                            conditionOperator: Operators.inList,
                            value: await controller.companiesList,
                          ),
                        ],
                      ),
                    ),
                    fromMap: (Map<String, dynamic> json) {
                      return TsadvPortalFeedback.fromMap(json);
                    },
                    isPopUp: true,
                  ) as TsadvPortalFeedback;
                  controller.categoriesOnChanged(
                    val: KzmCommonItem(
                      id: feedback?.id,
                      text: feedback?.instanceName,
                    ),
                  );
                },
                isRequired: true,
              ),
            ),
            // GetBuilder<KzmSendMessageController>(
            //   id: KzmSendMessageIDs.categories,
            //   builder: (_) => KzmComboInput(
            //     isRequired: true,
            //     caption: S.current.category,
            //     items: controller.model.categories,
            //     onChanged: controller.categoriesOnChanged,
            //   ),
            // ),

            GetBuilder<KzmSendMessageController>(
              id: KzmSendMessageIDs.types,
              builder: (_) => FieldBones(
                placeholder: S.current.messageType,
                hintText: S.current.select,
                icon: Icons.keyboard_arrow_down,
                textValue: controller.model?.typeSelected?.text,
                maxLinesSubTitle: 2,
                selector: () async {
                  final TsadvDicPortalFeedbackType feedbackType = await selector(
                    entity: controller.model?.typeSelected,
                    entityName: 'tsadv_DicPortalFeedbackType',
                    fromMap: (Map<String, dynamic> json) {
                      return TsadvDicPortalFeedbackType.fromMap(json);
                    },
                    isPopUp: true,
                  ) as TsadvDicPortalFeedbackType;
                  controller.typeOnChanged(
                    val: KzmCommonItem(
                      id: feedbackType?.id,
                      text: feedbackType?.instanceName,
                    ),
                  );
                },
                isRequired: true,
              ),
            ),
            // SizedBox(height: Styles.appQuadMargin),
            // GetBuilder<KzmSendMessageController>(
            //   id: KzmSendMessageIDs.types,
            //   builder: (_) => KzmComboInput(
            //     isRequired: true,
            //     caption: S.current.messageType,
            //     items: controller.model.types,
            //     onChanged: controller.typeOnChanged,
            //   ),
            // ),

            FieldBones(
              isRequired: true,
              placeholder: S.current.topic,
              isTextField: true,
              keyboardType: TextInputType.text,
              onChanged: (String data) {
                controller.topicOnChanged(KzmAnswerData(value: data, add: null));
              },
            ),
            // SizedBox(height: Styles.appQuadMargin),
            // KzmTextInput(
            //   caption: S.current.topic,
            //   initValue: '',
            //   isRequired: true,
            //   prefixIcon: null,
            //   keyboardType: null,
            //   maxLines: 1,
            //   onChanged: controller.topicOnChanged,
            // ),
            FieldBones(
              isRequired: true,
              maxLines: 3,
              placeholder: S.current.text,
              isTextField: true,
              keyboardType: TextInputType.multiline,
              onChanged: (String data) {
                controller.textOnChanged(KzmAnswerData(value: data, add: null));
              },
            ),
            // SizedBox(height: Styles.appQuadMargin),
            // KzmTextInput(
            //   height: Styles.appTextFieldMultilineHeight,
            //   maxLines: null,
            //   caption: S.current.text,
            //   initValue: '',
            //   isRequired: true,
            //   prefixIcon: null,
            //   keyboardType: null,
            //   onChanged: controller.textOnChanged,
            // ),
            // SizedBox(height: Styles.appQuadMargin),
            SizedBox(height: Styles.appDoubleMargin),
            KzmFilesLoaderNoBPM(files: controller.model.files),
          ],
        ),
      ),
      bottomSheet: GetBuilder<KzmSendMessageController>(
        id: KzmSendMessageIDs.button,
        builder: (_) => KzmOutlinedBlueButton(
          enabled: controller.model.isButtonEnabled,
          caption: S.current.ok,
          onPressed: controller.pushAnswer,
        ),
      ),
    );
  }

  selectContract(KzmSendMessageController model) {
    var size = MediaQuery.of(navigatorKey.currentContext).size;
    showModalBottomSheet(
      context: navigatorKey.currentContext,
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
        height: size.height * 0.8,
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
                S.current.category,
                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
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
                    if (feedback != null) {
                      current = model.model.feedbackList[i].id == feedback.id;
                    }
                    return Container(
                      color: Styles.appWhiteColor,
                      child: InkWell(
                        child: SelectItem(
                          model.model.feedbackList[i].instanceName ?? '',
                          current,
                        ),
                        onTap: (){
                          if (!current) {
                            feedback = model.model.feedbackList[i];
                            GlobalNavigator.pop();
                          }
                        }
                      ),
                    );
                  },
                  separatorBuilder: (_, int index) => const SizedBox(),
                  itemCount:model.model.feedbackList?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
