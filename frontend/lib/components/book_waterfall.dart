import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';
import 'package:mobile_bookstore/repository/book_repository.dart';

import '../pages/book_details_page.dart';
import 'common/texts.dart';

class BookWaterfall extends StatefulWidget {
  const BookWaterfall({super.key});

  @override
  State<StatefulWidget> createState() => _BookWaterfallFlowState();
}

class _BookWaterfallFlowState extends State<BookWaterfall> {
  late BookRepository bookRepository;

  @override
  void initState() {
    bookRepository = BookRepository();
    super.initState();
  }

  @override
  void dispose() {
    bookRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<BookSnapshot>(
      ListConfig<BookSnapshot>(
        extendedListDelegate:
            const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: buildWaterfallFlowItem,
        sourceList: bookRepository,
        padding: const EdgeInsets.all(5.0),
        lastChildLayoutType: LastChildLayoutType.foot,
      ),
    );
  }
}

Widget buildWaterfallFlowItem(BuildContext c, BookSnapshot item, int index,
    {bool knowSized = true}) {
  Size? imageRawSize;
  Widget image = Stack(
    children: <Widget>[
      ExtendedImage.network(
        item.cover,
        shape: BoxShape.rectangle,
        clearMemoryCacheWhenDispose: false,
        loadStateChanged: (ExtendedImageState value) {
          if (value.extendedImageLoadState == LoadState.loading) {
            Widget loadingWidget = Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.8),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(c).primaryColor),
              ),
            );
            if (!knowSized) {
              //todo: not work in web
              loadingWidget = AspectRatio(
                aspectRatio: 1.0,
                child: loadingWidget,
              );
            } else if (value.extendedImageLoadState == LoadState.completed) {
              imageRawSize = Size(
                  value.extendedImageInfo!.image.width.toDouble(),
                  value.extendedImageInfo!.image.height.toDouble());
            }
            return loadingWidget;
          }
          return null;
        },
      ),
    ],
  );
  if (knowSized) {
    // image = AspectRatio(
    //   aspectRatio: imageSize.width / imageSize.height,
    //   child: image,
    // );
  } else if (imageRawSize != null) {
    image = AspectRatio(
      aspectRatio: imageRawSize!.width / imageRawSize!.height,
      child: image,
    );
  }

  image = GestureDetector(
    onTap: () {
      Navigator.push(
          c,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(id: item.id),
          ));
    },
    child: image,
  );

  Widget priceAndSales = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PriceText(price: item.price),
      SalesText(sales: item.sales),
    ],
  );

  Widget title = Row(
    children: [
      Expanded(
        child: Text(item.title,
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis),
      )
    ],
  );

  return Card(
      child: Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[image, priceAndSales, title],
    ),
  ));
}
