import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kzm/core/constants/svg_icons.dart';
import 'package:kzm/layout/loader_layout.dart';

class CachedImage extends StatelessWidget {
  final String url;

  const CachedImage(this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (BuildContext context, String string) => const Center(
        child: LoaderWidget(),
      ),
      errorWidget: (BuildContext context, String url, error) => Center(
          child: SvgPicture.asset(
        SvgIconData.noImage,
        color: Colors.grey,
      ),
          // Icon(
          //   Icons.image_not_supported_outlined,
          //   color: Colors.redAccent,
          //   size: 32.w,
          // ),
          ),
    );
  }
}
