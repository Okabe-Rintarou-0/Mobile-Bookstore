import 'package:flutter/material.dart';

import '../components/book_waterfall.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("主页"),
      ),
      body: const BookWaterfall(),
    );
  }
}
