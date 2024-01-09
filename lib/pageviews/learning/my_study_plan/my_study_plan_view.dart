import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/learning_request.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/learning_model.dart';

class MyStudyPlanView extends StatelessWidget {
  const MyStudyPlanView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LearningModel model = ModalRoute.of(context).settings.arguments as LearningModel;
    return Scaffold(
      appBar: KzmAppBar(
        context: context,
      ),
      body: FutureBuilder<List<LearningRequest>>(
        future: model.getLearninRequests(),
        builder: (BuildContext context, AsyncSnapshot<List<LearningRequest>> snapshot) {
          if(snapshot.data == null) {
            return const LoaderWidget();
          }
          return ListView(
            children: <Widget>[
              pageTitle(title: S.current.myStudyPlan, fontSize: 16.w),
              ...snapshot.data.map((LearningRequest e){
                return KzmCard(
                  // leading: CachedImage(e.),
                  title: e.courseName,
                  subtitle: '${formatShortly(e.dateFrom)} - ${formatShortly(e.dateTo)}',
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.w,),
                  selected: ()=>model.openStudyPlan(e),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
