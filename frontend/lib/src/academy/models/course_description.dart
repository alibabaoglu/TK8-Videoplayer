class CourseDescription {
  String title;
  String videos;
  String duration;

  CourseDescription(
      {required this.title, required this.videos, required this.duration});

  factory CourseDescription.fromJson(Map<String, dynamic> json) =>
      CourseDescription(
          title: json["title"],
          videos: json["videos"],
          duration: json["duration"]);
}
