import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Styles {
  //FontFamily
  static TextStyle mainTS = GoogleFonts.rubik().copyWith(
    color: appDarkBlackColor,
    fontSize: appDefaultFontSize,
  );
  static TextStyle textFieldTS = GoogleFonts.rubik().copyWith(
    color: appDarkBlackColor,
    fontSize: appDefaultFontSize,
  );
  static TextStyle textFieldHintTS = GoogleFonts.rubik().copyWith(
    color: appDarkBlackHintColor,
    fontSize: appDefaultFontSize,
  );
  static TextStyle cardTS = GoogleFonts.rubik().copyWith(
    color: appDarkBlackColor,
    fontSize: appSubtitleFontSize,
  );
  static TextStyle advertsText = GoogleFonts.rubik().copyWith(
    color: appTitleField,
    fontSize: appAdvertsFontSize,
  );
  static TextStyle questionText = GoogleFonts.rubik().copyWith(
    color: appDarkBlackColor,
    fontSize: appDefaultFontSize,
    fontWeight: FontWeight.bold,
  );
  static TextStyle mainCardTSCounter = GoogleFonts.rubik().copyWith(
    color: appCorporateColor,
    fontSize: appCounterFontSize,
    fontWeight: FontWeight.bold,
  );
  static TextStyle sendMessageFilesList = GoogleFonts.rubik().copyWith(
    color: appDarkGrayColor,
    fontSize: appAdvertsFontSize,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle sendMessageFilesListNoBPM = GoogleFonts.rubik().copyWith(
    // color: appDarkBlackColor,
    fontSize: appAdvertsFontSize,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle appVersionText = GoogleFonts.rubik().copyWith(
    color: appBorderColor,
  );

  /*static TextTheme mainTxtTheme = GoogleFonts.rubikTextTheme().copyWith(
    button: mainTS.copyWith(fontSize: appDefaultFontSize, fontWeight: FontWeight.bold, color: appGrayButtonColor),
    overline: mainTS.copyWith(fontSize: 14.0.sp),
    subtitle1: mainTS.copyWith(fontSize: appSubtitleFontSize, color: appDarkGrayColor),
    subtitle2: mainTS.copyWith(fontSize: appDefaultFontSize, color: appDarkGrayColor),
    headline5: mainTS.copyWith(fontSize: 24.0.sp),
    headline6: mainTS.copyWith(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
  );*/
  static TextTheme mainTxtTheme = GoogleFonts.rubikTextTheme().copyWith(
    button: mainTS.copyWith(
      fontSize: appDefaultFontSize,
      fontWeight: FontWeight.bold,
      color: appGrayButtonColor,
    ),
    overline: mainTS.copyWith(fontSize: 16.w),
    subtitle1: mainTS.copyWith(
      fontSize: appSubtitleFontSize,
      color: appDarkGrayColor,
    ),
    subtitle2: mainTS.copyWith(
      fontSize: appDefaultFontSize,
      color: appDarkGrayColor,
    ),
    headline5: mainTS.copyWith(fontSize: 26.w),
    headline6: mainTS.copyWith(
      fontSize: 18.w,
      fontWeight: FontWeight.bold,
    ),
  );

  //FontSizes
  /*static double appDefaultFontSize = 12.0.sp;
  static double appCounterFontSize = 12.0.sp;
  static double appSubtitleFontSize = 10.0.sp;
  static double appDefaultFontSizeHeader = 11.0.sp;
  static double appDefaultBorderRadius = 4.0;
  static double appDefaultElementPropertyWidth = 244.0;
  static double appDefaultIconSize = 20.0.sp;*/

  //FontSizes
  static double appDefaultFontSize = 16.w;
  static double appCounterFontSize = 16.w;
  static double appSubtitleFontSize = 14.w;
  static double appAdvertsFontSize = 12.w;
  static double appDefaultFontSizeHeader = 14.w;
  static double appDefaultBorderRadius = 4.w;
  static double appDefaultElementPropertyWidth = 244.w;
  static double appDefaultIconSize = 20.w;

  //Colors
  static Color appPrimaryColor = const Color(0xff4EC1E0);
  static Color appActiveFocusBorderColor = const Color(0xff1890ff);
  static Color appDarkBlueColor = const Color(0xff005487);
  static Color appDarkBlackColor = const Color(0xff1E1E1E);
  static Color appDarkBlackHintColor = const Color(0x99000000);
  static Color appTitleField = Colors.black54;
  static Color appDarkGrayColor = const Color(0xff8C8C8C);
  static Color appWhiteColor = const Color(0xffffffff);
  static Color appBrightBlueColor = const Color(0xffdcf3f9);
  static Color appBrightGrayColor = const Color(0xffe0e0e0);
  static Color appGrayColor = const Color(0xfff3f3f3);
  static Color appBorderColor = const Color(0xffcbcbcb);
  static Color appErrorColor = const Color(0xffE03030);
  static Color appSuccessColor = const Color(0xff12BF66);
  static Color appGrayButtonColor = Colors.black.withOpacity(0.65);
  static Color appBackgroundColor = const Color(0xffFAFAFA);
  static Color shimmerBaseColor = Colors.grey[300];
  static Color shimmerLightColor = Colors.grey[100];
  static Color appYellowButtonBorderColor = const Color(0xFFFFCE00);

  static const Map<int, Color> appCorporateColorCodes = <int, Color>{
    050: Color.fromRGBO(0, 84, 135, .1),
    100: Color.fromRGBO(0, 84, 135, .2),
    200: Color.fromRGBO(0, 84, 135, .3),
    300: Color.fromRGBO(0, 84, 135, .4),
    400: Color.fromRGBO(0, 84, 135, .5),
    500: Color.fromRGBO(0, 84, 135, .6),
    600: Color.fromRGBO(0, 84, 135, .7),
    700: Color.fromRGBO(0, 84, 135, .8),
    800: Color.fromRGBO(0, 84, 135, .9),
    900: Color.fromRGBO(0, 84, 135, 1),
  };
  static const MaterialColor appCorporateColor = MaterialColor(0xFF005487, appCorporateColorCodes);

  static const Map<int, Color> appRedColorCodes = <int, Color>{
    050: Color.fromRGBO(121, 5, 32, .1),
    100: Color.fromRGBO(121, 5, 32, .2),
    200: Color.fromRGBO(121, 5, 32, .3),
    300: Color.fromRGBO(121, 5, 32, .4),
    400: Color.fromRGBO(121, 5, 32, .5),
    500: Color.fromRGBO(121, 5, 32, .6),
    600: Color.fromRGBO(121, 5, 32, .7),
    700: Color.fromRGBO(121, 5, 32, .8),
    800: Color.fromRGBO(121, 5, 32, .9),
    900: Color.fromRGBO(121, 5, 32, 1),
  };
  static const MaterialColor appRedColor = MaterialColor(0xFF790520, appRedColorCodes);

  static double appTextFieldIconSize = 20.w;
  static double appTextFieldIconSizeMin = 20.w;
  static double appTextFieldIconSelectedSize = 32.w;
  static double appFormWidth = 300.w;
  static double appFormLogoWidth = 256.w;
  static double appFormSpacerFullHeight = 32.w;
  static double appFormSpacerHalfHeight = 16.w;
  static double appTextFieldHeight = 32.w;
  static double appTextFieldMultilineHeight = 168.w;
  static double appButtonHeight = 36.w;
  static double appTextHeight = 48.w;
  static double appDefaultShimmerRadius = 8.w;
  static double appStandartMargin = 4.w;
  static double appDoubleMargin = 8.w;
  static double appMiddleMargin = 10.w;
  static double appQuadMargin = 16.w;
  static double appAdScrollerHeight = 96.w;
  static double appAdScrollerImageWidth = 144.w;
  static double appAdScrollerImageHeight = 80.w;
  static double appAnswersBoxMinHeight = 48.w;
  static double appAnswersBoxMaxHeight = 180.w;
  static double appComboArrowDownSize = 16.w;
  static double appRadioIconSize = 32.w;
  static double appSendMessageFilesListDeleteIconWidth = 18.w;
  static double appSendMessageFilesListRowHeight = 22.w;
  static double appSelectUsersHeight = 180.w;

  //BpmColors
  static Color appDarkYellowColor = const Color(0xffffce00);
  static Color appYellowColor = const Color(0xffFFF1B5);
  static Color appRevisionBtnColor = const Color(0xffc26b11);
  static Color appRejectBtnColor = appErrorColor;
  static Color appCancelBtnColor = const Color(0xff892525);
  static Color appToBeRevised = const Color(0xc3005eff);

  static const int pwdLength = 8;
  static final RegExp regUpper = RegExp('[A-ZА-Я]', unicode: true);
  static final RegExp regLower = RegExp('[a-zа-я]', unicode: true);
  static final RegExp regDig = RegExp('[0-9]');
  static final RegExp regSpec = RegExp('[!;%:?*()_+<>/\\\\]');
  static final RegExp regLatin = RegExp(r'^[A-Za-z]+$');

  static final MaskTextInputFormatter iin = MaskTextInputFormatter(mask: '############', filter: <String, RegExp>{'#': regDig});
  static final MaskTextInputFormatter verify = MaskTextInputFormatter(mask: '######', filter: <String, RegExp>{'#': regDig});
  static final MaskTextInputFormatter phone = MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: <String, RegExp>{'#': regDig});

  static EdgeInsets appFormPaddingHorizontal = EdgeInsets.only(left: 48.w, right: 48.w);
}

Color getColorByStatusCode(String code) {
  return code == statusCodeReject
      ? Styles.appRejectBtnColor
      : code == statusCodeApproved
          ? Styles.appSuccessColor
          : code == statusCodeApproving
              ? Styles.appDarkYellowColor
              : code == statusCodeDraft
                  ? Styles.appDarkGrayColor
                  : code == statusCodeSend
                      ? Styles.appActiveFocusBorderColor
                      : code == statusCodeClosed
                          ? Styles.appSuccessColor
                          : code == statusCodeToBeRevised
                              ? Styles.appToBeRevised
                              : code == statusCodeCanceled
                                  ? Styles.appErrorColor
                                  // appErrorColor
                                  : Colors.transparent;
}

Container appBarBg(BuildContext context) => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.white, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0.1, 0.0),
          end: const FractionalOffset(0.8, 0.0),
          stops: const <double>[0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black87,
            offset: Offset.fromDirection(0.4, 0.5),
          )
        ],
      ),
    );

