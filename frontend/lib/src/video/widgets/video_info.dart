import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  final String videoTitle;
  final String contextTitle;
  final bool isCourseVideo;

  const VideoInfo(
      {Key? key,
      required this.videoTitle,
      required this.contextTitle,
      required this.isCourseVideo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity(
              vertical: -4,
            ),
            title: Container(
                padding: EdgeInsets.only(bottom: 2), child: Text(videoTitle)),
            subtitle: isCourseVideo
                ? Text("Kurs:  ${contextTitle}")
                : Text("Kategorie: ${contextTitle}"),
          ),
          Divider(
            color: Colors.grey[400],
            height: 1,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
