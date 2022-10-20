import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HlsFetcher {
  static Future<String> fetchHLS(String path) async {
    String result = "";

    Response res = await http.get(Uri.parse(path));

    return res.body;
  }
}
