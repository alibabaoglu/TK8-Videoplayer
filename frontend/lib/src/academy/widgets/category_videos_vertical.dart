import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_example/src/academy/models/category_video.dart';
import 'package:video_example/src/utils/utils.dart';

class CategoryVideosVertical extends StatelessWidget {
  final List<CategoryVideo> videos;
  final Function navigation;

  CategoryVideosVertical(
      {Key? key, required this.videos, required this.navigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) => Container(
              margin: EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () => navigation(
                    context,
                    Urls.BASEURL + Urls.VIDEOPATH + "/de/master.m3u8",
                    videos,
                    videos[index].title),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          videos[index].thumbnail,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(videos[index].title,
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                          "Der Ballmagnet | ${videos[index].videoDuration}",
                          style: GoogleFonts.roboto(
                              fontSize: 11, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ));
  }
}
