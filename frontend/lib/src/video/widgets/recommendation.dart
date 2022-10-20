import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_example/src/utils/urls.dart';
import 'package:video_example/src/video/video.dart';

class Recommendation extends StatefulWidget {
  Recommendation({Key? key, required this.isPanelOpen}) : super(key: key);
  final bool isPanelOpen;
  State<StatefulWidget> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  bool get isPanelOpen => widget.isPanelOpen;
  PanelController _pc = new PanelController();

  //TODO: Empfehlungen mocken.
  List<String> titles = [
    "Spielnahe Schüssübung",
    "Zwischenkontakt",
    "Pass/ Weiterlaufen",
    "Ballannahme",
    "Die Schlussfinte",
    "Tonis Drive",
    "Meine Vorbilder",
    "Mein Lieblingsball"
  ];
  double pos = 0.0;
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return SlidingUpPanel(
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.black45,
          ),
        ],
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        color: Colors.transparent,
        controller: _pc,
        onPanelOpened: () => BlocProvider.of<VideoCubit>(context).panelOpen(),
        onPanelClosed: () => BlocProvider.of<VideoCubit>(context).panelClose(),
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        onPanelSlide: (position) => {
              setState(() {
                pos = position;
              })
            },
        panel: GestureDetector(
          onTap: () => _pc.close(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                    opacity: pos,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        "EMPFEHLUNGEN",
                        style: TextStyle(
                            fontFamily: "RevxNeue",
                            fontSize: 24 * pos,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: isPanelOpen
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    //controller: controller,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) => Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          cubit.startVideo(Urls.BASEURL +
                              Urls.VIDEOPATH +
                              "/de/master.m3u8");
                        },
                        child: Container(
                          height: 175,
                          padding: index == 0
                              ? EdgeInsets.only(left: 20)
                              : EdgeInsets.only(left: 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        "assets/thumbnail/thumbnail$index.jpeg",
                                        fit: BoxFit.contain,
                                        height: 150,
                                      ),
                                      Positioned(
                                        bottom: 6,
                                        right: 6,
                                        child: Container(
                                          color: Colors.black,
                                          child: Text("2:23",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              Text(
                                titles[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
