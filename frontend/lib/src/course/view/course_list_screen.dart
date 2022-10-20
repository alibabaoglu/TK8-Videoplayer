import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/course/course.dart';
import 'package:video_example/src/utils/video_screen_args.dart';
import 'package:video_example/src/video/video.dart';

class CourseListScreen extends StatelessWidget {
  final String title;

  CourseListScreen({Key? key, required this.title}) : super(key: key);

  void _startVideo(
      BuildContext context, url, List<CourseVideo> videos, videoTitle) {
    Navigator.pushNamed(
      context,
      "/video",
      arguments: VideoScreenArgs(true, videos, videoTitle, this.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CourseCubit>(context).getCourse(title);
    return OrientationBuilder(
      builder: (context, orientation) {
        return Orientation.portrait == orientation
            ? Scaffold(
                body: SafeArea(
                  bottom: false,
                  child: buildVideoPlayerPage(),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  Widget buildVideoPlayerPage() {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, courseState) {
        return Container(
          child: Column(children: [
            BlocBuilder<VideoCubit, VideoState>(builder: (_, state) {
              return Stack(
                fit: StackFit.loose,
                children: [
                  Video(controller: state.controller),
                  Positioned.fill(
                    child: TrailerOverlay(
                        controller: state.controller, courseTitle: title),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ],
              );
            }),
            courseState is CourseLoaded
                ? Expanded(
                    child: VideoList(
                    trailerMode: true,
                    videos: courseState.course.videos,
                    navigation: _startVideo,
                  ))
                : Center(child: CircularProgressIndicator())
          ]),
        );
      },
    );
  }
}
