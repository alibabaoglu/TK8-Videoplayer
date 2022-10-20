import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatelessWidget {
  const Video({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  Widget buildVideoPlayer() {
    final video = AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: VideoPlayer(
        controller,
      ),
    );

    return video;
  }
}
