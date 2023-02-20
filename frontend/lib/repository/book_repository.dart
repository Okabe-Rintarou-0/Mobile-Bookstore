import 'package:loading_more_list/loading_more_list.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';

import '../api/api.dart';

class BookRepository extends LoadingMoreBase<BookSnapshot> {
  static const int eachFetch = 20;

  int curIdx = 1;

  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    var books = await Api.getRangedBookSnapshots(curIdx, curIdx + eachFetch - 1);
    for (var book in books) {
      add(book);
    }
    curIdx += eachFetch;
    _hasMore = eachFetch == books.length;
    return books.isNotEmpty;
  }
}
