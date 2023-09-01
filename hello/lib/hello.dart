import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const HelloApp());
}

class HelloApp extends StatelessWidget {
  const HelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "특별한 사진첩",
          ),
        ),
        body: const Column(
          children: [
            Text(
              "안녕하세요",
              style: TextStyle(color: Colors.cyan),
            ),
            Text(
              "반갑습니다",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
