class CourseVideo {
  String title;
  String thumbnail;
  String videoDuration;

  CourseVideo(
      {required this.title,
      required this.thumbnail,
      required this.videoDuration});

  factory CourseVideo.fromJson(Map<String, dynamic> json) => CourseVideo(
      title: json["title"],
      thumbnail: json["thumbnail"],
      videoDuration: json["videoDuration"]);
}
