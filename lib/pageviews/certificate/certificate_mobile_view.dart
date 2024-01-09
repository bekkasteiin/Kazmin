import 'package:flutter/material.dart';
import 'package:kzm/core/components/widgets/app_bar.dart';
import 'package:kzm/pageviews/certificate/certificate_widget.dart';
import 'package:kzm/viewmodels/bpm_requests/certificate_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CertificatePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CertificateModel()),
      ],
      child: Consumer<CertificateModel>(
        builder: (BuildContext context, CertificateModel counter, _) {
          return ScreenTypeLayout(
            mobile: CertificatePage(),
            tablet: CertificatePage(),
          );
        },
      ),
    );
  }
}

class CertificatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final CertificateModel model = Provider.of<CertificateModel>(context);
    return Scaffold(
      // drawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      // endDrawer: KzmMenuDrawer(tiles: Provider.of<AppSettingsModel>(context).tiles),
      // appBar: AppBar(
      //   flexibleSpace: appBarBg(context),
      //   title: BrandLogo(),
      //   centerTitle: false,
      // ),
      appBar: KzmAppBar(context: context),
      body: CertificateWidget(
        model: model,
      ),
    );
  }
}
