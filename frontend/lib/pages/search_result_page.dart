import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/search_bar.dart';
import 'package:mobile_bookstore/components/search_list.dart';
import 'package:mobile_bookstore/pages/search_page.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: SearchBar(
          controller: TextEditingController(text: keyword),
          autoFocus: false,
          onTextFieldTap: () => RouteUtils.routeToDynamic(
              context, SearchPage(initialText: keyword)),
        )),
        body: BookSearchList(keyword: keyword));
  }
}
