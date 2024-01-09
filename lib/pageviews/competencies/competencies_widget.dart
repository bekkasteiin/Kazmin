import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/person_assessments_response.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/competencies_model.dart';
import 'package:provider/provider.dart';

const  String fName = 'lib/pageviews/competencies/competencies_widget.dart';

class CompetenciesWidget extends StatefulWidget {
  final bool opened;
  final List<PersonAssessments> list;
  final List<AbstractDictionary> participantTypes;

  const CompetenciesWidget({@required this.list, @required this.opened, @required this.participantTypes, Key key}) : super(key: key);

  @override
  State<CompetenciesWidget> createState() => _CompetenciesWidgetState();
}

class _CompetenciesWidgetState extends State<CompetenciesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list.where((PersonAssessments element) {
        return widget.opened
            ? (element.statusCode != 'CLOSED' && element.participantStatusCode != 'SEND')
            : (element.participantStatusCode == 'SEND' || element.statusCode == 'CLOSED');
      }).map((PersonAssessments e) {
        // log('-->> $fName, build ->> PersonAssessments: ${e.toJson()}');
        return KzmCard(
          title: e.employeeFullName,
          statusColor: getColorByStatusCode(e.participantStatusCode),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.arrow_forward_ios,
                size: 16.w,
              ),
              SizedBox(
                height: 8.w,
              ),
              // Text(e.totalResult.toString()),
              Text(
                '${getparticipantNameByTypeCode(e.participantTypeCode)}  ${e.totalResult}%',
                style: Styles.mainTS.copyWith(color: Styles.appDarkGrayColor, fontSize: Styles.appAdvertsFontSize),
              )
            ],
          ),
          subtitle: e.sessionName,
          selected:
              // opened ?
              // ignore: always_specify_types
              () => Provider.of<CompetenciesModel>(context, listen: false).openAssesment(e).then((value) {
            if (mounted) {
              setState(() {});
            }
          }),
          // : null,
        );
      }).toList(),
    );
  }

  String getparticipantNameByTypeCode(String participantTypeCode) {
    return widget.participantTypes?.where((AbstractDictionary e) => e?.code == participantTypeCode)?.first?.instanceName ?? '';
    // if (participantTypeCode == 'EMPLOYEE') {
    //   return S.current.employee;
    // } else if (participantTypeCode == 'MANAGER') {
    //   return S.current.manager;
    // } else {
    //   // return S.current.superiorManager;
    //   return '';
    // }
  }
}
