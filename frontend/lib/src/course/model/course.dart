import 'package:video_example/src/course/model/course_video.dart';

class Course {
  List<CourseVideo> _videos = [];

  Course.fromJson(Map<String, dynamic> json, String courseTitle) {
    var actualCourse = json[courseTitle];
    for (var item in actualCourse) {
      _videos.add(CourseVideo.fromJson(item));
    }
  }
  List<CourseVideo> get videos => _videos;
}
