import 'package:hive/hive.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/models/util_models.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/app_settings_model.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsModel extends BaseModel {
  RegExp match = RegExp(
    r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&##/%=~_|!:,.;]*)?(\?[A-Z0-9+&##/%=~_|!:‌​,.;]*)?',
    caseSensitive: false,
  );
  String password;
  String newPassword;
  String newPasswordCopy;
  String url;

  void saveUrl() async {
    final settings = await Hive.openBox('settings');
    if (url == null) {
      GlobalNavigator().errorBar(title: S().error);
      return;
    }
    await settings.put('url', url);
    Kinfolk().initializeBaseVariables(
        url == 'default' ? endpointUrls[currentBuild] : url, 'tsadv-XHTr0e8J', '0d2d8d1f1402d357f27aaf63cd5411224ea8e3c3a326172270de6e249ce6c54c');
    endpointUrls[currentBuild] = url =='default' ? endpointUrls[currentBuild] : url;
    GlobalNavigator.pop();
    GlobalNavigator.doneSnackbar(S().success);
  }

  Future exit(AppSettingsModel userModel, {String newUrl}) async {
    userModel.exit = true;
    userModel.setBusy(false);
    final Box settings = await HiveUtils.getSettingsBox();
    await settings.clear();
    if (url != null) {
      settings.put('url', url);
    }
    // await Get.offAndToNamed('/login');
    Navigator.pushNamed(navigatorKey.currentContext, KzmPages.login);
  }

  Future<void> changePassword() async {
    final AppSettingsModel viewModel = Provider.of<AppSettingsModel>(navigatorKey.currentContext, listen: false);
    if (newPassword != newPasswordCopy) {
      GlobalNavigator().errorBar(title: 'Новые пароли должны совпадать');
      return;
    }
    final BaseResult result = await RestServices.changePassword(password, newPassword);
    print(result);
    if (result == null || !result.success) {
      GlobalNavigator().errorBar(title: result?.errorDescription ?? 'Error');
      return;
    }
    await exit(viewModel);
  }
}
