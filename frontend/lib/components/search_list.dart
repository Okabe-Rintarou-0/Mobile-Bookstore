import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:mobile_bookstore/components/book_search_result_card.dart';
import 'package:mobile_bookstore/components/common/indicator.dart';
import 'package:mobile_bookstore/repository/book_search_result_repository.dart';

import '../model/book_snapshot.dart';

class BookSearchList extends StatefulWidget {
  const BookSearchList({super.key, required this.keyword});

  final String keyword;

  @override
  State<StatefulWidget> createState() => _BookSearchListState();
}

class _BookSearchListState extends State<BookSearchList> {
  late BookSearchResultRepository bookSearchResultRepository;

  @override
  void initState() {
    bookSearchResultRepository =
        BookSearchResultRepository(keyword: widget.keyword);
    super.initState();
  }

  @override
  void dispose() {
    bookSearchResultRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<BookSnapshot>(
      ListConfig<BookSnapshot>(
        indicatorBuilder: defaultIndicatorBuilder,
        itemBuilder: (context, item, index) =>
            BookSearchResultCard(snapshot: item),
        sourceList: bookSearchResultRepository,
        padding: const EdgeInsets.all(0.0),
        lastChildLayoutType: LastChildLayoutType.foot,
      ),
    );
  }
}
