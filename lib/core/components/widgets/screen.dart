import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';

const String fName = 'lib/core/components/widgets/screen.dart';

class KzmScreen extends StatefulWidget {
  final Widget body;
  final AppBar appBar;
  final Widget endDrawer;
  final Widget bottomSheet;
  final bool isInitPage;
  final bool isScrollable;

  const KzmScreen({
    @required this.body,
    this.appBar,
    this.isInitPage = false,
    this.endDrawer,
    this.bottomSheet,
    this.isScrollable = true,
  });

  @override
  State<KzmScreen> createState() => _KzmScreenState();
}

class _KzmScreenState extends State<KzmScreen> {
  final GlobalKey _bottomSheetKey = GlobalKey();
  double _bottomPadding = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_bottomSheetKey.currentContext != null) {
        setState(() => _bottomPadding = _bottomSheetKey.currentContext.size.height);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar bar;
    if (GetPlatform.isIOS) {
      bar = widget.isInitPage
          ? AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Styles.appCorporateColor,
              elevation: 0,
            )
          : widget.appBar;
    }
    if (GetPlatform.isAndroid) {
      bar = widget.isInitPage ? null : widget.appBar;
    }

    final Padding _body = Padding(
      padding: EdgeInsets.only(bottom: _bottomPadding),
      child: widget.body,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: widget.endDrawer,
      appBar: bar,
      bottomSheet: (widget.bottomSheet != null)
          ? Padding(
              key: _bottomSheetKey,
              padding: GetPlatform.isIOS ? paddingLRB : paddingLR,
              child: widget.bottomSheet,
            )
          : null,
      body: Padding(
        padding: EdgeInsets.only(
          top: widget.isInitPage
              ? GetPlatform.isIOS
                  ? 0.0
                  : context.mediaQueryPadding.top
              : ((bar != null) ? bar.preferredSize.height : 0.0) + context.mediaQueryPadding.top,
        ),
        child: widget.isScrollable
            ? SingleChildScrollView(
                child: _body,
              )
            : _body,
      ),
    );
  }
}
