import 'package:video_example/src/academy/academy.dart';
import 'dart:async';

class AcademyRepository {
  final courseOverviewApiProvider = CourseOverviewApiProvider();
  final categoriesApiProvider = CategoriesApiProvider();

  Future<CourseOverview> fetchAllCourseOverviews() =>
      courseOverviewApiProvider.fetchCourseOverviewList();

  Future<Categories> fetchAllCategories() =>
      categoriesApiProvider.fetchCategories();
}
