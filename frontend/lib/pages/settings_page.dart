import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/footer_bar.dart';
import 'package:mobile_bookstore/components/user_profile_card.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

import '../api/api.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final profile = Api.getUserProfile();

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
  Widget build(BuildContext context) => FutureBuilder(
      future: profile,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("设置"),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFF0F0F0),
            child: Column(
              children: [
                UserProfileCard(profile: snapshot.data),
                _textBtn("我的收货地址", Colors.grey, () {
                  RouteUtils.routeToStatic(context, "/settings/address");
                }),
                _textBtn("退出登录", Colors.grey, () {
                  Api.logout()
                      .then((_) => RouteUtils.routeToStatic(context, "/login"));
                }),
              ],
            ),
          ),
          bottomNavigationBar: const BottomAppBar(
            child: FooterBar(activatedSection: "settings"),
          ),
        );
      });
}
