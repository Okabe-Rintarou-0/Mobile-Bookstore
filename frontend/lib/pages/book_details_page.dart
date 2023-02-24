import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/book_comment_card.dart';
import 'package:mobile_bookstore/components/book_details_card.dart';
import 'package:mobile_bookstore/components/book_slider.dart';
import 'package:mobile_bookstore/components/search_bar.dart';
import 'package:mobile_bookstore/model/book_details.dart';

import '../api/api.dart';
import '../model/comment.dart';

class _GradientColorButton extends StatelessWidget {
  const _GradientColorButton(
      {required this.colors,
      this.onPressed,
      required this.text,
      required this.borderRadius});

  final List<Color> colors;

  final Text text;

  final BorderRadius borderRadius;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(colors: colors),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: text,
        ),
      );
}

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

  Widget btnGroup() => Row(
        children: [
          _GradientColorButton(
              onPressed: () {},
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              text: const Text("加入购物车", style: TextStyle(color: Colors.white)),
              colors: const [Color(0xFFFCCA07), Color(0xFFFF9603)]),
          _GradientColorButton(
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
          title: const SearchBar(),
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
