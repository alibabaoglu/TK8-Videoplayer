import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/academy/academy.dart';
import 'package:video_example/src/course/course.dart';
import 'package:video_example/src/video/video.dart';

class VideoScreen extends StatelessWidget {
  final bool courseVideo;
  final List videos;
  final String videoTitle;
  final String contextTitle;

  VideoScreen(
      {Key? key,
      required this.courseVideo,
      required this.videos,
      required this.videoTitle,
      required this.contextTitle})
      : super(key: key);

  void _startVideo(BuildContext context, url, videos, String videoTitle) {
    BlocProvider.of<VideoCubit>(context).startVideo(url);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isPortrait = Orientation.portrait == orientation;
      return Dismissible(
        direction: isPortrait ? DismissDirection.down : DismissDirection.none,
        key: UniqueKey(),
        onDismissed: (_) => Navigator.of(context).pop(),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 0,
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            return isPortrait
                ? Container(color: Colors.white, child: buildVideoPlayerPage())
                : buildVideoPlayerPageLandscape(context);
          }),
        ),
      );
    });
  }

  Widget buildVideoPlayerPageLandscape(BuildContext context) => Container(
          child: VideoPlayerContainer(
        videotitle: videoTitle,
      ));
  Widget buildVideoPlayerPage() {
    return Stack(
      children: [
        Column(
          children: [
            AspectRatio(aspectRatio: 1.78),
            VideoInfo(
                videoTitle: videoTitle,
                contextTitle: contextTitle,
                isCourseVideo: courseVideo),
            Expanded(
                child: courseVideo
                    ? VideoList(
                        trailerMode: true,
                        navigation: _startVideo,
                        videos: videos as List<CourseVideo>,
                        currentVideo: videoTitle,
                      )
                    : CategoryVideosVertical(
                        videos: videos as List<CategoryVideo>,
                        navigation: _startVideo,
                      )),
          ],
        ),
        VideoPlayerContainer(
          videotitle: videoTitle,
        ),
      ],
    );
  }
}
