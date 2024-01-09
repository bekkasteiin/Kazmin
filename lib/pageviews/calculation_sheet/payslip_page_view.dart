import 'package:flutter/material.dart';
import 'package:kzm/pageviews/calculation_sheet/payslip_view.dart';
import 'package:kzm/viewmodels/payslip_vm.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PayslipPageView extends StatelessWidget {
  const PayslipPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PayslipVM()),
      ],
      child: Consumer<PayslipVM>(
        builder: (BuildContext context, PayslipVM payslipVM, _) {
          return ScreenTypeLayout(
            mobile: PayslipView(payslipVM: payslipVM),
            tablet: PayslipView(payslipVM: payslipVM),
          );
        },
      ),
    );
  }
}
