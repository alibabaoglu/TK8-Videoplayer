import 'dart:async';
import 'dart:convert';
import '../models/categories.dart';
import 'package:flutter/services.dart' show rootBundle;

class CategoriesApiProvider {
  Future<Categories> fetchCategories() async {
    return Categories.fromJson(json
        .decode(await rootBundle.loadString('assets/json/categories.json')));
  }
}
