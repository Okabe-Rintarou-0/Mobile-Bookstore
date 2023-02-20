import 'package:flutter/material.dart';
import 'package:mobile_bookstore/pages/home_page.dart';

import '../api/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  String? usernameError;
  String? passwordError;
  bool isLogin = false;

  void _checkLogin() async {
    if (username.isEmpty) {
      setState(() {
        usernameError = "用户名不得为空！";
      });
      return;
    }
    if (password.isEmpty) {
      setState(() {
        passwordError = "密码不得为空！";
      });
      return;
    }

    bool loginSucceed = await Api.login(username, password);
    if (loginSucceed) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        usernameError = passwordError = "用户名或密码错误!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return const HomePage();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("登录"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: SizedBox(
                    width: 400,
                    height: 200,
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (username) => this.username = username,
                onSubmitted: (username) => this.username = username,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '用户名',
                  hintText: '请输入用户名',
                  errorText: usernameError,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (password) => this.password = password,
                onSubmitted: (password) => this.password = password,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '密码',
                  hintText: '请输入密码',
                  errorText: passwordError,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '忘记密码？',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: _checkLogin,
                child: const Text(
                  '登录',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '新用户？创建账号',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