// AppBar defaultAppBar(BuildContext context, {dynamic actions}) => AppBar(
// AppBar defaultAppBar(BuildContext context, {List<Widget> actions}) => AppBar(
//       leading: backButton(),
//       flexibleSpace: appBarBg(context),
//       title: BrandLogo(),
//       centerTitle: Platform.isIOS,
//       elevation: 0,
//       actions: actions,
//     );

IconButton backButton() => IconButton(
      icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
      onPressed: () => Get.back(),
    );

// EdgeInsets paddingHorizontal({double top, double bottom}) => EdgeInsets.only(left: 16.0, right: 16.0, top: top ?? 0, bottom: bottom ?? 0);
EdgeInsets paddingHorizontal({double top, double bottom}) => EdgeInsets.only(
      left: 16.w,
      right: 16.w,
      top: top ?? 0,
      bottom: bottom ?? 0,
    );

EdgeInsets paddingLR = EdgeInsets.only(left: 16.w, right: 16.w);
EdgeInsets paddingLRB = EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w);
EdgeInsets paddingLRT = EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w);
EdgeInsets paddingLRBT = EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w, top: 16.w);
EdgeInsets paddingTB = EdgeInsets.only(top: 16.w, bottom: 16.w);

/*final Icon calendarWidgetForFormFiled = Icon(
  Icons.calendar_today_outlined,
  color: Styles.appDarkBlueColor,
  size: 20,
);*/

