import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/footer_bar.dart';
import 'package:mobile_bookstore/components/search_bar.dart';

import '../components/book_waterfall.dart';
import '../utils/route_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => RouteUtils.routeToStatic(context, "/search"),
          child: const SearchBar(autoFocus: false, fake: true),
        ),
      ),
      body: const BookWaterfall(),
      bottomNavigationBar: const BottomAppBar(
        child: FooterBar(activatedSection: "home"),
      ),
    );
  }
}
