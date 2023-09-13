import 'dart:math';

import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.number});
  final int number;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<String> imageList = [
    "https://cafeptthumb-phinf.pstatic.net/MjAyMzA2MjBfMTY5/MDAxNjg3MjUxMzQ2OTkw.MFoN9fwPETJYXzfMAnTKpKvD28lnioQqeN0opYx1F1Yg.cVXkgLpCUbT1wPmZ_icgfwjAl1yXxuMZFAkKWvDRYMQg.JPEG/IMG%EF%BC%BF20230319%EF%BC%BF151934%EF%BC%BF281.jpg?type=w1600",
    "https://cafeptthumb-phinf.pstatic.net/MjAyMzA2MjBfNzQg/MDAxNjg3MjUxMzQ3NDQ4.YEB-5QBhjlNh4IeMdjwnEyKrqbEIkIm9MB8uUftimkYg.tz2PYUyroO7dkRPNbCsPpld8QGrcx1Ou_8lkXKDvzRgg.JPEG/IMG%EF%BC%BF20221116%EF%BC%BF192756%EF%BC%BF418.jpg?type=w1600",
    "https://cafeptthumb-phinf.pstatic.net/MjAyMzA2MjBfMTk2/MDAxNjg3MjUxMzQ2OTQ2.GoKBM_pL_t6cXzGYiZPUJ9df6IBbbITJ8O7t0-_VbEsg.RnrqU7xfHTbPgat6IXc_gUBL5_jkkpd8kzqH71hL2Swg.JPEG/IMG%EF%BC%BF20220918%EF%BC%BF165337%EF%BC%BF459.jpg?type=w1600",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          "https://cafeptthumb-phinf.pstatic.net/MjAyMzA2MjBfOTIg/MDAxNjg3MjUxMzQ3NTgy.QCx7XxW__KRJjdtKJGOLP7PkVhgB85gc77gyUe-mAL8g.7PcaBeNQJTUNLaAsGCtPNqNlLYR1jq3RB91_9m_PSgcg.JPEG/IMG%EF%BC%BF20220820%EF%BC%BF114504%EF%BC%BF176.jpg?type=w1600")),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("나는 강아지"),
                    ),
                  ),
                ],
              ),
              Icon(Icons.abc_rounded)
            ],
          ),
        ),
        Container(
          // width: double.infinity,
          // height: 300,
          color: Colors.white,
          child: Image.network(imageList[Random().nextInt(3)]),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 30,
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 7),
                  Icon(Icons.chat_outlined),
                  SizedBox(width: 7),
                  Icon(Icons.send),
                  SizedBox(width: 7),
                ],
              ),
              SizedBox(
                width: 60,
                child: Text("indic"),
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
            child: Text("좋아요 84개"),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // height: 100,
          color: Colors.white,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("제목 입력"),
              Text("내용을 입력하세요"),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 30,
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 3, 3, 10),
            child: Text("댓글을 입력하세요"),
          ),
        ),
      ],
    );
  }
}
