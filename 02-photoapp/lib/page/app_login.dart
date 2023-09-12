import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.updateAuthUser,
  });

  final Function(User? user) updateAuthUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailInputFocus = FocusNode();
  final _passwordInputFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String emailValue = "";
  String passwordValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              "로그인페이지",
              style: TextStyle(fontSize: 20),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => emailValue = value,
                    focusNode: _emailInputFocus,
                  ),
                  TextField(
                    onChanged: (value) => passwordValue = value,
                    focusNode: _passwordInputFocus,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20)),
                        onPressed: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              // 로그인에 성공하면 result에 사용자 정보가 담기게 된다.
                              var result = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailValue,
                                password: passwordValue,
                              );
                              // main.dart의 _authUser State에 로그인한 사용자 정보
                              // Update 요청하기
                              widget.updateAuthUser(result.user);

                              // 화면전환, SnackBar 등을 화면에 표현하고자 할 때
                              // Don't use BuildContext ... 의 경고가 나타나면
                              // 아래의 코드를 먼저 실행하도록 추가한다.
                              // BuildContext(context)가 아직 완전히 생성되지 않거나
                              // 어떤 이유로 context가 사라질수도 있는데
                              // 사용상 주의하라 라는 경고
                              // mounted 라는 시스템 변수가 생성되었는지 확인한 후
                              // context 관련 코드를 실행하라 라는 의미
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            }
                          } on FirebaseAuthException {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("")),
                            );
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
