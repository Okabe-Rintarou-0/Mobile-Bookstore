import 'package:loading_more_list/loading_more_list.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';

import '../api/api.dart';

class BookSearchResultRepository extends LoadingMoreBase<BookSnapshot> {
  static const int eachFetch = 20;

  BookSearchResultRepository({required this.keyword});

  String keyword;

  int curIdx = 1;

  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    var books = await Api.searchBook(keyword, curIdx, curIdx + eachFetch - 1);
    for (var book in books) {
      add(book);
    }
    curIdx += eachFetch;
    _hasMore = eachFetch == books.length;
    return true;
  }
}
