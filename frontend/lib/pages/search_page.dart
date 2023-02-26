import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/common/tag.dart';
import 'package:mobile_bookstore/components/search_bar.dart';
import 'package:mobile_bookstore/pages/search_result_page.dart';
import 'package:mobile_bookstore/utils/search_utils.dart';

import '../utils/route_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.initialText = ""});

  final String initialText;

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String keyword;

  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    keyword = widget.initialText;
    SearchUtils.getSearchHistory().then((history) => setState(() {
          searchHistory = history;
        }));
  }

  void search(String keyword) {
    SearchUtils.saveSearchHistory(keyword).then((value) =>
        RouteUtils.routeToDynamic(context, SearchResultPage(keyword: keyword)));
  }

  void showRemoveHistoryDialog(String keyword) {
    BrnDialogManager.showConfirmDialog(context,
        cancel: '取消', confirm: '确定', message: "确认删除该历史记录？", onConfirm: () {
      SearchUtils.removeHistory(keyword).then((succeed) => {
            if (succeed)
              {
                SearchUtils.getSearchHistory().then((history) => setState(() {
                      searchHistory = history;
                    }))
              },
            Navigator.of(context).pop()
          });
    }, onCancel: () {
      Navigator.of(context).pop();
    });
  }

  void showRemoveAllHistoryDialog() {
    BrnDialogManager.showConfirmDialog(context,
        cancel: '取消', confirm: '确定', message: "确定删除所有搜索记录？", onConfirm: () {
      SearchUtils.removeAllHistory().then((_) => setState(() {
            searchHistory = [];
            Navigator.of(context).pop();
          }));
    }, onCancel: () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget history = Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("历史搜索", style: TextStyle(color: Colors.black)),
            IconButton(
                onPressed: () => showRemoveAllHistoryDialog(),
                icon: const Icon(Icons.delete, color: Colors.grey))
          ]),
          Row(
            children: [
              Expanded(
                  child: Wrap(
                      spacing: 5,
                      runSpacing: 2,
                      children: searchHistory
                          .map((keyword) => Tag(
                              text: keyword,
                              onLongPress: () =>
                                  showRemoveHistoryDialog(keyword),
                              onTap: () => search(keyword),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              radius: 15))
                          .toList()))
            ],
          )
        ],
      ),
    );

    AppBar appBar = AppBar(
        title: Row(
      children: [
        Expanded(
            child: SearchBar(
          controller: TextEditingController(text: widget.initialText),
          autoFocus: true,
          onTextChange: (text) => keyword = text,
          onTextCommit: (keyword) => search(keyword),
        )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            onPressed: () => search(keyword),
            child: const Text("搜索"))
      ],
    ));

    return Scaffold(
      appBar: appBar,
      body: history,
    );
  }
}
