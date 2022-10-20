import 'package:flutter/material.dart';
import 'package:video_example/src/academy/models/course_description.dart';
import 'package:video_example/src/utils/course_screen_args.dart';

class Course extends StatelessWidget {
  final CourseDescription course;
  final List image;
  const Course({Key? key, required this.course, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/courseListScreen",
            arguments: CourseScreenArgs(course.title));
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,

                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/academy_assets/beton_hintergrund.jpeg",
                  height: 150,
                  width: 430,
                  fit: BoxFit.fitWidth,
                )),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.title,
                          style: TextStyle(
                              fontFamily: "RevxNeue",
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course.videos + " Videos",
                            style: TextStyle(
                                fontFamily: "RevxNeue",
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            course.duration + " Minuten",
                            style: TextStyle(
                                fontFamily: "RevxNeue",
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: LinearProgressIndicator(
                          value: 0.1,
                          backgroundColor: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              right: 18,
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  image[2],
                  scale: 8,
                ),
              ),
            ),
            Positioned.fill(
              right: 30,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  image[0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
