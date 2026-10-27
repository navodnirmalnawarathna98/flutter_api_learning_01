import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const String _url =
      'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: const {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
      jsonDecode(response.body) as List<dynamic>;

      return jsonList.map((item) {
        return Post.fromJson(
          item as Map<String, dynamic>,
        );
      }).toList();
    }

    throw Exception(
      'Failed to load posts. HTTP ${response.statusCode}',
    );
  }
}
