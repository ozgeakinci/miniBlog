import 'dart:convert';
import 'dart:io';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchAllBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  Future<Blog> fetchBlogId(String id) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    return Blog.fromJson(jsonData);
  }

  Future<void> addArticle(
      String title, String content, String author, String imageFile) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath("File", imageFile));
    }

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    final response = await request.send();
    if (response.statusCode == 201) {
      print('istek başarılı');
    } else {
      print('istek atılamadı');
    }
  }
}
