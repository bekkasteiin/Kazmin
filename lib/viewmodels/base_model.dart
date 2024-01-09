import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/requests.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/pageviews/notifications/default_form.dart';

const String fName = 'lib/viewmodels/base_model.dart';

class BaseModel with ChangeNotifier {
  bool _busy = false;
  bool _loaderOpen = false;
  bool isSilent = false;

  bool get busy => _busy;

  void setBusy([bool val = false]) {
    _busy = val;
    if (_busy) {
      _loaderOpen = true;
      if (!isSilent) {
        GlobalNavigator.showLoadingDialog();
      }
    }
    if (!_busy && _loaderOpen) {
      _loaderOpen = false;
      if (!isSilent) {
        GlobalNavigator.pop();
      }
    }
    notifyListeners();
  }

  void rebuild() => notifyListeners();

  static Future<void> showAttention({@required String middleText}) async {
    GlobalNavigator.defultShowDialog(middleText: middleText);
  }

  void showSnacbar(String content, {bool succsses = true}) {
    Get.showSnackbar(
      GetBar(
        message: content,
        duration: const Duration(seconds: 3),
        icon: Icon(
          succsses ? Icons.check : Icons.error_outline_rounded,
          color: Styles.appWhiteColor,
        ),
        mainButton: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              'ОК',
              style: Styles.mainTS.copyWith(color: Styles.appWhiteColor),
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        borderRadius: 8.w,
        backgroundColor: succsses ? Styles.appSuccessColor : Styles.appErrorColor,
        // leftBarIndicatorColor: Styles.k_error_color,
      ),
    );
  }

  Future<void> openRequestByID({
    @required String name,
    @required String id,
    @required BuildContext context,
    // void Function() refreshData,
  }) async {
    // log('-->> $fName, openRequestByID ->> name: $name, id: $id');
    dynamic openModel;
    openModel = kzmRequests.containsKey(name) ? kzmRequests[name](ctx: context) : null;
    if (openModel != null) {
      // (openModel as AbstractBpmModel).refr = refreshData;
      // log('-->> $fName, 12345654321 ->> ${(openModel as AbstractBpmModel).refr}');
      await openModel.openRequestById(id, isRequestID: true);
    } else {
      Get.to(() => const DefaultFormForTask(isTask: true));
    }
  }
}
