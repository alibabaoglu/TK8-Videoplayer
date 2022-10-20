import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:video_example/src/utils/urls.dart';

import '../video.dart';

class VideoEndScreenLandscape extends StatelessWidget {
  const VideoEndScreenLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'assets/1080.png',
            fit: BoxFit.fill,
          ),
          Container(
            color: Colors.black54,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "Der mit dem Ball tanzt: Körpertäuschung",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    ],
                  ),
                  Spacer(),
                  Align(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 20),
                        child: Text(
                          "Mehr Videos",
                          style: TextStyle(color: Colors.white),
                        )),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          width: 160,
                          child: Column(
                            children: [
                              for (var i = 0; i < 2; i++)
                                InkWell(
                                  onTap: () {
                                    cubit.startVideo(Urls.BASEURL +
                                        Urls.VIDEOPATH +
                                        "/de/1080p.mp4");
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              "assets/thumbnail/thumbnail${i}.jpeg",
                                              fit: BoxFit.contain,
                                              width: 160,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 6,
                                            right: 6,
                                            child: Opacity(
                                              opacity: 0.7,
                                              child: Container(
                                                color: Colors.black,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2, right: 2),
                                                  child: Text("2:23",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 3, bottom: 10),
                                          child: Text(
                                            "Der mit dem Ball...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<VideoCubit>(context).startVideo(
                                  Urls.BASEURL +
                                      Urls.VIDEOPATH +
                                      "/de/1080p.mp4");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
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
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ]));
  }
}
