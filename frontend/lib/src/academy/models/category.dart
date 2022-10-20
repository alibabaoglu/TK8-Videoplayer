import 'package:video_example/src/academy/models/category_video.dart';

class Category {
  List<CategoryVideo> videos = [];
  String categoryTitle;
  Category({required this.videos, required this.categoryTitle});

  factory Category.fromJson(Map<String, dynamic> json, categoryTitle) {
    List<CategoryVideo> tmpRes = [];
    for (var vid in json[categoryTitle]) {
      tmpRes.add(CategoryVideo.fromJson(vid));
    }
    return Category(videos: tmpRes, categoryTitle: categoryTitle);
  }
}
