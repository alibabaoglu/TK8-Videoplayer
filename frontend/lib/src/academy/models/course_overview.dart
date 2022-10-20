import 'package:video_example/src/academy/models/course_description.dart';

class CourseOverview {
  List<CourseDescription> _courses = [];

  CourseOverview.fromJson(Map<String, dynamic> json) {
    for (var course in json["courses"]) {
      CourseDescription result = CourseDescription.fromJson(course);
      _courses.add(result);
    }
  }
  List<CourseDescription> get courses => _courses;
}
