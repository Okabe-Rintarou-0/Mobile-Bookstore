import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/book_comment_card.dart';
import 'package:mobile_bookstore/components/book_details_card.dart';
import 'package:mobile_bookstore/components/book_slider.dart';
import 'package:mobile_bookstore/components/search_bar.dart';
import 'package:mobile_bookstore/utils/route_utils.dart';

import '../api/api.dart';
import '../components/common/btn.dart';
import '../model/comment.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<StatefulWidget> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  _BookDetailsPageState();

  late Future<BookCommentsSnapshot?> commentsSnapshot =
      Api.getBookCommentsSnapshot(widget.id);
  late final details = Api.getBookDetailsById(widget.id);

  void showAddToCartDialog() {
    BrnDialogManager.showConfirmDialog(context,
        cancel: '取消', confirm: '确定', message: "确认加入购物车？", onConfirm: () {
      Api.addToCart(widget.id).then((res) {
        if (res == null) {
          BrnToast.show("未知错误", context);
        } else {
          if (res.success) {
            BrnToast.show(res.message, context);
          } else {
            BrnToast.show(res.err, context);
          }
        }
        Navigator.of(context).pop();
      });
    }, onCancel: () {
      Navigator.of(context).pop();
    });
  }

  Widget btnGroup() => Row(
        children: [
          GradientColorButton(
              onPressed: showAddToCartDialog,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              text: const Text("加入购物车", style: TextStyle(color: Colors.white)),
              colors: const [Color(0xFFFCCA07), Color(0xFFFF9603)]),
          GradientColorButton(
              onPressed: () {},
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              text: const Text("立即购买", style: TextStyle(color: Colors.white)),
              colors: const [Color(0xFFFF7800), Color(0xFFFF4B00)])
        ],
      );

  Widget _footer() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        TextButton.icon(
            label: const Text("收藏", style: TextStyle(color: Color(0xFF505050))),
            icon: const Icon(Icons.star_outline, color: Color(0xFF505050)),
            onPressed: () {}),
        Container(padding: const EdgeInsets.all(5), child: btnGroup())
      ]);

  Widget _comment() => FutureBuilder(
      future: commentsSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BookCommentCard(
            numComments: snapshot.data!.numComments,
            hotComments: snapshot.data!.hotComments,
            bookId: widget.id,
            onUploadComment: () {
              setState(() {
                commentsSnapshot = Api.getBookCommentsSnapshot(widget.id);
              });
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      });

  Widget _body() {
    return FutureBuilder(
      future: details,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          final d = snapshot.data!;
          return SingleChildScrollView(
              child: Column(
            children: [
              BookSlider(height: 400, imgList: d.covers),
              Container(
                  color: const Color(0xFFF0F0F0),
                  child: Column(children: [
                    BookDetailsCard(
                        price: d.price,
                        orgPrice: d.orgPrice,
                        title: d.title,
                        author: d.author,
                        sales: d.sales),
                    _comment(),
                  ])),
              // const BookCommentCard(numComments: 1000, hotComments: []),
            ],
          ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () => RouteUtils.routeToStatic(context, "/search"),
            child: const SearchBar(autoFocus: false, fake: true),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: _body(),
        bottomNavigationBar: BottomAppBar(
          child: _footer(),
        ));
  }
}
