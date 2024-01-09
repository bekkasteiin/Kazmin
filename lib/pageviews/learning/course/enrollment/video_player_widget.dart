import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  String url;

  VideoPlayerWidget(this.url);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState(url);
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  String url;
  VideoPlayerController _controller;

  _VideoPlayerWidgetState(this.url);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          // child: _controller.value.initialized
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
