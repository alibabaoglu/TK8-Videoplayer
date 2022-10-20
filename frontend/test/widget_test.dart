// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';
// import 'package:video_example/main.dart';
// import 'package:video_example/src/academy/academy.dart';
// import 'package:video_example/src/course/course.dart';
// import 'package:video_example/src/utils/utils.dart';
// import 'package:video_example/src/video/video.dart';
// import 'video_player_test.dart' show FakeVideoPlayerPlatform;
// import 'package:bloc_test/bloc_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockVideoCubit extends MockCubit<VideoState> implements VideoCubit {}

// class VideoStateFake extends Fake implements VideoState {}

// //TODO: VideoCubit Mocken da  Video in Cubit wird nicht geladen wird.
// //
// //Tests funktionieren

// Future<void> main() async {
//   setUpAll(() async {
//     registerFallbackValue(VideoStateFake());
//   });

//   setUp(() {});

//   group("test App BottomNavigationBar", () {
//     testWidgets(
//         'test bottomNavigationBar, initializes and finds bottomNavigationBar items',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());

//       final sportSoccerIconTitle = find.byIcon(Icons.sports_soccer);
//       final homeIcon = find.byIcon(Icons.home);
//       final playerIcon = find.byIcon(Icons.ondemand_video_sharp);
//       final profileIcon = find.byIcon(Icons.person);
//       final noExistingIcon = find.byIcon(Icons.person_pin);

//       expect(sportSoccerIconTitle, findsNothing);
//       expect(homeIcon, findsOneWidget);
//       expect(playerIcon, findsOneWidget);
//       expect(profileIcon, findsOneWidget);
//       expect(noExistingIcon, findsNothing);
//     });
//   });

//   group("test HomePage Tab", () {
//     testWidgets('test HomeTextScreenText, finds Welcome Text',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());

//       final homeScreenText = find.text("Gesamter Trailer");
//       final showFullTrailerButton = find.byKey(ValueKey("HomeScreenButton"));

//       expect(find.byType(PageView), findsOneWidget);
//       expect(homeScreenText, findsOneWidget);
//       expect(showFullTrailerButton, findsOneWidget);
//     });
//   });

//   group("test Academy Tab", () {
//     testWidgets('test chapter text, finds chapter text academy page',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());
//       final academyButton = find.byKey(ValueKey("AcademyButton"));
//       await tester.tap(academyButton);
//       await tester.pump();

//       final chapterText = find.text("KAPITEL");
//       expect(chapterText, findsWidgets);
//     });

//     testWidgets('test chapter containers, finds all three chapter containers',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());
//       final academyButton = find.byKey(ValueKey("AcademyButton"));
//       await tester.tap(academyButton);
//       await tester.pump();

//       expect(find.byKey(ValueKey("Container1")), findsOneWidget);
//       expect(find.text("Der Ballmagnet"), findsOneWidget);
//       expect(find.text("5 Videos"), findsWidgets);
//       expect(find.text("18 Minuten"), findsWidgets);

//       expect(find.byKey(ValueKey("Container2")), findsOneWidget);
//       expect(find.text("Satte Schüsse"), findsOneWidget);
//       expect(find.text("5 Videos"), findsWidgets);
//       expect(find.text("18 Minuten"), findsWidgets);

//       expect(find.byKey(ValueKey("Container3")), findsOneWidget);
//       expect(find.text("Tonis Drive"), findsOneWidget);
//       expect(find.text("5 Videos"), findsWidgets);
//       expect(find.text("18 Minuten"), findsWidgets);
//     });

//     testWidgets('test horizontal lists, finds all three horizontal lists',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());
//       final academyButton = find.byKey(ValueKey("AcademyButton"));
//       await tester.tap(academyButton);
//       await tester.pump();

//       var horizontalList = find.byKey(ValueKey("HorizontalList3"));
//       await tester.scrollUntilVisible(horizontalList, 1000);
//       await tester.pumpAndSettle();
//       expect(find.byKey(ValueKey("VideoThumbnail0")), findsWidgets);
//       expect(find.text("Hier steht der Titel vom Video"), findsWidgets);
//       expect(find.byIcon(Icons.play_circle_filled_outlined), findsWidgets);
//     });
//   });