final Icon calendarWidgetForFormFiled = Icon(
  Icons.calendar_today_outlined,
  color: Styles.appDarkBlueColor,
  size: 20.w,
);

Widget contentShadow(
    {Widget child, List<Widget> children, String title, String subtitle, bool hideMargin = false, double bottomPadding, double topPadding, EdgeInsets margin,}) {
  return Container(
    width: double.infinity,
    margin: hideMargin ? EdgeInsets.zero : margin ?? EdgeInsets.all(16.w),
    padding: EdgeInsets.only(bottom: bottomPadding ?? 16.w, top: topPadding ?? 0, left: 16.w, right: 16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 24,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null)
          Padding(
            // padding: const EdgeInsets.only(top: 16, bottom: 8),
            padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
            child: Text(
              title,
              style: Styles.mainTS.copyWith(
                // fontSize: 16,
                fontSize: 17.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (subtitle != null)
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              subtitle,
              style: Styles.mainTS.copyWith(
                // fontSize: 14,
                fontSize: 15.w,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (subtitle == null && title == null) SizedBox(height: 10.w),
        if (child != null) child,
        if (child == null) ...children,
      ],
    ),
  );
}

Widget pageTitle({@required String title, Widget secondWidget, String subtitle, double fontSize}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          // margin: const EdgeInsets.only(top: 16, left: 16, bottom: 0),
          margin: EdgeInsets.only(top: 16.w, left: 16.w, bottom: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                // style: Styles.mainTS.copyWith(color: Styles.appDarkBlackColor, fontSize: 18, fontWeight: FontWeight.bold),
                style: Styles.mainTS.copyWith(
                  color: Styles.appDarkBlackColor,
                  fontSize: fontSize ?? 20.w,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.start,
                )
              else
                Container()
            ],
          ),
        ),
      ),
      if (secondWidget != null) secondWidget
    ],
  );
}

