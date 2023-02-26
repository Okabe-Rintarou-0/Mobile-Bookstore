import 'package:flutter/material.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

import '../pages/book_details_page.dart';
import 'common/texts.dart';

class BookSearchResultCard extends StatelessWidget {
  const BookSearchResultCard({super.key, required this.snapshot});

  final BookSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              snapshot.title,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text("作者：${snapshot.author}",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)))
          ],
        ),
        Row(
          children: [
            PriceText(price: snapshot.price),
            const SizedBox(width: 10),
            Text("${snapshot.sales}人付款",
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 12, color: Colors.grey))
          ],
        )
      ],
    );

    info = Expanded(
        child: Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      child: info,
    ));

    final img = GestureDetector(
        onTap: () => RouteUtils.routeToDynamic(
            context, BookDetailsPage(id: snapshot.id)),
        child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Image.network(snapshot.cover, width: 120, height: 120)));

    return Container(
      margin: const EdgeInsets.only(left: 5, top: 10, right: 5),
      // color: const Color(0xFFF0F0F0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [img, info],
      ),
    );
  }
}
