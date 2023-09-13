import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:practice/page/StartPage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}
