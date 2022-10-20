import 'dart:async';
import 'dart:convert';
import '../models/course_overview.dart';
import 'package:flutter/services.dart' show rootBundle;

class CourseOverviewApiProvider {
  Future<CourseOverview> fetchCourseOverviewList() async {
    return CourseOverview.fromJson(json.decode(
        await rootBundle.loadString('assets/json/course_overview.json')));
  }
}