//   group("test CourseListScreen class", () {
//     testWidgets('test Traileroverlay text, finds Video and TrailerOverlay',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(500, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       await tester.pumpWidget(BlocProvider(
//           create: (_) =>
//               VideoCubit(Urls.BASEURL + Urls.VIDEOPATH + "/master.m3u8"),
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: CourseListScreen(
//                     title: 'Die Schlussfinte',
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(Video), findsWidgets);
//       expect(find.byType(TrailerOverlay), findsWidgets);

//       final trailerTitle = find.text("Arglistige Täuschung");
//       final trailerText = find.text(
//           "Täuschungen und Finten die Toni häufig in seinem Spiel nutzt um Gegner auszuspielen");
//       final numberVideos = find.text("4 Videos");
//       final numberMinutes = find.text("9 Minuten");

//       expect(trailerTitle, findsOneWidget);
//       expect(trailerText, findsOneWidget);
//       expect(numberVideos, findsOneWidget);
//       expect(numberMinutes, findsOneWidget);

//       final trailerPauseButton = find.byIcon(Icons.pause);
//       expect(trailerPauseButton, findsOneWidget);

//       await tester.tap(trailerPauseButton);
//       await tester.pump();

//       final trailerPlayButton = find.byIcon(Icons.play_arrow);
//       expect(trailerPlayButton, findsOneWidget);
//       expect(trailerPauseButton, findsNothing);

//       await tester.tap(trailerPlayButton);
//       await tester.pump();

//       expect(trailerPauseButton, findsOneWidget);
//       expect(trailerPlayButton, findsNothing);
//     });

//     testWidgets('test VideoList, finds elements in videoList',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(500, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       await tester.pumpWidget(BlocProvider(
//           create: (_) =>
//               VideoCubit(Urls.BASEURL + Urls.VIDEOPATH + "/master.m3u8"),
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: CourseListScreen(
//                     title: 'Die Schlussfinte',
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoList), findsWidgets);

//       final containerZero = find.byKey(ValueKey("container 0"));
//       expect(containerZero, findsOneWidget);
//       expect(find.byKey(ValueKey("VideoListElement0")), findsWidgets);
//       expect(find.text("Die Schlussfinte"), findsOneWidget);

//       final containerOne = find.byKey(ValueKey("container 1"));
//       expect(find.byKey(ValueKey("VideoListElement1")), findsWidgets);
//       expect(find.text("Zwischenkontakt"), findsOneWidget);

//       expect(find.text("Jetzt üben"), findsWidgets);

//       final containerTwo = find.byKey(ValueKey("container 2"));
//       await tester.scrollUntilVisible(containerTwo, 10);
//       await tester.pumpAndSettle();
//       expect(find.text("Pass / Weiterlaufen"), findsOneWidget);

//       final containerThree = find.byKey(ValueKey("container 3"));
//       await tester.scrollUntilVisible(containerThree, 10);
//       await tester.pumpAndSettle();
//       expect(find.text("Spielnahe Schussübung"), findsOneWidget);

//       expect(find.byIcon(Icons.check), findsWidgets);
//       expect(find.byKey(ValueKey("ShoeIcon")), findsWidgets);
//     });
//   });

//   group("test VideoScreen class - Portrait", () {
//     testWidgets('test VideoScreen in portrait, finds VideoPlayer and VideoList',
//         (WidgetTester tester) async {
//       AcademyRepository repo = new AcademyRepository();

//       Categories cat = await repo.fetchAllCategories();
//       cat.courses[0].videos;

//       await tester.binding.setSurfaceSize(Size(500, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoPlayerContainer), findsOneWidget);
//       expect(find.byType(CategoryVideosVertical), findsOneWidget);
//     });

//     testWidgets(
//         'test VideoPlayerContainer and UI in portrait, finds VideoPlayer including UI',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(530, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();
//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       expect(find.byType(VideoControlsPortrait), findsWidgets);
//       expect(find.byIcon(Icons.star_border), findsOneWidget);
//       expect(find.byIcon(Icons.closed_caption_off), findsOneWidget);
//       expect(find.byIcon(Icons.more_vert), findsOneWidget);
//       expect(find.byKey(ValueKey("BackwardButton-Portrait")), findsOneWidget);
//       expect(find.byKey(ValueKey("pause-Button-Portrait")), findsOneWidget);
//       expect(find.byKey(ValueKey("ForwardButton-Portrait")), findsOneWidget);
//       expect(find.byKey(ValueKey("VideoPosition-Portrait")), findsOneWidget);
//       expect(find.byType(ProgressBar), findsOneWidget);
//       expect(find.byIcon(Icons.fullscreen), findsOneWidget);
//     });