Widget contentBgGray({@required Widget child}) {
  return Container(
    // padding: const EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.w),
    color: Styles.appGrayColor,
    child: child,
  );
}

Widget noData = Padding(
  // padding: const EdgeInsets.symmetric(vertical: 30.0),
  padding: EdgeInsets.symmetric(vertical: 30.w),
  child: Center(
    child: Column(
      children: <Widget>[
        // Icon(Icons.people_outline, color: Styles.appBrightGrayColor, size: 50),
        Icon(Icons.people_outline, color: Styles.appBrightGrayColor, size: 50.w),
        Text(
          S.current.noData,
          style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor),
        )
      ],
    ),
  ),
);

Widget outcomeButton({String outcomeId, Function() onTap, bool isOutLineButton = false}) {
  Color bgColor;
  bool _isOutLineButton = isOutLineButton;

  final Color textColor = Styles.appWhiteColor;
  switch (outcomeId) {
    case statusCodeRevision:
      bgColor = Styles.appRevisionBtnColor;
      break;
    case statusCodeApprove:
      bgColor = Styles.appCorporateColor;
      break;
    case statusCodeReject:
      bgColor = Styles.appRejectBtnColor;
      break;
    case statusCodeReassign:
      bgColor = Styles.appDarkYellowColor;
      _isOutLineButton = true;
      break;
    case statusCodeSendForApproval:
      bgColor = Styles.appDarkBlueColor;
      break;
    case statusCodeCancel:
      bgColor = Styles.appCancelBtnColor;
      break;
  }

  return KzmButton(
    outlined: _isOutLineButton,
    onPressed: onTap,
    bgColor: bgColor,
    borderColor: _isOutLineButton ? bgColor : null,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          // padding: const EdgeInsets.only(left: 7.0),
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            getOutcomeNameById(outcomeId),
            // style: Styles.mainTS.copyWith(color: textColor, fontWeight: FontWeight.w400, fontSize: 14),
            style: Styles.mainTS.copyWith(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 16.w,
            ),
          ),
          // Text(
          //   getOutcomeNameById(outcomeId),
          //   // style: Styles.mainTS.copyWith(color: textColor, fontWeight: FontWeight.w400, fontSize: 14),
          //   style: Styles.mainTS.copyWith(color: textColor, fontWeight: FontWeight.w400, fontSize: 13.w),
          // )
        ),
      ],
    ),
  );
}

String getOutcomeNameById(String outcomeId) {
  if (outcomeId == '' || outcomeId == null) {
    return null;
  }
  switch (outcomeId) {
    case statusCodeRevision:
      return S.current.outcomeRevision;
    case statusCodeApprove:
      return S.current.outcomeApprove;
    case statusCodeReject:
      return S.current.outcomeReject;
    case statusCodeReassign:
      return S.current.outcomeReassign;
    case statusCodeSendForApproval:
      return S.current.outcomeSendForApproval;
    case statusCodeStart:
      return S.current.start;
    case statusCodeOnHold:
      return S.current.on_hold;
    case statusCodeCancel:
      return S.current.outcomeCancel;

    // return S.current.outcome;
  }
  return outcomeId;
}

String getCompanyName(String outcomeId) {
  if (outcomeId == '' || outcomeId == null) {
    return null;
  }
  switch (outcomeId) {
    case companyKMM:
      return 'ТОО "КАЗ Минералз Менеджмент"; KMM CEO';
    case companyKBL:
      return 'ТОО "KAZ Minerals Bozshakol" (КАЗ Минералз Бозшаколь)';
    case companyKAL:
      return 'ТОО "KAZ Minerals Aktogay" (КАЗ Минералз Актогай)';
    case companyVCM:
      return 'TОО «Востокцветмет»';

  // return S.current.outcome;
  }
  return outcomeId;
}

