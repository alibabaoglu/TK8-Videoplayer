import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    if (isOn) {
      themeMode = ThemeMode.dark;
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
      themeMode = ThemeMode.light;
    }

    notifyListeners();
  }

  AssetImage getTrainingPicture(context) =>
      MediaQuery.of(context).platformBrightness == Brightness.dark ||
              themeMode == ThemeMode.dark
          ? AssetImage("assets/caution_darkmode.png")
          : AssetImage("assets/caution_lightmode.png");
}

class AcademyTheme {
  static final lightMode = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        color: Color.fromRGBO(229, 232, 237, 1.0),
        elevation: 0,
        toolbarHeight: 10,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.light)),
    scaffoldBackgroundColor: Color.fromRGBO(229, 232, 237, 1.0),
    colorScheme: ColorScheme.light(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // selectedIconTheme: IconThemeData(color: Color.fromRGBO(97, 216, 250, 100)),
    //)
  );

  static final darkMode = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(
        color: Color(0x303030),
        elevation: 0,
        toolbarHeight: 10,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)),
    //bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // selectedIconTheme: IconThemeData(color: Color.fromRGBO(97, 216, 250, 100)),
    // )
  );
}
