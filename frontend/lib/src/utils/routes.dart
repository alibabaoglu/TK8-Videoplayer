import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/academy/academy.dart';
import 'package:video_example/src/course/course.dart';
import 'package:video_example/src/home/home.dart';
import 'package:video_example/src/app_settings/view/profile_screen.dart';
import 'package:video_example/src/utils/utils.dart';
import 'package:video_example/src/video/video.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/academy':
        return MaterialPageRoute(builder: (_) => AcademyView());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/courseListScreen':
        final argument = args as CourseScreenArgs;

        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => VideoCubit(
                            Urls.BASEURL + Urls.VIDEOPATH + "/de/master.m3u8"),
                      ),
                      BlocProvider(
                          create: (context) => CourseCubit(CourseRepository())),
                    ],
                    child: CourseListScreen(
                        title: argument.courseTitle // course.title,
                        )));
      case '/video':
        final argument = args as VideoScreenArgs;

        return PageRouteBuilder(
          opaque: false,
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => VideoCubit(
                  Urls.BASEURL + Urls.VIDEOPATH + "/de/master.m3u8",
                ),
              ),
              BlocProvider(
                create: (_) => SliderCubit(),
              ),
            ],
            child: VideoScreen(
                courseVideo: argument.courseVideo,
                videos: argument.videos,
                videoTitle: argument.videoTitle,
                contextTitle: argument.contextTitle),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            final tween = Tween(
              begin: begin,
              end: end,
            );
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
