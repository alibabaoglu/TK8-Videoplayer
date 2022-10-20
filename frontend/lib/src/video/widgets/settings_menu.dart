import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/hls/hls_master_playlist.dart';
import 'package:video_example/src/utils/urls.dart';

import '../video.dart';

class SettingsMenu extends StatelessWidget {
  final bool isPortrait;
  final String currentRes;
  final HlsMasterPlaylist? playlist;
  final String currentLanguage;
  SettingsMenu(
      {Key? key,
      required this.isPortrait,
      required this.currentRes,
      required this.playlist,
      required this.currentLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          // Using Wrap makes the bottom sheet height the height of the content.
          // Otherwise, the height will be half the height of the screen.
          return Wrap(
            key: Key("Settings"),
            children: [
              ListTile(
                key: Key("QualitySettingsListTile"),
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          key: Key("QualitySettings"),
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);

                                cubit.changeRes(
                                    Urls.BASEURL +
                                        Urls.VIDEOPATH +
                                        "/${currentLanguage}/master.m3u8",
                                    "auto");
                              },
                              title: Text('Automatisch'),
                              selected: currentRes == "auto",
                            ),
                            for (var quality in playlist!.variants.reversed)
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  print(Urls.BASEURL +
                                      Urls.VIDEOPATH +
                                      "/${currentLanguage}/stream_${quality.format}p/prog_index.m3u8");
                                  cubit.changeRes(
                                      Urls.BASEURL +
                                          Urls.VIDEOPATH +
                                          "/${currentLanguage}/stream_${quality.format}p/prog_index.m3u8",
                                      quality.format!);
                                },
                                title: Text(quality.format! + "p"),
                                selected: quality.format! == currentRes,
                              ),
                          ],
                        );
                      });
                },
                leading: Icon(
                  Icons.settings_outlined,
                ),
                title: Text('Qualität'),
              ),
              if (isPortrait)
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    SpeedSlider(isPortrait: true)
                        .showSpeedSlider(context, cubit);
                  },
                  key: Key("SpeedSlider"),
                  leading: Icon(Icons.speed),
                  title: Text('Geschwindigkeit'),
                ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                cubit.changeLanguage("de");
                              },
                              title: Text("Deutsch"),
                              selected: currentLanguage == "de",
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                cubit.changeLanguage("en");
                              },
                              title: Text("Englisch"),
                              selected: currentLanguage == "en",
                            ),
                          ],
                        );
                      });
                },
                leading: Icon(
                  Icons.language_outlined,
                ),
                title: Text('Sprache'),
              ),
              ListTile(
                key: Key("AutoPlayListTile"),
                leading: Icon(Icons.repeat),
                title: Text('Autoplay'),
              ),
            ],
          );
        },
      ),
      child: Icon(
        Icons.more_vert,
        size: isPortrait ? 35 : 35,
        color: Colors.white,
      ),
    );
  }
}
