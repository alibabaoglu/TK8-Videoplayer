import 'package:video_example/src/course/model/course.dart';

import 'course_videos_api_provider.dart';
import 'dart:async';

class CourseRepository {
  final courseApiProvider = CourseApiProvider();

  Future<Course> fetchCourseVideos(String title) =>
      courseApiProvider.fetchCourseVideos(title);
}
