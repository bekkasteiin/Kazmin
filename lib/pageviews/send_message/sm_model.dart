import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/entities/tsadv_portal_feedback.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/viewmodels/base_model.dart';

String fName = 'lib/pageviews/send_message/sm_model.dart';

class KzmSendMessageModel extends BaseModel{
  List<KzmCommonItem> categories;
  KzmCommonItem categorySelected;
  List<TsadvPortalFeedback> feedbackList;
  List<KzmCommonItem> types;
  KzmCommonItem typeSelected;
  String topic = '';
  String text = '';
  bool isButtonEnabled = false;
  bool isFileLoading = false;
  List<SysFileDescriptor> files = <SysFileDescriptor>[];

  Future<List<TsadvPortalFeedback>> getFeedbackList(dynamic view) async {
    feedbackList = await RestServices.getFeedbackList(view);
    return feedbackList;
  }

  bool get isAllFilesUploaded {
    for (int i = 0; i < files.length; i++) {
      if (files[i].id.isEmpty) return false;
    }
    return true;
  }
}
