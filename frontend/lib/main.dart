import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:video_example/src/utils/routes.dart';
import 'package:video_example/src/utils/theme.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          onGenerateRoute: RouterGenerator.generateRoute,
          initialRoute: "/",
          debugShowCheckedModeBanner: false,
          title: 'Video Player',
          themeMode: themeProvider.themeMode,
          theme: AcademyTheme.lightMode,
          darkTheme: AcademyTheme.darkMode,
        );
      });
}
