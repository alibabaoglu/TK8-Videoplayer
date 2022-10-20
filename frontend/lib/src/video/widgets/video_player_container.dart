import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_example/src/video/video.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerContainer extends StatefulWidget {
  static final Color theme = Color.fromRGBO(97, 216, 250, 100);

  final String videotitle;

  const VideoPlayerContainer({Key? key, required this.videotitle})
      : super(key: key);

  @override
  VideoPlayerContainerState createState() => VideoPlayerContainerState();
}

class VideoPlayerContainerState extends State<VideoPlayerContainer> {
  Orientation? target;
  String get videoTitle => widget.videotitle;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    target = Orientation.portrait;
    NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;
      final isLandscape = event == NativeDeviceOrientation.landscapeLeft ||
          event == NativeDeviceOrientation.landscapeRight;
      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

//Helper??
  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (_, state) {
        return state.loaded
            ? Container(child: buildVideo(state, sliderCubit, cubit))
            : Container(
                color: Colors.black,
                height: 200,
                child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildVideo(
          VideoState state, SliderCubit sliderCubit, VideoCubit cubit) =>
      BlocBuilder<SliderCubit, SliderState>(
        builder: (ctx, sliderState) {
          return OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;

              setOrientation(isPortrait);
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    cubit.toggleControls();
                  },
                  child: LongPressDraggable(
                    hapticFeedbackOnStart: true,
                    feedback: SizedBox.shrink(),
                    delay: Duration(milliseconds: 300),
                    onDragStarted: () {
                      if (!state.controller.value.isInitialized) {
                        return;
                      }

                      cubit.toggleLongDrag();

                      sliderCubit.resetSliderValue();

                      if (state.controller.value.isPlaying) {
                        state.controller.pause();
                      }
                      sliderCubit.toggleSlider(true);
                    },
                    onDragUpdate: (details) {
                      if (!state.controller.value.isInitialized) {
                        return;
                      }

                      cubit.seekToRelativePosition(
                          context, details.localPosition);
                    },
                    onDragEnd: (details) {
                      if (!state.controller.value.isPlaying) {
                        state.controller.play();
                      }
                      cubit.toggleLongDrag();

                      sliderCubit.resetSliderValue();
                    },
                    child: Stack(
                      key: Key("VideoPlayerContainer"),
                      fit: isPortrait ? StackFit.loose : StackFit.expand,
                      children: <Widget>[
                        Video(controller: state.controller),
                        Positioned.fill(
                          child: VideoOverlay(
                            state,
                            isPortrait: isPortrait,
                            sliderState: sliderState,
                            videotitle: videoTitle,
                            onClickedFullScreen: () {
                              target = isPortrait
                                  ? Orientation.landscape
                                  : Orientation.portrait;
                              if (isPortrait) {
                                AutoOrientation.landscapeRightMode();
                              } else {
                                AutoOrientation.portraitUpMode();
                              }
                            },
                          ),
                        ),
                        Positioned.fill(
                          bottom: isPortrait ? 0 : 50,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              child: state.subtitleOn
                                  ? ClosedCaption(
                                      key: Key("SubtitleContainer"),
                                      textStyle: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      text: state.controller.value.caption.text)
                                  : SizedBox.shrink(),
                            ),
                          ),
                        ),
                        if (!state.showUI) DoubleTap(),
                      ],
                    ),
                  ));
            },
          );
        },
      );
}
