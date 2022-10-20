class CategoryVideo {
  String title;
  String thumbnail;
  String videoDuration;

  CategoryVideo(
      {required this.title,
      required this.thumbnail,
      required this.videoDuration});

  factory CategoryVideo.fromJson(Map<String, dynamic> json) => CategoryVideo(
      title: json["title"],
      thumbnail: json["thumbnail"],
      videoDuration: json["videoDuration"]);
}
