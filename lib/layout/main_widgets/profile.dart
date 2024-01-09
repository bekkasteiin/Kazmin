import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kzm/core/components/widgets/circle_avatar.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class ProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel userModel = Provider.of<UserViewModel>(context);
    return FutureBuilder<PersonGroup>(
      future: userModel.personInfo,
      builder: (BuildContext context, AsyncSnapshot<PersonGroup> snapshot) {
        return (snapshot.connectionState != ConnectionState.done)
            ? SizedBox(
                height: 158.w,
                child: const LoaderWidget(),
              )
            : Container(
                // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildImageWithName(snapshot.data, context, userModel?.personProfile?.imageId),
                    Text(
                      snapshot.data?.currentAssignment?.positionGroup?.currentPosition?.organizationGroupExt?.currentOrganization?.instanceName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.mainTxtTheme.subtitle2,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget buildImageWithName(PersonGroup user, BuildContext context, String imageId) {
    return Padding(
      // padding: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CirclePersonAvatar(
            size: 100,
            imageId: imageId,
          ),
          SizedBox(width: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.66,
            child: RichText(
              softWrap: true,
              text: TextSpan(
                text: user?.instanceName ?? '',
                style: Styles.mainTxtTheme.headline6,
                children: <TextSpan>[
                  TextSpan(
                    text: '\n${user?.currentAssignment?.positionGroup?.instanceName ?? ''}',
                    style: Styles.mainTS.copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
