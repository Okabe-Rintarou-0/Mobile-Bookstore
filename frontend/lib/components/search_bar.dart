import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late String searchText;

  @override
  Widget build(BuildContext context) {
    return BrnSearchText(
      onTextClear: () {
        return false;
      },
      autoFocus: false,
      onActionTap: () {
        BrnToast.show('取消', context);
      },
      onTextCommit: (text) {
        searchText = text;
        BrnToast.show('提交内容 : $text', context);
      },
      onTextChange: (text) {
        BrnToast.show('输入内容 : $text', context);
      },
    );
  }

}
