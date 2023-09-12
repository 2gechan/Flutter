import 'package:flutter/material.dart';
import 'package:photoapp/main_drawer.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: const Text("추억 보관함"),
      ),
      body: const Center(child: Text("공유이미지 페이지")),
    );
  }
}
