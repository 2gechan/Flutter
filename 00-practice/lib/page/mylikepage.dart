import 'package:flutter/material.dart';

class MyLikeScreen extends StatefulWidget {
  const MyLikeScreen({super.key});

  @override
  State<MyLikeScreen> createState() => _MyLikeScreenState();
}

class _MyLikeScreenState extends State<MyLikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("나의 좋아요 페이지"),
    );
  }
}
