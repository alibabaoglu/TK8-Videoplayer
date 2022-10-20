import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/hls/hls_master_playlist.dart';
import '../video.dart';

class VideoOverlay extends StatelessWidget {
  final VideoState state;
  final bool isPortrait;
  final VoidCallback onClickedFullScreen;
  final SliderState sliderState;
  final String videotitle;
  VideoOverlay(
    this.state, {
    Key? key,
    required this.isPortrait,
    required this.onClickedFullScreen,
    required this.sliderState,
    required this.videotitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.controller.value.duration == state.controller.value.position) {
      BlocProvider.of<VideoCubit>(context).showUIConstant();
    } else {
      BlocProvider.of<VideoCubit>(context).doNotShowUIConstant();
    }
    return FutureBuilder<HlsMasterPlaylist>(
        future: state.masterPlaylist,
        builder: (context, AsyncSnapshot<HlsMasterPlaylist> snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            key: Key("overlayContainer"),
            child: state.showUI && !state.isLongDrag
                ? Container(
                    color: Colors.black26,
                    child: isPortrait
                        ? VideoControlsPortrait(
                            onClickedFullScreen: onClickedFullScreen,
                            controller: state.controller,
                            isPanelOpen: state.isPanelOpen,
                            showUI: state.showUI,
                            subtitleOn: state.subtitleOn,
                            currentRes: state.currentResolution,
                            playlist: snapshot.data,
                            currentLanguage: state.currentLanguage)
                        : Stack(
                            children: [
                              Positioned.fill(
                                top: 10,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    videotitle,
                                    style: TextStyle(
                                        fontFamily: "RevxNeue",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              VideoControlsLandscape(
                                  isPanelOpen: state.isPanelOpen,
                                  onClickedFullScreen: onClickedFullScreen,
                                  subtitleOn: state.subtitleOn,
                                  controller: state.controller,
                                  isSpeedSliderOpen: state.isSpeedSliderOpen,
                                  showUI: state.showUI,
                                  currentRes: state.currentResolution,
                                  videoTitle: videotitle,
                                  playlist: snapshot.data,
                                  currentLanguage: state.currentLanguage),
                            ],
                          ))
                : AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    child: state.isLongDrag
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.86,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LongPressSlider(
                                      currentSliderValue:
                                          sliderState.sliderValue,
                                      isPortrait: isPortrait),
                                  ProgressBar(
                                    state.controller,
                                    barHeight: 6.0,
                                    isPortrait: isPortrait,
                                    circleSize: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : isPortrait
                            ? Column(key: Key("Potrait container"), children: [
                                Spacer(),
                                Spacer(),
                                ProgressBar(
                                  state.controller,
                                  barHeight: 6.0,
                                  isPortrait: isPortrait,
                                  circleSize: 0,
                                )
                              ])
                            : SizedBox.shrink()),
          );
        });
  }
}
