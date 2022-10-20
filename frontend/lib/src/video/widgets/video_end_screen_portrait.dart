import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/utils/urls.dart';

import '../video.dart';

class VideoEndScreenPortrait extends StatelessWidget {
  const VideoEndScreenPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Image(
            height: MediaQuery.of(context).size.height,
            image: AssetImage("assets/1080.png"),
          ),
          Container(
            color: Colors.black54,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<VideoCubit>(context).startVideo(
                      Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4");
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(3.0),
                      color: Color.fromRGBO(69, 70, 63, 1)),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.repeat_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color.fromRGBO(69, 70, 63, 1)),
                      margin: EdgeInsets.only(right: 10, left: 10),
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sports_soccer,
                              color: Colors.white,
                              size: 28,
                            ),
                            Text(" Dieses Video üben",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color.fromRGBO(2, 219, 255, 1)),
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                            Text(" Zum Quiz in 3",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