DateFormat dateFormatFull = DateFormat('dd MMMM yyyy HH:mm');
DateFormat dateFormatSolid = DateFormat('yyyyMMdd.HHmmss.SSS');
DateFormat dateFormatFullNumeric = DateFormat('dd.MM.yyyy HH:mm');
DateFormat dateFormatFullRest = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
DateFormat dateFormatTimeRest = DateFormat('HH:mm:ss');
DateFormat dateFormatFullRestNotMilSec = DateFormat('yyyy-MM-dd');
DateFormat dateFormatFullNotMilSec = DateFormat('dd.MM.yyyy');
DateFormat dateFormatShortRest = DateFormat('dd MMM yyyy');
DateFormat dateFormatMonthY = DateFormat('MMMM yyyy');

DateFormat dateFormatDateMonth = DateFormat('dd MMM');
DateFormat timeFormat = DateFormat('HH:mm');
final NumberFormat oCcy = NumberFormat('#,##0.00');
final NumberFormat numForm = NumberFormat('#,##0');

Color hexToColor(String code) => Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

String formatCash(num a) {
  if (a == null) return '';
  return oCcy.format(a);
}

String formatNumber(num a) {
  if (a == null) return '';
  return numForm.format(a);
}

String formatTime(DateTime val) {
  if (val == null) return '';
  return timeFormat.format(val);
}

String formatDateMonth(DateTime val) {
  if (val == null) return '';
  return dateFormatDateMonth.format(val);
}

String formatShortly(DateTime val) {
  if (val == null) return '';
  return dateFormatShortRest.format(val);
}

String dateFormatMonthYear(DateTime val) {
  if (val == null) return '';
  return dateFormatMonthY.format(val);
}

String formatFullRest(DateTime val) {
  if (val == null) return null;
  return dateFormatFullRest.format(val);
}

String formatTimeRest(DateTime val) {
  if (val == null) return null;
  return dateFormatTimeRest.format(val);
}

String formatFullRestNotMilSec(DateTime val) {
  if (val == null) return null;
  return dateFormatFullRestNotMilSec.format(val);
}

String formatFullNotMilSec(DateTime val) {
  if (val == null) return null;
  return dateFormatFullNotMilSec.format(val);
}

String formatFullNumeric(DateTime val) {
  if (val == null) return '';
  return dateFormatFullNumeric.format(val);
}

String formatFull(DateTime val) {
  if (val == null) return '';
  return dateFormatFull.format(val);
}

String formatSolid(DateTime val) {
  if (val == null) return '';
  return dateFormatSolid.format(val);
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

List<KzmCommonItem> kzmShiftCodes = <KzmCommonItem>[
  KzmCommonItem(id: 'D', text: 'D'),
  KzmCommonItem(id: 'N', text: 'N'),
];

List<KzmCommonItem> kzmOverrideAllHoursByDay = <KzmCommonItem>[
  KzmCommonItem(id: 'YES', text: S.current.yes),
  KzmCommonItem(id: 'NO', text: S.current.no),
];

const String absencePurposeOtherTypeID = '8dd2ce0f-6537-a2ea-ad72-298efe560b97';
const String kzCountryID = '041eee0f-9ba4-8f6b-5dac-d77f6063c346';
const String employeeRoleID = '22d0f62f-a8aa-a7f3-5139-adf455e2f19d';
const String toBeRevisedID = '142d7542-d3ca-ef56-519e-f5b25e3475e2';
const String uvedomlFileName = 'uvedoml';
const String reportlFileName = 'report';

const String statusCodeReject = 'REJECT';
const String statusCodeApproved = 'APPROVED';
const String statusCodeApproving = 'APPROVING';
const String statusCodeDraft = 'DRAFT';
const String statusCodeSend = 'SEND';
const String statusCodeClosed = 'CLOSED';
const String statusCodeCanceled = 'CANCELED_BY_INITIATOR';
const String statusCodeToBeRevised = 'TO_BE_REVISED';
const String statusCodeRevision = 'REVISION';
const String statusCodeApprove = 'APPROVE';
const String statusCodeReassign = 'REASSIGN';
const String statusCodeSendForApproval = 'SEND_FOR_APPROVAL';
const String statusCodeCancel = 'CANCEL';
const String statusCodeStart = 'START';
const String statusCodeOnHold = 'ON_HOLD';
const String notificationStatusDone = 'done';
const String companyKMM = 'KMM';
const String companyKBL = 'KBL';
const String companyKAL = 'KAL';
const String companyVCM = 'VCM';

