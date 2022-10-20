import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_example/src/utils/utils.dart';
import 'package:video_example/src/video/video.dart';
import 'package:video_player/video_player.dart';

class HomeTextScreen extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeTextScreenState();
}

class _HomeTextScreenState extends State<HomeTextScreen> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) => BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          return PageView(
            onPageChanged: (value) {
              BlocProvider.of<VideoCubit>(context).startVideo(Urls.BASEURL +
                  Urls.VIDEOPATH +
                  "/home/homescreen${value}.mp4");
            },
            controller: controller,
            scrollDirection: Axis.vertical,
            children: [item(state), item(state), item(state)],
          );
        },
      );

  Widget item(state) {
    VideoPlayerController controller = state.controller;

    return Stack(
      fit: StackFit.expand,
      children: [
        Video(controller: controller),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.black38,
          child: Container(
            margin: EdgeInsets.only(left: 10, bottom: 20),
            child: controller.value.isInitialized
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 250,
                        child: Text(
                          'Check das neue Academy-Kapitel "Die Ballannahme" ab!',
                          style: TextStyle(
                              fontFamily: "RevxNeue",
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ElevatedButton.icon(
                        key: Key("HomeScreenButton"),
                        onPressed: () {
                          // Respond to button press
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 219, 255, 1.0),
                            textStyle: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        icon: Icon(Icons.play_circle, size: 24),
                        label: Text(
                          "Gesamter Trailer",
                          style: TextStyle(
                              fontFamily: "RevxNeue",
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        )
      ],
    );
  }
}
