import 'package:flutter/cupertino.dart';

class TileData {
  final String name;
  final String url;
  final String svgIcon;
  final bool showOnMainScreen;
  final VoidCallback onTap;

  TileData({@required this.name, @required this.url, @required this.svgIcon,  this.showOnMainScreen,this.onTap});
}
