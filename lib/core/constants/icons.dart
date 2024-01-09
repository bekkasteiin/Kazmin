import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/constants/ui_design.dart';

class KzmIcons {
  KzmIcons._();

  static Icon person = Icon(Icons.person, color: Styles.appCorporateColor, size: Styles.appTextFieldIconSize);
  static Icon personGray = Icon(Icons.person, color: Styles.appBrightGrayColor, size: Styles.appTextFieldIconSize);
  static Icon phone = Icon(Icons.phone, color: Styles.appCorporateColor, size: Styles.appTextFieldIconSize);
  static Icon password = Icon(Icons.password, color: Styles.appCorporateColor, size: Styles.appTextFieldIconSize);
  static Icon lock = Icon(Icons.lock, color: Styles.appCorporateColor, size: Styles.appTextFieldIconSize);
  static Icon greyEye = Icon(Icons.remove_red_eye, color: Styles.appDarkGrayColor, size: Styles.appTextFieldIconSize);
  static Icon colorEye = Icon(Icons.remove_red_eye, color: Styles.appCorporateColor, size: Styles.appTextFieldIconSize);
  static Icon menu = const Icon(Icons.menu, color: Styles.appCorporateColor);
  static Icon settingsSolid = const Icon(CupertinoIcons.settings_solid, color: Styles.appCorporateColor);
  static Icon inactiveIndicator = const Icon(CupertinoIcons.circle, color: Styles.appCorporateColor);
  static Icon activeIndicator = const Icon(CupertinoIcons.circle_filled, color: Styles.appCorporateColor);
  static Icon question = const Icon(CupertinoIcons.question_square, color: Styles.appCorporateColor);
  static Icon back = const Icon(CupertinoIcons.back);
  static Icon next = const Icon(CupertinoIcons.chevron_right);
  static Icon down = Icon(CupertinoIcons.chevron_down, size: Styles.appComboArrowDownSize);
  static Icon sendMessageFilesListDelete = Icon(
    CupertinoIcons.delete_simple,
    color: Colors.red,
    size: Styles.appSendMessageFilesListDeleteIconWidth,
  );
  static Icon sendMessageFilesListDeleteInactive = Icon(
    CupertinoIcons.delete_simple,
    color: Styles.appDarkGrayColor,
    size: Styles.appSendMessageFilesListDeleteIconWidth,
  );
  static Icon sendMessageFilesListClip = Icon(
    CupertinoIcons.rectangle_paperclip,
    color: Styles.appCorporateColor,
    size: Styles.appSendMessageFilesListDeleteIconWidth,
  );
  static Icon edit = Icon(
    Icons.edit,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon date = Icon(
    Icons.calendar_today_outlined,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon dateSelected = Icon(
    Icons.calendar_today_outlined,
    color: Styles.appErrorColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon time = Icon(
    Icons.access_time_outlined,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon timeSelected = Icon(
    Icons.access_time_outlined,
    color: Styles.appErrorColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon done = Icon(
    Icons.done_outlined,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSize,
  );
  static Icon addFile = Icon(
    Icons.add,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSizeMin,
  );
  static Icon addFileInactive = Icon(
    Icons.add,
    color: Styles.appDarkGrayColor,
    size: Styles.appTextFieldIconSizeMin,
  );
  static Icon add = Icon(
    Icons.add_circle_outline,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSizeMin,
  );
  static Icon addInactive = Icon(
    Icons.add_circle_outline,
    color: Styles.appDarkGrayColor,
    size: Styles.appTextFieldIconSizeMin,
  );
  static Icon uploadFile = Icon(
    Icons.file_upload_outlined,
    color: Styles.appBrightGrayColor,
    size: Styles.appSendMessageFilesListRowHeight,
  );
  static Icon downArrow = Icon(
    Icons.arrow_circle_down_outlined,
    color: Styles.appCorporateColor,
    size: Styles.appTextFieldIconSelectedSize,
  );
  static Icon downArrowInactive = Icon(
    Icons.arrow_circle_down_outlined,
    color: Styles.appDarkGrayColor,
    size: Styles.appTextFieldIconSelectedSize,
  );
}
