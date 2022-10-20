import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:video_example/src/hls/hls_fetcher.dart';
import 'package:video_example/src/hls/hls_master_playlist.dart';
import 'package:video_example/src/hls/hls_parser.dart';
import 'package:video_example/src/utils/urls.dart';
import 'package:video_player/video_player.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  var timer;
  var stopToggle = false;

  VideoCubit(
    String url,
  ) : super(VideoState.initialize(
            url: url,
            subtitle: _loadCaptions(),
            masterPlaylist: _parsePlaylist(url))) {
    state.controller.initialize().then((_) {
      emit(state.copyWith(
        loaded: true,
      ));
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
    state.controller.addListener(() {
      emit(state.copyWith());
    });
    state.controller.play();
  }
  void toggleControls() {
    if (!stopToggle) {
      emit(state.copyWith(
        showUI: !state.showUI,
      ));
      if (state.showUI && state.controller.value.isPlaying) {
        _startTimer();
      } else {
        _cancelTimer();
      }
    }
  }

  void showUIConstant() {
    stopToggle = true;
    emit(state.copyWith(
      showUI: true,
    ));
  }

  void toggleLongDrag() {
    emit(state.copyWith(
      isLongDrag: !state.isLongDrag,
    ));
  }

  void doNotShowUIConstant() {
    stopToggle = false;
  }

  void panelOpen() {
    _cancelTimer();
    emit(state.copyWith(isPanelOpen: true));
  }

  void panelClose() {
    _startTimer();
    emit(state.copyWith(
      isPanelOpen: false,
    ));
  }

  void speedSliderOpen() {
    _cancelTimer();
    emit(state.copyWith(isSpeedSliderOpen: true, showUI: false));
  }

  void speedSliderClose() {
    _startTimer();
    emit(state.copyWith(isSpeedSliderOpen: false, showUI: true));
  }

  void popUpOpen() {
    emit(state.copyWith(showUI: false));
  }

  void changeRes(String url, String res) {
    _cancelTimer();
    Duration pos = state.controller.value.position;
    state.controller.dispose().then((_) {
      emit(VideoState.initialize(
          url: url,
          masterPlaylist: state.masterPlaylist,
          subtitle: state.controller.closedCaptionFile,
          previousState: state.copyWith(loaded: false)));
      state.controller.initialize().then((_) {
        emit(state.copyWith(loaded: true, currentResolution: res));
        state.controller.seekTo(pos);
      });
      state.controller.addListener(() {
        emit(state.copyWith());
      });
      state.controller.play();
    });
  }

  void changeLanguage(String language) {
    if (language == state.currentLanguage) return;

    String subtitleUrl =
        Urls.BASEURL + Urls.VIDEOPATH + "/" + language + "/" + "subtitle.srt";
    String url = "";
    if (state.currentResolution == "auto")
      url =
          Urls.BASEURL + Urls.VIDEOPATH + "/" + language + "/" + "master.m3u8";
    else
      url = Urls.BASEURL +
          Urls.VIDEOPATH +
          "/" +
          language +
          "/stream_" +
          state.currentResolution +
          "p" +
          "/prog_index.m3u8";

    Duration pos = state.controller.value.position;
    state.controller.dispose().then((_) {
      emit(VideoState.initialize(
          url: url,
          masterPlaylist: state.masterPlaylist,
          subtitle: _loadCaptions(subtitleUrl),
          previousState:
              state.copyWith(loaded: false, currentLanguage: language)));
      state.controller.initialize().then((_) {
        emit(state.copyWith(loaded: true));
        state.controller.seekTo(pos);
      });
      state.controller.addListener(() {
        emit(state.copyWith());
      });
      state.controller.play();
    });
  }

  void startVideo(String url) {
    _cancelTimer();
    state.controller.dispose().then((_) {
      emit(VideoState.initialize(
          url: url,
          subtitle: _loadCaptions(),
          masterPlaylist: _parsePlaylist(url)));
      state.controller.initialize().then((_) {
        emit(state.copyWith(
          loaded: true,
        ));
      });
      state.controller.addListener(() {
        emit(state.copyWith());
      });
      state.controller.play();
    });
  }

  void togglePlay() {
    state.isPlaying ? state.controller.pause() : state.controller.play();
    emit(state.copyWith(
      isPlaying: !state.isPlaying,
    ));
    if (state.isPlaying) {
      _startTimer();
    } else {
      _cancelTimer();
    }
  }

  void toggleSubtitle() {
    emit(state.copyWith(
      subtitleOn: !state.subtitleOn,
    ));
  }

  void _startTimer() {
    if (timer == null) {
      timer = Timer(Duration(seconds: 5), () {
        if (state.showUI && state.controller.value.isPlaying) {
          emit(state.copyWith(
            showUI: false,
          ));
        }
      });
    }
  }

  void _cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  Future<void> close() async {
    state.controller.dispose();
    super.close();
  }

  void rewind() {
    Duration newPosition =
        Duration(seconds: state.controller.value.position.inSeconds - 10);
    state.controller.seekTo(newPosition);
  }

  void seekToRelativePosition(BuildContext context, Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;

    double relative = globalPosition.dx / box.size.width;

    final Duration position = state.controller.value.duration * relative;
    state.controller.seekTo(position);
  }

  void fastForward() {
    Duration newPosition =
        Duration(seconds: state.controller.value.position.inSeconds + 10);
    state.controller.seekTo(newPosition);
  }

  static Future<ClosedCaptionFile> _loadCaptions([String? subtitleUrl]) async {
    Response res;
    if (subtitleUrl != null)
      res = await http.get(Uri.parse(subtitleUrl));
    else
      res = await http.get(Uri.parse(
          Urls.BASEURL + Urls.VIDEOPATH + "/" + "de" + "/" + "subtitle.srt"));
    return SubRipCaptionFile(utf8.decode(res.bodyBytes));
  }

  static Future<HlsMasterPlaylist> _parsePlaylist(String url) async {
    HlsMasterPlaylist playlist =
        HlsParser.parsePlaylist(url, await HlsFetcher.fetchHLS(url));
    return playlist;
  }
}
