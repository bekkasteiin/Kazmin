//@dart=2.18
import 'package:get/get.dart';
import 'package:kzm/pageviews/lk/_misc/po_ids.dart';
import 'package:kzm/pageviews/lk/_misc/po_services.dart';
import 'package:kzm/pageviews/lk/lk_controller.dart';
import 'package:kzm/pageviews/lk/lk_model.dart';

const String fName = 'lib/pageviews/lk/_misc/lk_binding.dart';

class KzmLKBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KzmPrivateOfficeIDs>(KzmPrivateOfficeIDs());
    Get.put<KzmPrivateOfficeServices>(KzmPrivateOfficeServices());
    Get.put<KzmLKModel>(KzmLKModel());
    Get.put<KzmLKController>(KzmLKController());
  }
}
