// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/page/mainpage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  // initState는 StartPage가 호출되는 시점에 딱 한번 실행한다.
  @override
  void initState() {
    // 3초 뒤에 MainPage로 이동
    Timer(const Duration(seconds: 3), () {
      // 3초 뒤에 MainPage로 이동하고 그 전 페이지에 대한
      Get.offAll(const MainPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // children 아래 있는 것들이 차곡차곡 겹쳐진다.
      // 아래에 명시될 수록 위로 겹쳐짐
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/dogs.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          // loading spiner : 빙글빙글 돌아가는 로딩 표시
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
