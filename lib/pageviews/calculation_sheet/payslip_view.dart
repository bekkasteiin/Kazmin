import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/person_payslip.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/payslip_vm.dart';
import 'package:provider/provider.dart';

class PayslipView extends StatefulWidget {
  final PayslipVM payslipVM;

  const PayslipView({@required this.payslipVM, Key key}) : super(key: key);

  @override
  _PayslipViewState createState() => _PayslipViewState();
}

class _PayslipViewState extends State<PayslipView> {
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<PayslipVM>(context, listen: false).getPayslips();
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PayslipVM model = Provider.of<PayslipVM>(context, listen: false);
    return Scaffold(
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      appBar: KzmAppBar(context: context),
      body: RefreshIndicator(
        onRefresh: () => model.getPayslips(update: true),
        child: ListView(
          children: <Widget>[
            pageTitle(title: S.current.payslip),
            if (loading)
              const Center(child: LoaderWidget())
            else
              (model.list.isNotEmpty)
                  ? Column(
                      children: model.list.map((PersonPayslip e) {
                        final bool fileExists = e.file?.id != null && e.file?.name != null && e.file?.extension != null;
                        return KzmCard(
                          title: formatShortly(e.period),
                          subtitle: e.file?.name,
                          selected: () async {
                            // log('-->> $fName, build ->> entity: ${e.toJson()}');
                            if (fileExists) await PickerFileServices.downloadFile(e.file);
                          },
                          trailing: fileExists
                              ? Icon(
                                  Icons.download_outlined,
                                  size: 24.w,
                                )
                              : const SizedBox(),
                        );
                      }).toList(),
                    )
                  : Column(
                      children: <Widget>[
                        SizedBox(height: Styles.appQuadMargin,),
                        Text(
                          S.current.paysLipNoRecords,
                          style: Styles.mainTS.copyWith(
                            color: Styles.appDarkBlackColor,
                            fontSize: Styles.appDefaultFontSizeHeader,
                          ),
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
