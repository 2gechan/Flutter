import 'package:flutter/material.dart';
import 'package:practice/page/gridpage.dart';
import 'package:practice/page/homepage.dart';
import 'package:practice/page/mylikepage.dart';
import 'package:practice/page/mypage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
// bottomNavigationItem의 선택된 아이템
  int _selectedIndex = 0;
  // bottom의 메뉴 목록을 리스트로 따로 만들어준다.
  List<BottomNavigationBarItem> bottomItems = [
    // BottomNavigationBarItem은 label과 icon이 필수 요소
    // label과 icon 설정안할시 BottomNavigationBar에서 에러가 난다.
    const BottomNavigationBarItem(
      label: "HOME",
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: "more",
      icon: Icon(Icons.grid_view),
    ),
    const BottomNavigationBarItem(
      label: "Like",
      icon: Icon(Icons.favorite),
    ),
    const BottomNavigationBarItem(
      label: "My",
      icon: Icon(Icons.account_circle),
    ),
  ];

  List page = [
    const HomePage(),
    const GridPage(),
    const MyLikeScreen(),
    const MyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("메인페이지"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // bar의 배경색상
        selectedItemColor: Colors.black, // 선택된 아이템의 색상
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,

        // bottomnavigationBarItem의 label을 나타내지 않는다.
        // 둘다 설정해줘야 선택될시와 선택되지 않았을시 모두 나타내지 않을 수 있음
        showSelectedLabels: false,
        showUnselectedLabels: false,

        // bottomNavigationBarList의 인덱스 번호를
        // _selectedIndex에게 setState 해준다.
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: bottomItems,
      ),
      body: page[_selectedIndex],
    );
  }
}
