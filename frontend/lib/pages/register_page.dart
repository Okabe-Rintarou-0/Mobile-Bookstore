import 'package:flutter/material.dart';
import 'package:mobile_bookstore/pages/home_page.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

import '../api/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = "";
  String password = "";
  String email = "";
  String nickname = "";
  String? usernameError;
  String? passwordError;
  String? emailError;
  String? nicknameError;

  final RegExp _usernameRegex = RegExp(r"^[0-9a-zA-Z]{8,15}$");
  final RegExp _passwordRegex =
      RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
  final RegExp _emailRegex =
      RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
  final RegExp _nicknameRegex = RegExp(r"^[\u4e00-\u9fa5\w]{3,15}$");

  bool _checkEmpty() {
    if (username.isEmpty) {
      setState(() {
        usernameError = "用户名不得为空！";
      });
      return false;
    }
    if (password.isEmpty) {
      setState(() {
        passwordError = "密码不得为空！";
      });
      return false;
    }
    if (email.isEmpty) {
      setState(() {
        emailError = "邮箱不得为空！";
      });
      return false;
    }
    if (nickname.isEmpty) {
      setState(() {
        nickname = "昵称不得为空！";
      });
      return false;
    }
    return true;
  }

  bool _checkValidation() {
    if (!_usernameRegex.hasMatch(username)) {
      setState(() {
        usernameError = "用户名格式错误（必须由 8-15 位的字母或数字组成）";
      });
      return false;
    }
    if (!_emailRegex.hasMatch(email)) {
      setState(() {
        emailError = "邮箱格式错误（示例：okabe@sjtu.edu.cn）";
      });
      return false;
    }
    if (!_passwordRegex.hasMatch(password)) {
      setState(() {
        passwordError = "密码格式错误（必须由 6-16 位的字母和数字组成）";
      });
      return false;
    }
    if (!_nicknameRegex.hasMatch(nickname)) {
      setState(() {
        nicknameError = "昵称格式错误（必须由 3-15 位的字母，数字或下划线组成）";
      });
      return false;
    }

    return true;
  }

  void _checkRegister() {
    if (!_checkEmpty() || !_checkValidation()) {
      return;
    }

    Api.register(username, password, email, nickname).then((succeed) => {
          if (succeed) {RouteUtils.routeToStatic(context, "/login")}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("登录"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
                  left: 15.0, right: 15.0, top: 15.0, bottom: 0),
              child: TextField(
                onChanged: (email) => this.email = email,
                onSubmitted: (email) => this.email = email,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '邮箱',
                  hintText: '请输入邮箱',
                  errorText: emailError,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 0),
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (nickname) => this.nickname = nickname,
                onSubmitted: (nickname) => this.nickname = nickname,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '昵称',
                  hintText: '请输入昵称',
                  errorText: nicknameError,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: _checkRegister,
                child: const Text(
                  '注册',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () => RouteUtils.routeToStatic(context, "/login"),
              child: const Text(
                '已有账号？登录',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
