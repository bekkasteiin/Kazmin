import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String url;

  const NetworkVideoPlayer({Key key, this.url}) : super(key: key);

  @override
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.FULL,
      autoPlay: true,
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
  }

  @override
  Widget build(BuildContext context) {
    return VlcPlayer(
      controller: _videoPlayerController,
      aspectRatio: 16 / 9,
      placeholder: const Center(child: CircularProgressIndicator()),
    );
  }
}
