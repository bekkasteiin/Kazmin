import 'package:get/get.dart';
import 'package:kzm/pageviews/send_message/misc/sm_services.dart';
import 'package:kzm/pageviews/send_message/sm_controller.dart';
import 'package:kzm/pageviews/send_message/sm_model.dart';

const String fName = 'lib/pageviews/send_message/_misc/sm_binding.dart';

class KzmSendMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KzmSendMessageModel>(KzmSendMessageModel());
    Get.put<KzmSendMessageServices>(KzmSendMessageServices());
    Get.put<KzmSendMessageController>(KzmSendMessageController());
  }
}
