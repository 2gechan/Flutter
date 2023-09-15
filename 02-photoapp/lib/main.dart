import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photoapp/firebase_options.dart';
import 'package:photoapp/page/app_login.dart';

import 'main_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  late User? _authUser;

  @override
  void initState() {
    super.initState();
    _authUser = FirebaseAuth.instance.currentUser;
  }

  void updateAuthUser(User? user) {
    setState(() {
      _authUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context, authUser: _authUser),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "추억 보관함",
        ),
      ),
      body: _authUser != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("로그인한 사용자 email : ${_authUser?.email}"),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          updateAuthUser(null);
                        });
                      },
                      child: const Text("로그아웃"))
                ],
              ),
            )
          : SimpleDialog(
              title: const Text("로그인이 필요합니다."),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          updateAuthUser: updateAuthUser,
                        ),
                      ),
                    ),
                    child: const Text("로그인하기"),
                  ),
                ),
              ],
            ),
    );
  }
}
