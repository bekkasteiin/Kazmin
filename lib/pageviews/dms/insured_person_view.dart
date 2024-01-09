import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/dms/insured_person_page.dart';
import 'package:kzm/viewmodels/insured_person_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InsuredPersonPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsuredPersonModel()),
      ],
      child: Consumer<InsuredPersonModel>(
        builder: (BuildContext context, InsuredPersonModel counter, _) {
          return ScreenTypeLayout(
            mobile: InsuredPersonPage(),
            tablet: InsuredPersonPage(),
          );
        },
      ),
    );
  }
}

class InsuredPersonPage extends StatefulWidget {
  @override
  _InsuredPersonPageState createState() => _InsuredPersonPageState();
}

class _InsuredPersonPageState extends State<InsuredPersonPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double height2 = MediaQuery.of(context).size.height;
    final InsuredPersonModel model = Provider.of<InsuredPersonModel>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: KzmAppBar(context: context),
        body: SingleChildScrollView(
          child: Container(
            height: height2 * 0.87,
            padding: EdgeInsets.all(5.w),
            child: InsuredPersonListPage(
              model: model,
            ),
          ),
        ),
      ),
    );
  }
}
