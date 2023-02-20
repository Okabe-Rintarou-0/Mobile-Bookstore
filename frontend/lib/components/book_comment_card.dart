import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/comment_tile.dart';
import 'package:mobile_bookstore/model/comment.dart';

class BookCommentCard extends StatelessWidget {
  const BookCommentCard(
      {super.key, required this.numComments, required this.hotComments});

  final int numComments;

  final List<Comment> hotComments;

  Widget _commentText() {
    String num = numComments >= 1000 ? "999+" : numComments.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("评价($num)",
            style: const TextStyle(color: Colors.black, fontSize: 15)),
        Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_left, color: Color(0xffff6600)),
                label: const Text("查看全部",
                    style: TextStyle(color: Color(0xffff6600)))))
      ],
    );
  }

  Widget _comments() {
    if (hotComments.isEmpty) {
      return const Text("暂无评价", style: TextStyle(color: Colors.grey));
    }
    List<Widget> tiles = [CommentTile(comment: hotComments[0])];
    int num = hotComments.length;
    for (int i = 1; i < num; i++) {
      tiles.add(const Divider(
        color: Colors.grey,
      ));
      tiles.add(CommentTile(comment: hotComments[i]));
    }
    // : CommentTile(comment: hotComments[0]);
    return ListView(
      shrinkWrap: true,
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double parentWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SizedBox(
            width: parentWidth,
            child: Column(
              children: [
                _commentText(),
                _comments(),
              ],
            )));
  }
}
