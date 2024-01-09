//@dart=2.18
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/pageviews/hr_requests/request_hitories.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/main_data/items/address.dart';
import 'package:kzm/pageviews/lk/main_data/items/awards_degrees.dart';
import 'package:kzm/pageviews/lk/main_data/items/beneficiary.dart';
import 'package:kzm/pageviews/lk/main_data/items/contact.dart';
import 'package:kzm/pageviews/lk/main_data/items/disability.dart';
import 'package:kzm/pageviews/lk/main_data/items/documents.dart';
import 'package:kzm/pageviews/lk/main_data/items/education.dart';
import 'package:kzm/pageviews/lk/main_data/items/experience.dart';
import 'package:kzm/pageviews/lk/main_data/items/military.dart';
import 'package:kzm/pageviews/lk/main_data/items/person_other_info.dart';
import 'package:kzm/pageviews/lk/main_data/items/personal_data.dart';
import 'package:kzm/pageviews/lk/main_data/items/qualification.dart';
import 'package:responsive_builder/responsive_builder.dart';

const String fName = 'lib/pageviews/lk/lk_view.dart';

class KzmLKView extends GetView<KzmLKController> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: KzmAppBar(
            context: context,
            bottom: TabBar(
              isScrollable: false,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              tabs: <Tab>[
                Tab(text: S.current.lkMyData),
                Tab(text: S.current.historyRequests),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              GetBuilder<KzmLKController>(
                id: controller.ids.lkView,
                builder: (KzmLKController _) {
                  return (controller.model.personProfile?.groupId == null)
                      ? KZMNoData()
                      : SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              PersonalData(
                                id: controller.ids.mainDataPersonProfile,
                                model: controller.model,
                              ),
                              Documents(
                                id: controller.ids.mainDataPersonDocuments,
                                model: controller.model,
                              ),
                              Address(
                                id: controller.ids.mainDataAddress,
                                model: controller.model,
                              ),
                              Contact(
                                id: controller.ids.mainDataPersonContact,
                                model: controller.model,
                              ),
                              Education(
                                id: controller.ids.mainDataEducation,
                                model: controller.model,
                              ),
                              Experience(
                                id: controller.ids.mainDataExperience,
                                model: controller.model,
                              ),
                              Beneficiary(
                                id: controller.ids.mainDataBeneficiary,
                                model: controller.model,
                              ),
                              Qualification(
                                id: controller.ids.mainDataQualification,
                                model: controller.model,
                              ),
                              AwardsDegrees(
                                id: controller.ids.mainDataAwardsDegrees,
                                model: controller.model,
                              ),
                              Disability(
                                id: controller.ids.mainDataDisability,
                                model: controller.model,
                              ),
                              Military(
                                id: controller.ids.mainDataMilitary,
                                model: controller.model,
                              ),
                              PersonOtherInfo(
                                id: controller.ids.mainDataPersonExt,
                                model: controller.model,
                              ),
                            ],
                          ),
                        );
                },
              ),
              const HrRequestHistories(),
            ],
          ),
        ),
      ),
    );
  }
}
