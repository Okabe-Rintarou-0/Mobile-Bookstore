import 'package:flutter/material.dart';
import 'package:mobile_bookstore/pages/login_page.dart';

import '../api/api.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key, required this.redirect});

  final Widget redirect;

  @override
  State<StatefulWidget> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _validateLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return widget.redirect;
    }
    return const LoginPage();
  }

  void _validateLogin() async {
    bool sessionOpen = await Api.checkSession();
    print(sessionOpen);
    setState(() {
      isLogin = sessionOpen;
    });
  }
}