//     testWidgets(
//         'test pause play functionality in portrait, stops and plays video',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(530, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final pauseButton = find.byKey(ValueKey("pause-Button-Portrait"));
//       await tester.tap(pauseButton, warnIfMissed: false);
//       await tester.pump();

//       final playButton = find.byKey(ValueKey("play-Button-Portrait"));
//       expect(playButton, findsOneWidget);
//       expect(pauseButton, findsNothing);
//       await tester.tap(playButton, warnIfMissed: false);
//       await tester.pump();

//       expect(pauseButton, findsOneWidget);
//       expect(playButton, findsNothing);
//     });

//     testWidgets(
//         'test subtitle functionality in portrait, shows and hides subtitle',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(530, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final subtitleOffButton = find.byIcon(Icons.closed_caption_off);
//       await tester.tap(subtitleOffButton, warnIfMissed: false);
//       await tester.pump();

//       final subtitleOnButton = find.byIcon(Icons.closed_caption);
//       expect(subtitleOnButton, findsOneWidget);
//       expect(subtitleOffButton, findsNothing);
//       expect(find.byKey(ValueKey("SubtitleContainer")), findsOneWidget);

//       await tester.tap(subtitleOnButton, warnIfMissed: false);
//       await tester.pump();

//       expect(subtitleOffButton, findsOneWidget);
//       expect(subtitleOnButton, findsNothing);
//     });

//     testWidgets(
//         'test vertical three dots functionality in portrait, shows and hides additional setting options',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(530, 844));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();
//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final moreVertButton = find.byIcon(Icons.more_vert);
//       await tester.tap(moreVertButton, warnIfMissed: false);
//       await tester.pumpAndSettle();

//       final settingsWrapper = find.byKey(ValueKey("Settings"));
//       expect(settingsWrapper, findsOneWidget);

//       final qualitySettingsListTile =
//           find.byKey(ValueKey("QualitySettingsListTile"));
//       expect(qualitySettingsListTile, findsOneWidget);

//       final autoPlayListTile = find.byKey(ValueKey("AutoPlayListTile"));
//       expect(autoPlayListTile, findsOneWidget);

//       await tester.tap(qualitySettingsListTile, warnIfMissed: false);
//       await tester.pumpAndSettle();

//       final qualitySettingsWrapper = find.byKey(ValueKey("QualitySettings"));
//       expect(qualitySettingsWrapper, findsOneWidget);
//       expect(find.text("Automatisch"), findsOneWidget);
//       expect(find.text("1080p"), findsOneWidget);
//       expect(find.text("720p"), findsOneWidget);
//       expect(find.text("540p"), findsOneWidget);
//       expect(find.text("360p"), findsOneWidget);
//     });
//   });

//   group("test VideoScreen class - Landscape", () {
//     testWidgets(
//         'test VideoScreen in landscape, finds VideoPlayer and VideoList',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(844, 500));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoPlayerContainer), findsOneWidget);
//       expect(find.byType(VideoList), findsNothing);
//     });

//     testWidgets(
//         'test pause play functionality in landspace, stops and plays video',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(844, 530));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       expect(find.byType(VideoControlsLandscape), findsWidgets);

//       expect(find.byIcon(Icons.star_border), findsOneWidget);
//       expect(find.byKey(ValueKey("VideoTitle")), findsOneWidget);
//       expect(find.byIcon(Icons.closed_caption_off), findsOneWidget);
//       expect(find.byIcon(Icons.more_vert), findsOneWidget);
//       expect(find.byKey(ValueKey("BackwardButton-Landscape")), findsOneWidget);
//       expect(find.byKey(ValueKey("pause-Button-Landscape")), findsOneWidget);
//       expect(find.byKey(ValueKey("ForwardButton-Landscape")), findsOneWidget);
//       expect(find.byIcon(Icons.speed), findsOneWidget);
//       expect(find.byKey(ValueKey("VideoPosition-Landscape")), findsOneWidget);
//       expect(find.byType(ProgressBar), findsOneWidget);
//       expect(find.byKey(ValueKey("VideoDuration-Landscape")), findsOneWidget);
//       expect(find.byIcon(Icons.fullscreen), findsOneWidget);
//       expect(find.byType(Recommendation), findsOneWidget);
//     });

//     testWidgets(
//         'test pause play functionality in landscape, stops and plays video',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(844, 530));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();

