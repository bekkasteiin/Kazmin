import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kzm/core/components/widgets/cached_image.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:http/http.dart' as http;
import 'package:kzm/core/service/kinfolk/kinfolk.dart';

class CirclePersonAvatar extends StatelessWidget {
  final double size;
  final String imageId;

  const CirclePersonAvatar({@required this.size, this.imageId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<bool>(
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

      }),
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
