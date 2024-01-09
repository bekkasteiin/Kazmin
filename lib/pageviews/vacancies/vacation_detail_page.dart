import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/company_vacation/company_vacation_item.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/vacancies/vacation_apply_view.dart';
import 'package:provider/provider.dart';
import 'package:kzm/viewmodels/company_vacation_model.dart';

class VacationDetailPage extends StatelessWidget {
  CompanyVacationItem vacationItem;
  String operatingMode;
  VacationDetailPage({Key key, this.vacationItem, this.operatingMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
          child: body(context),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    final CompanyVacationModel model =
        Provider.of<CompanyVacationModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.6),
            border: Border.all(width: 1, color: Styles.appRedColor),
          ),
          child: Text(
            S.current.attentionVacancies,
            style: Styles.mainTS.copyWith(
              color: Styles.appDarkBlackColor,
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h,),
        Text(vacationItem.positionGroup.position.instanceName,
        style: Styles.mainTS.copyWith(
          color: Styles.appDarkBlackColor,
          fontSize: 20.w,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(height: 4.h,),
        Text(getCompanyName(vacationItem.positionGroup.company.instanceName), style: Styles.mainTS.copyWith(
          color: Styles.appRedColor,
          fontSize: 14.w,
          fontWeight: FontWeight.bold,
        ), ),
        SizedBox(height: 4.h,),
        Text(operatingMode ?? ''),
        SizedBox(height: 4.h,),
        Text(
          '${S.current.createVacancies}: ${formatFullNotMilSec(vacationItem.createTs)}',
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          S.current.jobResponsibilities,
          style: Styles.mainTS.copyWith(
            color: Styles.appDarkBlackColor,
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Styles.appBrightGrayColor,
            border: Border.all(width: 1, color: Styles.appDarkGrayColor),
          ),
          child: Text(vacationItem.jobResponsibilitiesLang3 ?? ''),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          S.current.mandatoryQualifications,
          style: Styles.mainTS.copyWith(
            color: Styles.appDarkBlackColor,
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Styles.appBrightGrayColor,
            border: Border.all(width: 1, color: Styles.appDarkGrayColor),
          ),
          child: Text(vacationItem.mandatoryQualificationsLang1 ?? ''),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          S.current.generalRequirement,
          style: Styles.mainTS.copyWith(
            color: Styles.appDarkBlackColor,
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Styles.appBrightGrayColor,
            border: Border.all(width: 1, color: Styles.appDarkGrayColor),
          ),
          child: Text(vacationItem.generalAndAdditionalRequirementsLang1 ?? ''),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          S.current.desirableComments,
          style: Styles.mainTS.copyWith(
            color: Styles.appDarkBlackColor,
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Styles.appBrightGrayColor,
            border: Border.all(width: 1, color: Styles.appDarkGrayColor),
          ),
          child: Text(vacationItem.desirableRequirementsAndAdditionalCommentsLang1 ?? ''),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: SafeArea(
            child: Column(
              children: [
                KzmOutlinedBlueButton(
                  caption: S.current.recommend,
                  enabled: true,
                  onPressed: () async{
                    model.allRequest;
                    await model.getUserInfo();
                    model.getRequestDefaultValue();
                  },
                ),
                KzmOutlinedBlueButton(
                  caption: S.current.apply,
                  enabled: true,
                  onPressed: () async{
                    model.allRequest;
                    await model.getUserInfo();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const VacationApplyView()));
                  },
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
