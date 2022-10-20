import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class TrailerOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  final String courseTitle;

  TrailerOverlay(
      {Key? key, required this.controller, required this.courseTitle})
      : super(key: key);

  @override
  _TrailerOverlayState createState() => _TrailerOverlayState();
}

class _TrailerOverlayState extends State<TrailerOverlay> {
  VideoPlayerController get controller => widget.controller;
  Color theme = Color.fromRGBO(97, 216, 250, 100);
  String get courseTitle => widget.courseTitle;
  @override
  void initState() {
    controller.setVolume(0.0);
    super.initState();

    //controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoControls(context);
  }

  Widget videoControls(context) => Container(
      color: Color.fromRGBO(255, 97, 216, 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0, left: 10),
            child: Text(
              courseTitle,
              style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0, left: 10),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "Täuschungen und Finten die Toni häufig in seinem Spiel nutzt um Gegner auszuspielen",
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    "4 Videos",
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "9 Minuten",
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, left: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 97, 216, 250),
                      textStyle: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  icon: Icon(Icons.play_circle, size: 24),
                  label: Text("Gesamter Trailer"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black38,
                ),
                margin: EdgeInsets.only(right: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                        setState(() {});
                      },
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Text(
                                "Trailer",
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 24,
                                color: Colors.white,
                              ),
                            ],
                          ))),
                ),
              ),
            ],
          )
        ],
      ));
}
