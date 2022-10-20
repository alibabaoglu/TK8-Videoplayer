import 'package:video_example/src/hls/hls_master_playlist.dart';
import 'package:video_player/video_player.dart';

class VideoState {
  VideoState._({
    required this.controller,
    required this.showUI,
    required this.loaded,
    required this.isLongDrag,
    required this.isPlaying,
    required this.isPanelOpen,
    required this.subtitleOn,
    required this.isSpeedSliderOpen,
    required this.currentResolution,
    required this.currentLanguage,
    required this.masterPlaylist,
  });

  factory VideoState.initialize(
      {required String url,
      Future<ClosedCaptionFile>? subtitle,
      Future<HlsMasterPlaylist>? masterPlaylist,
      VideoState? previousState}) {
    final controller =
        VideoPlayerController.network(url, closedCaptionFile: subtitle);

    return VideoState._(
        controller: controller,
        showUI: previousState?.showUI ?? false,
        loaded: previousState?.loaded ?? false,
        isPlaying: previousState?.isPlaying ?? true,
        isLongDrag: previousState?.isLongDrag ?? false,
        isPanelOpen: previousState?.isPanelOpen ?? false,
        subtitleOn: previousState?.subtitleOn ?? false,
        isSpeedSliderOpen: previousState?.isSpeedSliderOpen ?? false,
        currentResolution: previousState?.currentResolution ?? "auto",
        currentLanguage: previousState?.currentLanguage ?? "de",
        masterPlaylist: masterPlaylist);
  }

  final VideoPlayerController controller;
  final bool showUI;
  final bool isLongDrag;
  final bool isPanelOpen;
  final bool loaded;
  final bool isPlaying;
  final bool subtitleOn;
  final bool isSpeedSliderOpen;
  final String currentResolution;
  final String currentLanguage;
  final Future<HlsMasterPlaylist>? masterPlaylist;

  VideoState copyWith(
      {VideoPlayerController? controller,
      bool? showUI,
      bool? isLongDrag,
      bool? loaded,
      bool? isPlaying,
      bool? isPanelOpen,
      bool? subtitleOn,
      bool? isSpeedSliderOpen,
      String? currentResolution,
      String? currentLanguage,
      Future<HlsMasterPlaylist>? masterPlaylist}) {
    return VideoState._(
        controller: controller ?? this.controller,
        showUI: showUI ?? this.showUI,
        loaded: loaded ?? this.loaded,
        isPlaying: isPlaying ?? this.isPlaying,
        isLongDrag: isLongDrag ?? this.isLongDrag,
        isPanelOpen: isPanelOpen ?? this.isPanelOpen,
        subtitleOn: subtitleOn ?? this.subtitleOn,
        isSpeedSliderOpen: isSpeedSliderOpen ?? this.isSpeedSliderOpen,
        currentResolution: currentResolution ?? this.currentResolution,
        currentLanguage: currentLanguage ?? this.currentLanguage,
        masterPlaylist: masterPlaylist ?? this.masterPlaylist);
  }
}