//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();
//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final pauseButton = find.byKey(ValueKey("pause-Button-Landscape"));
//       await tester.tap(pauseButton, warnIfMissed: false);
//       await tester.pump();

//       final playButton = find.byKey(ValueKey("play-Button-Landscape"));
//       expect(playButton, findsOneWidget);
//       expect(pauseButton, findsNothing);
//       await tester.tap(playButton, warnIfMissed: false);
//       await tester.pump();

//       expect(pauseButton, findsOneWidget);
//       expect(playButton, findsNothing);
//     });

//     testWidgets(
//         'test subtitle functionality in landscape, shows and hides subtitle',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(844, 530));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();
//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();

//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final subtitleOffButton = find.byIcon(Icons.closed_caption_off);
//       await tester.tap(subtitleOffButton, warnIfMissed: false);
//       await tester.pump();

//       final subtitleOnButton = find.byIcon(Icons.closed_caption);
//       expect(subtitleOnButton, findsOneWidget);
//       expect(subtitleOffButton, findsNothing);
//       expect(find.byKey(ValueKey("SubtitleContainer")), findsOneWidget);

//       await tester.tap(subtitleOnButton, warnIfMissed: false);
//       await tester.pump();

//       expect(subtitleOffButton, findsOneWidget);
//       expect(subtitleOnButton, findsNothing);
//     });

//     testWidgets(
//         'test vertical three dots functionality in landscape, shows and hides additional setting options',
//         (WidgetTester tester) async {
//       await tester.binding.setSurfaceSize(Size(844, 530));
//       FakeVideoPlayerPlatform fakeVideoPlayerPlatform =
//           FakeVideoPlayerPlatform();
//       Categories cat = await fetchCat();
//       await tester.pumpWidget(MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) => VideoCubit(
//                 Urls.BASEURL + Urls.VIDEOPATH + "/de/1080p.mp4",
//               ),
//             ),
//             BlocProvider(
//               create: (_) => SliderCubit(),
//             ),
//           ],
//           child: ChangeNotifierProvider(
//               create: (context) => ThemeProvider(),
//               builder: (context, _) {
//                 final themeProvider = Provider.of<ThemeProvider>(context);
//                 return MaterialApp(
//                   home: VideoScreen(
//                     courseVideo: false,
//                     videos: cat.courses[0].videos,
//                     contextTitle: cat.courses[0].categoryTitle,
//                     videoTitle: "Die Schlussfinte",
//                   ),
//                 );
//               })));

//       await tester.pump();
//       expect(find.byType(VideoOverlay), findsWidgets);

//       final videoPlayerContainer = find.byKey(ValueKey("VideoPlayerContainer"));
//       await tester.tap(videoPlayerContainer, warnIfMissed: false);
//       await tester.pump();

//       final moreVertButton = find.byIcon(Icons.more_vert);
//       await tester.tap(moreVertButton, warnIfMissed: false);
//       await tester.pumpAndSettle();

//       final settingsWrapper = find.byKey(ValueKey("Settings"));
//       expect(settingsWrapper, findsOneWidget);

//       final qualitySettingsListTile =
//           find.byKey(ValueKey("QualitySettingsListTile"));
//       expect(qualitySettingsListTile, findsOneWidget);

//       final autoPlayListTile = find.byKey(ValueKey("AutoPlayListTile"));
//       expect(autoPlayListTile, findsOneWidget);

//       await tester.tap(qualitySettingsListTile, warnIfMissed: false);
//       await tester.pumpAndSettle();

//       final qualitySettingsWrapper = find.byKey(ValueKey("QualitySettings"));
//       expect(qualitySettingsWrapper, findsOneWidget);
//       expect(find.text("Automatisch"), findsOneWidget);
//       expect(find.text("1080p"), findsOneWidget);
//       expect(find.text("720p"), findsOneWidget);
//       expect(find.text("540p"), findsOneWidget);
//       expect(find.text("360p"), findsOneWidget);
//     });
//   });

//   group("test Profile Tab", () {
//     testWidgets('test profile text, finds text on profile tab',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MyApp());

//       final profileButton = find.byKey(ValueKey("ProfileButton"));
//       await tester.tap(profileButton);

//       await tester.pump();

//       final profileTabText =
//           find.text("Here you can change your user profile.");
//       expect(profileTabText, findsWidgets);
//     });
//   });
// }

// Future<Categories> fetchCat() async {
//   AcademyRepository repo = new AcademyRepository();

//   Categories cat = await repo.fetchAllCategories();

//   return cat;
// }
