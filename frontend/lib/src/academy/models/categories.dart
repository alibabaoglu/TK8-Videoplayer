import 'package:video_example/src/academy/models/category.dart';

class Categories {
  List<Category> _courses = [];

  Categories.fromJson(Map<String, dynamic> json) {
    for (var categoryTitle in json.keys) {
      Category res = Category.fromJson(json, categoryTitle);
      _courses.add(res);
    }
  }
  List<Category> get courses => _courses;
}
