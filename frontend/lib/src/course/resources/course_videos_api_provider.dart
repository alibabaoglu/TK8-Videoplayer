import 'dart:async';
import 'dart:convert';
import '../model/course.dart';
import 'package:flutter/services.dart' show rootBundle;

class CourseApiProvider {
  Future<Course> fetchCourseVideos(String title) async {
    return Course.fromJson(
        json.decode(await rootBundle.loadString('assets/json/courses.json')),
        title);
  }
}
