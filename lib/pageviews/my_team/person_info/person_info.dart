import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kzm/core/components/widgets/blue_button.dart';
import 'package:kzm/core/components/widgets/cached_image.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/viewmodels/my_team_model.dart';

class PersonInfoWidget extends StatelessWidget {
  final MyTeamModel model;

  const PersonInfoWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CirclePersonAvatarMyTeam(
            size: w / 4.5,
            imageId: model.personProfile?.imageId ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.fio,
            textValue: model.personProfile?.fullName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.position,
            textValue: model.personProfile?.positionName ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.phone1,
            textValue: model.personProfile?.phone ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.email,
            textValue: model.personProfile?.email ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.bithDate,
            textValue: formatShortly(model.personProfile?.birthDate),
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.sex,
            textValue: model.personProfile?.sex ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.citizenship,
            textValue: model.personProfile?.citizenship ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.cityOfResidence,
            textValue: model.personProfile?.cityOfResidence ?? '',
          ),
          FieldBones(
            editable: false,
            placeholder: S.current.employmentDate,
            textValue: formatShortly(model.personProfile?.hireDate),
          ),
          Padding(
            padding: EdgeInsets.only(top: Styles.appDoubleMargin),
            child: KzmOutlinedBlueButton(
              caption: S.current.download,
              enabled: true,
              onPressed: () {
                model.downloadEmployeeProfile(context: context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePersonAvatarMyTeam extends StatelessWidget {
  final double size;
  final String imageId;

  const CirclePersonAvatarMyTeam({@required this.size, this.imageId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: showImage(imageId),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.hasData){
            return ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: size,
                width: size,
                child: imageId != null && snapshot.data ?
                CachedImage(Kinfolk.getFileUrl(imageId) as String)
                    : SvgPicture.asset(SvgIconData.avatar),
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
    );

  }
  Future<bool> showImage(String id)async{
    final http.Request request = http.Request('GET', Uri.parse(Kinfolk.getFileUrl(id).toString()));
    final http.StreamedResponse response = await request.send();
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }
}
