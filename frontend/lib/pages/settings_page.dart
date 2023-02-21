import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/footer_bar.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

import '../api/api.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _textBtn(String text, Color color, void Function()? onPressed) =>
      Row(children: [
        Expanded(
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                child: TextButton(
                    onPressed: onPressed,
                    child: Text(text, style: TextStyle(color: color)))))
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xFFF0F0F0),
        child: Column(
          children: [
            _textBtn("退出登录", Colors.grey, () {
              Api.logout()
                  .then((_) => RouteUtils.routeToStatic(context, "/login"));
            })
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: FooterBar(activatedSection: "settings"),
      ),
    );
  }
}
