import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/components/widgets/process_task_item.dart';
import 'package:kzm/core/models/entities/tsadv_ext_task_data.dart';

class KzmApprovingHistory extends StatelessWidget {
  // final List<ExtTaskData> processTasks;
  final List<TsadvExtTaskData> processTasks;

  const KzmApprovingHistory({@required this.processTasks});

  @override
  Widget build(BuildContext context) {
    return KzmContentShadow(
      title: 'История согласования'.tr,
      child: Column(
        // children: processTasks.map((ExtTaskData e) => KzmProcessTaskItem(taskData: e)).toList(),
        children: processTasks.map((TsadvExtTaskData e) => KzmProcessTaskItem(taskData: e)).toList(),
      ),
    );
  }
}
