import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/academy/academy.dart';
import 'package:video_example/src/app_settings/view/profile_screen.dart';
import 'package:video_example/src/utils/utils.dart';
import 'package:video_example/src/video/video.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _navigationBarPages = <Widget>[
    BlocProvider(
      create: (_) =>
          VideoCubit(Urls.BASEURL + Urls.VIDEOPATH + "/home/homescreen0.mp4"),
      child: HomeTextScreen(),
    ),
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CategoriesCubit(AcademyRepository())),
      BlocProvider(
          create: (context) => CourseOverviewCubit(AcademyRepository())),
    ], child: AcademyView()),
    ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: Center(
        child: _navigationBarPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black54,
                key: Key("HomeButton"),
              ),
              label: "Home",
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
                size: 25,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video_sharp,
                  color: Colors.black54, key: Key("PlayerButton")),
              label: "Academy",
              activeIcon: Icon(
                Icons.ondemand_video_sharp,
                color: Colors.black,
                size: 25,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black54,
                key: Key("ProfileButton"),
              ),
              label: "Profile",
              activeIcon: Icon(
                Icons.person,
                color: Colors.black,
                size: 25,
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
