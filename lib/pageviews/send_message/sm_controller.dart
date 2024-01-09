import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/components/widgets/snackbar.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/answer_data.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/send_message/misc/sm_ids.dart';
import 'package:kzm/pageviews/send_message/misc/sm_services.dart';
import 'package:kzm/pageviews/send_message/sm_model.dart';

const String fName = 'lib/pageviews/send_message/sm_controller.dart';

class KzmSendMessageController extends GetxController {
  KzmSendMessageModel model = Get.find<KzmSendMessageModel>();
  final KzmSendMessageServices _services = Get.find<KzmSendMessageServices>();

  @override
  void onInit() {
    _modelCategoriesLoad();
    _modelTypesLoad();
    super.onInit();
  }

  Future<List<String>> get companiesList => _services.getCompanies();

  Future<void> _modelCategoriesLoad() async {
    model.categories = await _services.getCategories();
    update(<String>[KzmSendMessageIDs.categories]);
  }

  Future<void> _modelTypesLoad() async {
    model.types = await _services.getTypes();
    update(<String>[KzmSendMessageIDs.types]);
  }

  void categoriesOnChanged({@required KzmCommonItem val}) {
    model.categorySelected = val;
    update(<String>[KzmSendMessageIDs.categories]);
    _changeButtonStatus();
  }

  void typeOnChanged({@required KzmCommonItem val}) {
    model.typeSelected = val;
    update(<String>[KzmSendMessageIDs.types]);
    _changeButtonStatus();
  }

  void topicOnChanged(KzmAnswerData v) {
    if (v.value != model.topic) model.topic = v.value;
    _changeButtonStatus();
  }

  void textOnChanged(KzmAnswerData v) {
    if (v.value != model.text) model.text = v.value;
    _changeButtonStatus();
  }

  bool get isAllFieldsFilled =>
      (model.categorySelected?.id ?? '').isNotEmpty &&
      (model.typeSelected?.id ?? '').isNotEmpty &&
      (model.topic ?? '').isNotEmpty &&
      (model.text ?? '').isNotEmpty;

  void _changeButtonStatus() {
    if (isAllFieldsFilled != model.isButtonEnabled) {
      model.isButtonEnabled = !model.isButtonEnabled;
      update(<String>[KzmSendMessageIDs.button]);
    }
  }

  Future<void> pushAnswer() async {
    try {
      showBusy(busy: true);
      model.files = await _services.uploadFiles(files: model.files);
      if (model.isAllFilesUploaded) {
        final Box<dynamic> _settings = await HiveUtils.getSettingsBox();
        final Map<String, dynamic> userInfo = jsonDecode(_settings.get('info').toString()) as Map<String, dynamic>;
        final Map<String, dynamic> res = await _services.pushResults(
          body: <String, dynamic>{
            'user': <String, String>{'id': userInfo['id'].toString()},
            'portalFeedback': <String, String>{'id': model.categorySelected?.id},
            'type': <String, String>{'id': model.typeSelected?.id},
            'topic': model.topic,
            'text': model.text,
            'files': model.files.map((SysFileDescriptor e) => <String, String>{'id': e.id}).toList(),
          },
        );
        if (res.containsKey('id')) {
          Get.back();
          await KzmSnackbar(
            message: S.current.sendMessageSnackBarSuccessText,
            milliSeconds: 4000,
          ).show();
        } else {
          await KzmSnackbar(message: S.current.sendMessageSnackBarErrorText, autoHide: true).show();
        }
      }
    } finally {
      showBusy(busy: false);
    }
  }
}
