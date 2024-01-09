import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/navigator_widget.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/company_vacation/company_vacation.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/selector_layout.dart';
import 'package:kzm/pageviews/vacancies/vacation_detail_page.dart';
import 'package:kzm/pageviews/vacancies/vacation_recommend_view.dart';
import 'package:kzm/viewmodels/company_vacation_model.dart';
import 'package:kzm/viewmodels/learning_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VacationPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LearningModel()),
      ],
      child: Consumer<LearningModel>(
        builder: (BuildContext context, LearningModel counter, _) {
          return ScreenTypeLayout(
            mobile: VacationPage(),
            tablet: VacationPage(),
          );
        },
      ),
    );
  }
}

class VacationPage extends StatefulWidget {
  @override
  _VacationPageState createState() => _VacationPageState();
}

class _VacationPageState extends State<VacationPage>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  AbstractDictionary company;
  String nameOrg;

  @override
  Widget build(BuildContext context) {
    final CompanyVacationModel model =
        Provider.of<CompanyVacationModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: KzmAppBar(
        context: context,
        showMenu: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pageTitle(title: S().organizationVacancies),
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.appDarkGrayColor, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.vacancyName,
                            style: TextStyle(fontSize: 12.w),
                          ),
                          SizedBox(
                            width: 160.w,
                            child: TextFormField(
                              style: TextStyle(color: Styles.appDarkBlackColor),
                              controller: controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.w),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF262C48),
                                    width: 1.w,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                fillColor: Styles.appDarkGrayColor,
                                suffixIcon: nameOrg != null
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.clear();
                                          nameOrg = null;
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          setState(() {});
                                        },
                                        child: Icon(Icons.cancel_outlined,
                                            size: 20.w, color: Colors.red),
                                      )
                                    : SizedBox(),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  nameOrg = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.company,
                          style: TextStyle(fontSize: 12.w),
                        ),
                        Container(
                          padding: EdgeInsets.all(4.w),
                          height: 30.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Styles.appDarkGrayColor, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  company?.instanceName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  company != null
                                      ? company = null
                                      : companySelect(model);
                                  setState(() {});
                                },
                                child: Icon(
                                    company != null
                                        ? Icons.cancel_outlined
                                        : Icons.keyboard_arrow_down_sharp,
                                    color: company != null ? Colors.red : null,
                                size: 20.w,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    KzmOutlinedBlueButton(
                      caption: S.current.search,
                      enabled: true,
                      onPressed: () async {
                        await model.getHistoriesSearch(
                            company: company, nameOrg: nameOrg ?? '');
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 50.w,
                  top: 12.h,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    color: Styles.appBackgroundColor,
                    child: Text(
                      S.current.filter,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  )),
            ],
          ),
          searchList(model)
        ],
      ),
    );
  }

  Widget searchList(CompanyVacationModel model) {
    return Expanded(
      child: FutureBuilder<List<CompanyVacation>>(
        future: model.getHistoriesSearch(company: company, nameOrg: nameOrg),
        builder: (BuildContext context,
            AsyncSnapshot<List<CompanyVacation>> snapshot) {
          if (snapshot.data == null) {
            return Container(
              margin: EdgeInsets.only(top: 20.w),
              child: const Center(
                child: LoaderWidget(),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(4.0.w),
              child: snapshot.data.isEmpty
                  ? noData
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: Text(
                              '${S.current.openVacancies}: ${snapshot.data.length ?? 0}'),
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: model.futureList.map((e) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () async {
                                        await model.getVacation(e.id);
                                         await Navigator.push(context, MaterialPageRoute(builder: (_)=>
                                            VacationDetailPage(
                                              operatingMode:
                                              e?.operatingMode ?? '',
                                              vacationItem:
                                              model.companyVacationItem,
                                            ),
                                        ));
                                      },
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e?.nameForSiteLang ?? '',
                                            style: Styles.mainTS,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            getCompanyName(e.positionGroup
                                                    .company.instanceName) ??
                                                '',
                                            style: Styles.mainTS.copyWith(
                                                color: Styles.appRedColor,
                                                fontSize: 14.w),
                                          ),
                                          Text(
                                            e?.operatingMode ?? '',
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(formatFullNotMilSec(e.createTs)),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20.w,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          }
        },
      ),
    );
  }


  companySelect(CompanyVacationModel model) {
    showModalBottomSheet(
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
      builder: (_) => SelectsWidget(
        title: S.current.selectCompany,
        select: company,
        list: model.companySearch ?? [],
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, int i) {
            bool current = false;
            if (company != null) {
              current = model.companySearch[i].id == company.id;
            }
            return Container(
              color: Styles.appWhiteColor,
              child: InkWell(
                child: SelectItem(
                  model.companySearch[i].instanceName ?? '',
                  current,
                ),
                onTap: () => setState(() {
                  if (!current) {
                    company = model.companySearch[i];
                    setState(() {});
                    GlobalNavigator.pop();
                  }
                }),
              ),
            );
          },
          separatorBuilder: (_, int index) => const SizedBox(),
          itemCount: model.companySearch?.length ?? 0,
        ),
      ),
    );
  }
}
