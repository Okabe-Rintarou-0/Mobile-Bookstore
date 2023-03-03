import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_bookstore/pages/book_details_page.dart';
import 'package:mobile_bookstore/pages/cart_page.dart';
import 'package:mobile_bookstore/pages/check_login.dart';
import 'package:mobile_bookstore/pages/home_page.dart';
import 'package:mobile_bookstore/pages/register_page.dart';
import 'package:mobile_bookstore/pages/search_page.dart';
import 'package:mobile_bookstore/pages/settings_page.dart';
import 'package:mobile_bookstore/pages/user_address_page.dart';

void main() {
  runApp(const App());
}

final themeMode = ValueNotifier(2);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/login',
          // darkTheme: ThemeData.dark(),
          // themeMode: ThemeMode.values.toList()[value],
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF969696),
              onPrimary: Color(0xFF969696),
              onBackground: Color(0xFF969696),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (ctx) => const HomePage(),
            '/cart': (ctx) => const CartPage(),
            '/login': (ctx) => const CheckLogin(redirect: HomePage()),
            '/settings/address': (ctx) => const UserAddressPage(),
            '/search': (ctx) => const SearchPage(),
            '/register': (ctx) => const RegisterPage(),
            "/settings": (ctx) => const SettingsPage(),
            '/details': (ctx) => BookDetailsPage(id: Random().nextInt(2) + 1),
          },
        );
      },
      valueListenable: themeMode,
    );
  }
}
