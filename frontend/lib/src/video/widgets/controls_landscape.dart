import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/hls/hls_master_playlist.dart';
import 'package:video_example/src/utils/helper.dart';
import 'package:video_example/src/video/video.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoControlsLandscape extends StatelessWidget {
  final bool isPanelOpen;
  final VoidCallback onClickedFullScreen;
  final bool subtitleOn;
  final VideoPlayerController controller;
  final bool isSpeedSliderOpen;
  final bool showUI;
  final String currentRes;
  final String videoTitle;
  final String currentLanguage;

  final HlsMasterPlaylist? playlist;

  const VideoControlsLandscape(
      {Key? key,
      required this.isPanelOpen,
      required this.onClickedFullScreen,
      required this.subtitleOn,
      required this.controller,
      required this.isSpeedSliderOpen,
      required this.showUI,
      required this.currentRes,
      required this.videoTitle,
      required this.playlist,
      required this.currentLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return (controller.value.position == controller.value.duration)
        ? VideoEndScreenLandscape()
        : Stack(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              topControls(context, cubit),
                              midControls(context, cubit),
                              bottomControls(context)
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              !isSpeedSliderOpen && showUI
                  ? Recommendation(isPanelOpen: isPanelOpen)
                  : SizedBox.shrink(),
            ],
          );
  }

  Widget topControls(context, VideoCubit cubit) {
    return Container(
      margin: EdgeInsets.only(top: 5, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => cubit.toggleSubtitle(),
              child: Icon(
                subtitleOn ? Icons.closed_caption : Icons.closed_caption_off,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          SettingsMenu(
            isPortrait: false,
            currentRes: currentRes,
            playlist: playlist,
            currentLanguage: currentLanguage,
          ),
        ],
      ),
    );
  }

  Widget midControls(context, cubit) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                controller
                    .seekTo(controller.value.position - Duration(seconds: 10));
              },
              child: SvgPicture.asset(
                "assets/icons/fbw.svg",
                key: Key("BackwardButton-Landscape"),
                width: 100,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: playPause(cubit)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                controller
                    .seekTo(controller.value.position + Duration(seconds: 10));
              },
              child: SvgPicture.asset(
                "assets/icons/fwd.svg",
                key: Key("ForwardButton-Landscape"),
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomControls(context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpeedSlider(isPortrait: false),
          SizedBox(
            width: 50,
            child: Text(
              Helper.getPosition(controller.value.position.inMilliseconds),
              key: Key("VideoPosition-Landscape"),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            margin: EdgeInsets.only(right: 10),
            child: ProgressBar(
              controller,
              barHeight: 6.0,
              isPortrait: false,
              circleSize: showUI ? 8 : 0,
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              Helper.getDuration(controller.value.duration.inMilliseconds),
              key: Key("VideoDuration-Landscape"),
              style: TextStyle(color: Colors.white),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: 35,
            ),
            onTap: onClickedFullScreen,
          ),
        ],
      ),
    );
  }

  Widget playPause(VideoCubit cubit) => Center(
        key: Key("Play-Pause-Landscape"),
        child: IconButton(
          icon: controller.value.isPlaying
              ? SvgPicture.asset("assets/icons/pause99.svg",
                  key: Key("pause-Button-Landscape"), width: 120)
              : SvgPicture.asset("assets/icons/play99.svg",
                  key: Key("play-Button-Landscape"), width: 120),
          onPressed: () => cubit.togglePlay(),
          iconSize: 75,
        ),
      );
}
