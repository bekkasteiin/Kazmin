import 'package:flutter/cupertino.dart';
import 'package:kzm/core/constants/pages.dart';
import 'package:kzm/core/constants/requests.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/models/portal_menu_customization.dart';
import 'package:kzm/core/models/proc_instance_v.dart';
import 'package:kzm/core/models/tile_data.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/viewmodels/base_model.dart';
import 'package:kzm/viewmodels/user_model.dart';

class HrRequestModel extends BaseModel {
  List<ProcInstanceV> list;

  Future<List<TileData>> tiles({
    // @required List<PortalMenuCustomization> portalMenu,
    @required UserViewModel userModel,
  }) async {
    await userModel.getMenu();
    final PortalMenuCustomization showsurCharge =
        userModel.portalMenuCustomization.firstWhere((PortalMenuCustomization element) =>
        element.menuItem == 'allRequests-worker-material-help', orElse: () => null);
    final PortalMenuCustomization personPayslip =
        // portalMenu.firstWhere((PortalMenuCustomization element) => element.menuItem == 'personPayslip', orElse: () => null);
        userModel.portalMenuCustomization.firstWhere((PortalMenuCustomization element) => element.menuItem == 'personPayslip', orElse: () => null);

    return <TileData>[
      TileData(
        name: S.current.absence,
        url: KzmPages.absence,
        svgIcon: SvgIconData.trainingCatalogue,
        showOnMainScreen: null,
      ),
      TileData(
        name: S.current.jclRequest,
        url: KzmPages.jclRequest,
        svgIcon: SvgIconData.myCourses,
        showOnMainScreen: null,
      ),
      if (personPayslip != null)
        TileData(
          name: S.current.payslip,
          url: KzmPages.payslip,
          svgIcon: SvgIconData.trainingHistory,
          showOnMainScreen: null,
        ),
      TileData(
        name: S.current.medicalInsurance,
        url: KzmPages.dms,
        svgIcon: SvgIconData.myDmc,
        showOnMainScreen: null,
      ),
      if (showsurCharge != null)
        TileData(
          name: S.current.materialAssistance,
          url: KzmPages.materialAssistance,
          svgIcon: SvgIconData.myDmc,
          showOnMainScreen: null,
        ),
      if (await userModel.isChief)
        TileData(
          name: S.current.rvd,
          url: KzmPages.absenceNewRvd,
          svgIcon: SvgIconData.myDmc,
          showOnMainScreen: null,
        ),
      if (await userModel.isChief)
        TileData(
          name: S.current.changeAbsenceTitle,
          url: KzmPages.changeAbsence,
          svgIcon: SvgIconData.myDmc,
          showOnMainScreen: null,
        ),
      if (await userModel.isChief)
        TileData(
          name: S.current.absenceForRecall,
          url: KzmPages.absenceForRecall,
          svgIcon: SvgIconData.myDmc,
          showOnMainScreen: null,
        ),
       TileData(
         name: S.current.dismissal,
         url: KzmPages.dismissal,
         svgIcon: SvgIconData.myDmc,
         showOnMainScreen: null,
       ),
      TileData(
        name: S.current.myVacationAbsenceBalance,
        url: KzmPages.absenceVacationBalance,
        svgIcon: SvgIconData.trainingCatalogue,
        showOnMainScreen: null,
      ),
      // if (await userModel.isChief)
      //   TileData(
      //     name: S.current.ovd,
      //     url: KzmPages.ovd,
      //     svgIcon: SvgIconData.myDmc,
      //     showOnMainScreen: null,
      //   ),
    ];
  }

  Future<List<ProcInstanceV>> getHistories({bool update = false}) async {
    if (update || list == null) {
      final List<ProcInstanceV> response = await RestServices.getRequestHistory();
      list = response.where((ProcInstanceV e) => kzmRequests.containsKey(e.procInstanceVEntityName)).toList();
      setBusy();
      notifyListeners();
    }
    return list.where((ProcInstanceV e) => kzmRequests.containsKey(e.procInstanceVEntityName)).toList();
  }
}
