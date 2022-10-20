import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_example/src/hls/hls_master_playlist.dart';
import 'package:video_example/src/utils/helper.dart';
import 'package:video_player/video_player.dart';

import '../video.dart';

class VideoControlsPortrait extends StatelessWidget {
  final VoidCallback onClickedFullScreen;

  final VideoPlayerController controller;

  final bool showUI;

  final bool subtitleOn;

  final bool isPanelOpen;
  final String currentRes;
  final String currentLanguage;
  final HlsMasterPlaylist? playlist;

  const VideoControlsPortrait(
      {Key? key,
      required this.onClickedFullScreen,
      required this.controller,
      required this.isPanelOpen,
      required this.showUI,
      required this.subtitleOn,
      required this.currentRes,
      required this.playlist,
      required this.currentLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 150),
          child: !isPanelOpen
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: (controller.value.position ==
                            controller.value.duration)
                        ? VideoEndScreenPortrait()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () => cubit.toggleSubtitle(),
                                        child: Icon(
                                          subtitleOn
                                              ? Icons.closed_caption
                                              : Icons.closed_caption_off,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SettingsMenu(
                                      isPortrait: true,
                                      currentRes: currentRes,
                                      playlist: playlist,
                                      currentLanguage: currentLanguage,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          controller.seekTo(
                                              controller.value.position -
                                                  Duration(seconds: 10));
                                        },
                                        child: SvgPicture.asset(
                                          "assets/icons/fbw.svg",
                                          key: Key("BackwardButton-Portrait"),
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.025),
                                    playPause(cubit),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.025),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          controller.seekTo(
                                              controller.value.position +
                                                  Duration(seconds: 10));
                                        },
                                        child: SvgPicture.asset(
                                          "assets/icons/fwd.svg",
                                          key: Key("ForwardButton-Portrait"),
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Helper.getPosition(controller
                                            .value.position.inMilliseconds),
                                        style: TextStyle(color: Colors.white),
                                        key: Key("VideoPosition-Portrait"),
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.fullscreen,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        onTap: onClickedFullScreen,
                                      ),
                                    ],
                                  ),
                                  ProgressBar(
                                    controller,
                                    barHeight: 6.0,
                                    isPortrait: true,
                                    circleSize: showUI ? 8 : 0,
                                  )
                                ],
                              ),
                            ],
                          ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget playPause(VideoCubit cubit) => Center(
        key: Key("Play-Pause-Portrait"),
        child: IconButton(
          icon: controller.value.isPlaying
              ? SvgPicture.asset("assets/icons/pause99.svg",
                  key: Key("pause-Button-Portrait"), width: 60)
              : SvgPicture.asset("assets/icons/play99.svg",
                  key: Key("play-Button-Portrait"), width: 60),
          onPressed: () => cubit.togglePlay(),
          iconSize: 75,
        ),
      );
}
