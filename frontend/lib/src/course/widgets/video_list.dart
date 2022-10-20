import 'package:flutter/material.dart';
import 'package:video_example/src/course/model/course_video.dart';
import 'package:video_example/src/utils/urls.dart';
import 'video_list_element.dart';

class VideoList extends StatelessWidget {
  final bool trailerMode;
  final Function navigation;
  final List<CourseVideo> videos;
  final String? currentVideo;
  VideoList({
    Key? key,
    required this.trailerMode,
    required this.navigation,
    required this.videos,
    this.currentVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: videos.length,
            itemBuilder: (BuildContext context, int index) => Container(
                  key: Key("container $index"),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      child: InkWell(
                        onTap: () {
                          navigation(
                              context,
                              Urls.BASEURL + Urls.VIDEOPATH + "/de/master.m3u8",
                              videos,
                              videos[index].title);
                        },
                        child: VideoListElement(
                            url: videos[index].thumbnail,
                            duration: videos[index].videoDuration,
                            title: videos[index].title,
                            index: index,
                            size: videos.length,
                            currentVideo: currentVideo ?? ""),
                      ),
                    ),
                  ),
                )),
      ),
    ]);
  }
}
