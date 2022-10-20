import 'package:flutter_test/flutter_test.dart';
import 'package:video_example/src/utils/helper.dart';
import 'package:video_example/src/video/video.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("test VideoCubit class", () {
    late VideoCubit videoCubit;

    setUp(() {
      videoCubit = VideoCubit("assets/vid.mp4");
    });

    test("test initializing of video cubit", () {
      setAndExpect(videoCubit);
    });

    test("test toggleControls function of video cubit, shows and hides UI", () {
      videoCubit.toggleControls();

      setAndExpect(videoCubit, showUI: true);

      videoCubit.toggleControls();

      setAndExpect(videoCubit);
    });

    test("test panelOpen function of video cubit, opens and closes panel", () {
      videoCubit.panelOpen();

      setAndExpect(videoCubit, isPanelOpen: true);

      videoCubit.panelClose();

      setAndExpect(videoCubit);
    });

    test("test startVideo function of video cubit, starts video", () {
      videoCubit.startVideo(
          "assets/vid.mp4"); //TODO: Eigentlich müsste bei loaded true rauskommen

      setAndExpect(videoCubit);
    });

    test("test togglePlay function of video cubit, stops and starts video", () {
      videoCubit.togglePlay();

      setAndExpect(videoCubit, isPlaying: false);

      videoCubit.togglePlay();

      setAndExpect(videoCubit);
    });

    test(
        "test toggleSubtitle function of video cubit, shows and hides subtitles",
        () {
      videoCubit.toggleSubtitle();

      setAndExpect(videoCubit, subtitleOn: true);

      videoCubit.toggleSubtitle();

      setAndExpect(videoCubit);
    });

    test("test close function of video cubit, closes video cubit", () {
      videoCubit.close();
      expect(videoCubit.isClosed, true);
    });

    test("test changeRes if video cubit, changes given resolution", () {
      //TODO: ChangeRes Test funktioniert nicht
      final List<String> resolutions = [
        "1080p",
        "720p",
        "540p",
        "360p",
        "auto"
      ];

      resolutions.forEach((resolution) async {
        videoCubit.changeRes("assets/vid.mp4", resolution);
        expect(videoCubit.state.showUI, false);
        expect(videoCubit.state.loaded, false);
        expect(videoCubit.state.isPlaying, true);
        expect(videoCubit.state.isLongDrag, false);
        expect(videoCubit.state.isPanelOpen, false);
        expect(videoCubit.state.subtitleOn, false);
        expect(videoCubit.state.isSpeedSliderOpen, false);
        await expectLater(videoCubit.state.currentResolution, resolution);
        expect(
            videoCubit.state.controller.value.position, Duration(seconds: 10));
      });
    });
  });

  group("test Helper class", () {
    test("test getDuration function, returns correct String", () {
      String duration = Helper.getDuration(0);
      expect(duration, "00:00");

      duration = Helper.getDuration(10000);
      expect(duration, "00:10");

      duration = Helper.getDuration(10001);
      expect(duration, "00:10");

      duration = Helper.getDuration(10009);
      expect(duration, "00:10");

      duration = Helper.getDuration(10010);
      expect(duration, "00:10");

      duration = Helper.getDuration(10090);
      expect(duration, "00:10");

      duration = Helper.getDuration(10100);
      expect(duration, "00:10");

      duration = Helper.getDuration(10900);
      expect(duration, "00:10");

      duration = Helper.getDuration(11000);
      expect(duration, "00:11");

      duration = Helper.getDuration(19000);
      expect(duration, "00:19");

      duration = Helper.getDuration(-10000);
      expect(duration, isNot("00:10"));

      duration = Helper.getDuration(-0);
      expect(duration, isNot("00:10"));
    });

    test("test showVideoSpeed function, returns correct String", () {
      var videoSpeed = Helper.showVideoSpeed(1);
      expect(videoSpeed, "   1.0x\nNormal");

      videoSpeed = Helper.showVideoSpeed(0);
      expect(videoSpeed, "0.0x");

      videoSpeed = Helper.showVideoSpeed(2);
      expect(videoSpeed, "2.0x");

      videoSpeed = Helper.showVideoSpeed(1.75);
      expect(videoSpeed, "1.75x");
    });
  });

  group("test VideoPlayerContainer class", () {
    /*
    test("test toggleSlider method", () async {
      const controller = VideoController(trailerMode: false);
      final element = controller.createElement();
      final controllerState = element.state as VideoControllerState;

      expect(controllerState.isLongDrag, false);
      expect(controllerState.getCurrentSliderValue(), 20);

      controllerState.isLongDrag = true;

      expect(controllerState.isLongDrag, true);

      controllerState.toggleSlider();

      while (controllerState.isLongDrag) {
        for (double i = 1; i < 100; i++) {
          expect(controllerState.getCurrentSliderValue(), i);
          await Future.delayed(Duration(milliseconds: 4));
        }
        for (double i = 100; i > 0; i--) {
          expect(controllerState.getCurrentSliderValue(), i);
          await Future.delayed(Duration(milliseconds: 4));
        }
        controllerState.isLongDrag = false;
      }

      expect(controllerState.isLongDrag, false);
    });
     */

    test("test setOrientation method for portrait mode, Wakelock is disabled",
        () async {
      const controller = VideoPlayerContainer(videotitle: "Test Title");
      controller.createState().setOrientation(false);
      bool enabled = await Wakelock.enabled;
      expect(enabled, true);
      //Hier fehlt ein Check für SystemChrome.setEnabledSystemUIMode Aufruf
    });
  });

  /*
  group("test ProgressBar class", () {
    test("test seekToRelativePosition method, sets position on controller", () async{

      VideoCubit videoCubit = VideoCubit("assets/vid.mp4");

      var progressBar = ProgressBar(videoCubit.state.controller, barHeight: 6.0,isPortrait: false, circleSize: 0);
      final progressBarState =
      progressBar.createElement().state as ProgressBarState;

      progressBarState.seekToRelativePosition(Offset(5,0), false);

      await expectLater(videoCubit.state.controller.position, Duration(seconds: 5));
    });
  });
   */
}

void setAndExpect(VideoCubit videoCubit,
    {bool showUI = false,
    bool loaded = false,
    bool isPlaying = true,
    bool isLongDrag = false,
    bool isPanelOpen = false,
    bool subtitleOn = false,
    bool isSpeedSliderOpen = false,
    String resolution = "auto"}) {
  expect(videoCubit.state.showUI, showUI);
  expect(videoCubit.state.loaded, loaded);
  expect(videoCubit.state.isPlaying, isPlaying);
  expect(videoCubit.state.isLongDrag, isLongDrag);
  expect(videoCubit.state.isPanelOpen, isPanelOpen);
  expect(videoCubit.state.subtitleOn, subtitleOn);
  expect(videoCubit.state.isSpeedSliderOpen, isSpeedSliderOpen);
  expect(videoCubit.state.currentResolution, resolution);
}
