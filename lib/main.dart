import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './model/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final postResult = PostResult().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API MODUL 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Text(
                  (postResult.value.id != null)
                      ? 'ID: ${postResult.value.id}, User ID: ${postResult.value.userId}, Title: ${postResult.value.title}, Completed: ${postResult.value.completed}'
                      : 'postResult is null',
                )),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await PostResult.fetchPost();
                  postResult.value = result;
                } catch (e) {
                  print('Error fetching data: $e');
                }
              },
              child: const Text('Tekan'),
            ),
          ],
        ),
      ),
    );
  }
}
