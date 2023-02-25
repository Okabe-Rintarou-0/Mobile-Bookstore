import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/search_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String curKeyword = "";

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Expanded(
                child: BrnSearchText(
              autoFocus: true,
              onTextChange: (text) => curKeyword = text,
              onTextCommit: (text) => curKeyword = text,
            )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    keyword = curKeyword;
                  });
                },
                child: const Text("搜索"))
          ],
        )),
        body: keyword.isEmpty ? null : BookSearchList(keyword: keyword));
  }
}
