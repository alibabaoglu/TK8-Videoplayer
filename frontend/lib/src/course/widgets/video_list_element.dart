import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_example/src/utils/theme.dart';

class VideoListElement extends StatelessWidget {
  final String url;
  final String duration;
  final String title;
  final int index;
  final int size;
  final String currentVideo;

  static final Color theme = Color.fromRGBO(97, 216, 250, 100);
  const VideoListElement(
      {Key? key,
      required this.url,
      required this.duration,
      required this.title,
      required this.index,
      required this.size,
      required this.currentVideo})
      : super(key: key);

  Widget verticalDivider() {
    return Expanded(
      child: Container(
        width: 2,
        height: 20,
        color: theme,
      ),
    );
  }

  Widget noVerticalDivider() {
    return Expanded(
      child: Container(
        width: 2,
        height: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10, top: index % 2 == 0 ? 15 : 0),
              child: index % 2 == 0
                  ? currentVideo != title
                      ? Image(
                          image: AssetImage(url),
                          height: 80,
                        )
                      : Container(
                          height: 80,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover,
                                  image: AssetImage(url))),
                          child: Icon(
                            Icons.play_arrow,
                            size: 50,
                            color: Colors.white,
                          ),
                        )
                  : Image(
                      image: themeProvider.getTrainingPicture(context),
                      height: 70,
                    )),
          Container(
            margin: EdgeInsets.only(top: 10, left: index % 2 == 0 ? 20 : 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index % 2 == 0 ? title : "Jetzt üben",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 16,
                      fontWeight: currentVideo == title
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                Text(duration,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: currentVideo == title
                            ? FontWeight.bold
                            : FontWeight.normal)),
              ],
            ),
          ),
          Expanded(
            child: Container(
                //r  color: index % 2 == 0 ? Colors.blue : Colors.yellow,
                alignment: Alignment.centerRight,
                height: 100,
                child: index == 0
                    ? Column(
                        children: [
                          Container(
                            child: FloatingActionButton(
                              heroTag: null,
                              elevation: 0.0,
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                              child: Icon(Icons.check, color: Colors.white),
                              backgroundColor: theme,
                            ),
                          ),
                          verticalDivider()
                        ],
                      )
                    : Column(
                        children: [
                          verticalDivider(),
                          index % 2 == 0
                              ? FloatingActionButton(
                                  heroTag: null,
                                  elevation: 0.0,
                                  onPressed: () {},
                                  child: Icon(Icons.check, color: Colors.white),
                                  backgroundColor: theme,
                                )
                              : Container(
                                  height: 40,
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    elevation: 0.0,
                                    onPressed: () {},
                                    child: SvgPicture.asset(
                                        "assets/icons/shoe.svg",
                                        key: Key("ShoeIcon"),
                                        width: 20),
                                    backgroundColor: theme,
                                  ),
                                ),
                          index != size - 2
                              ? verticalDivider()
                              : noVerticalDivider(),
                        ],
                      )),
          ),
        ],
      ),
    );
  }
}
