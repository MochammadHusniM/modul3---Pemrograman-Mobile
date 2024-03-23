import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostResult {
  var userId;
  var id;
  var title;
  var completed;

  PostResult({this.userId, this.id, this.title, this.completed});

  factory PostResult.fromJson(Map<String, dynamic>? json) {
    return PostResult(
      userId: json?['userId'],
      id: json?['id'],
      title: json?['title'],
      completed: json?['completed'],
    );
  }

  static Future<PostResult> fetchPost() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/5'));

    if (response.statusCode == 200) {
      return PostResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class PostResultController extends GetxController {
  var postResult = PostResult().obs;

  Future<void> fetchPost() async {
    try {
      var result = await PostResult.fetchPost();
      postResult.value = result;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
