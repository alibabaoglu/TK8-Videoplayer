import 'package:flutter/material.dart';
import 'package:video_example/src/academy/models/category.dart';
import 'package:video_example/src/utils/video_screen_args.dart';

class CategoryVideosHorizontal extends StatelessWidget {
  final Category category;
  const CategoryVideosHorizontal({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            category.categoryTitle,
            style: TextStyle(
                fontFamily: "RevxNeue",
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
        ),
        Expanded(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: category.videos.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/video",
                        arguments: VideoScreenArgs(
                            false,
                            category.videos,
                            category.videos[index].title,
                            category.categoryTitle)),
                    child: Container(
                      key: Key("VideoThumbnail$index"),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),

                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                category.videos[index].thumbnail,
                                fit: BoxFit.contain,
                                scale: 6.0,
                                // height: 150,
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        bottom: -5,
                                        right: -5,
                                        child: Icon(Icons.play_arrow,
                                            size: 70, color: Color(0x2F000000)),
                                      ),
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(category.videos[index].title,
                                style: TextStyle(
                                    fontFamily: "RevxNeue",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
