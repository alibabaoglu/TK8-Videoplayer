import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/academy/academy.dart';

class AcademyView extends StatelessWidget {
  AcademyView({Key? key}) : super(key: key);

  final List img = [
    [
      "assets/academy_assets/toni1_noBack.png",
      1.0,
      "assets/academy_assets/beton_curves_background_blue.png",
      "Container1"
    ],
    [
      "assets/academy_assets/toni4_noBack.png",
      1.0,
      "assets/academy_assets/beton_curves_background_red.png",
      "Container2"
    ],
    [
      "assets/academy_assets/toni3_noBack.png",
      1.0,
      "assets/academy_assets/beton_curves_background.png",
      "Container3"
    ],
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CourseOverviewCubit>(context).getCourseOverview();
    BlocProvider.of<CategoriesCubit>(context).getCategories();

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, stateCategories) {
        return BlocBuilder<CourseOverviewCubit, CourseOverviewState>(
          builder: (context, stateCourse) {
            return ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "KAPITEL",
                    style: TextStyle(
                        fontFamily: "RevxNeue",
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                if (stateCourse is CourseOverviewLoaded)
                  for (var i = 0; i < stateCourse.course.courses.length; i++)
                    Course(
                      course: stateCourse.course.courses[i],
                      image: img[i],
                    ),
                if (stateCategories is CategoriesLoaded)
                  for (var i = 0;
                      i < stateCategories.categories.courses.length;
                      i++)
                    Container(
                        key: Key("HorizontalList${i + 1}"),
                        margin: EdgeInsets.all(15),
                        height: 190,
                        child: CategoryVideosHorizontal(
                          category: stateCategories.categories.courses[i],
                        )),
              ],
            );
          },
        );
      },
    );
  }
}
