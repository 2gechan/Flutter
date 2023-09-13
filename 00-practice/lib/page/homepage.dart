import 'package:flutter/material.dart';
import 'package:practice/cards/postcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // ListView.builder에는 itemCount와 itemBuilder가 필수로 들어가야한다.
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(
            number: index,
          );
        },
        separatorBuilder: (context, index) {
          // 게시물간의 간격을 띄워주기 위해 아무것도 없는
          // SizedBox를 height 30으로 만들어준다.
          return const SizedBox(
            height: 30,
          );
        },
      ),
    );
  }
}
