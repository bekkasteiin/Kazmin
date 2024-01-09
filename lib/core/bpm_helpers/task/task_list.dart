import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzm/core/bpm_helpers/task/outcomes.dart';
import 'package:kzm/core/bpm_helpers/task/task_item.dart';
import 'package:kzm/core/components/widgets/content_shadow.dart';
import 'package:kzm/core/constants/UI_design.dart';
import 'package:kzm/core/models/abstract/abstract_bpm_request.dart';
import 'package:kzm/core/models/bpm/ext_task_data.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';

class BpmTaskList<T extends AbstractBpmModel> extends StatelessWidget {
  final T model;

  const BpmTaskList(this.model);

  @override
  Widget build(BuildContext context) {
    if (model.tasks == null || model.request.id == null) {
      return const SizedBox();
    }

    return KzmContentShadow(
      title: S.current.approvalSteps,
      child: Column(
        children: <Widget>[
          if (model.tasks != null)
            ...model.tasks.map((ExtTaskData e) {
              return TaskItem(e);
            }).toList(),
          FutureBuilder<String>(
            future: model.getPersonGroupId(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: LoaderWidget(),
                );
              }
              return Padding(
                padding: paddingLR,
                child: Column(
                  children: <Widget>[
                    OutcomesWidget<AbstractBpmModel<AbstractBpmRequest>>(model),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
