import 'package:flutter/material.dart';
import 'package:video_example/src/video/widgets/change_theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: ListTile(
            title: Text("Darkmode"),
            leading: ChangeThemeButtonWidget(),
          ),
        ),
      ),
    );
  }
}
