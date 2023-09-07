import 'package:flutter/material.dart';

import 'main_drawer.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,

      home: StartPage(),
      // PhotoAppTest(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "추억 보관함",
        ),
      ),
      body: const Center(child: Text("첫 화면")),
    );
  }
}
