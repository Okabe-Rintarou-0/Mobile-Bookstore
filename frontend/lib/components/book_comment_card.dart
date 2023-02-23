import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/api/api.dart';
import 'package:mobile_bookstore/components/comment_tile.dart';
import 'package:mobile_bookstore/model/comment.dart';

import 'comment_input.dart';

class BookCommentCard extends StatelessWidget {
  const BookCommentCard(
      {super.key,
      required this.numComments,
      required this.hotComments,
      required this.bookId,
      required this.onUploadComment});

  final void Function() onUploadComment;

  final int bookId;

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
        color: Color(0xFFF0F0F0),
        thickness: 1.5,
      ));
      tiles.add(CommentTile(comment: hotComments[i]));
    }
    // : CommentTile(comment: hotComments[0]);
    return Column(
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
                const Divider(
                  color: Color(0xFFF0F0F0),
                  thickness: 1.5,
                ),
                const SizedBox(height: 15),
                _CommentInputField(
                    bookId: bookId, onUploadComment: onUploadComment)
              ],
            )));
  }
}

class _CommentInputField extends StatefulWidget {
  const _CommentInputField(
      {required this.bookId, required this.onUploadComment});

  final int bookId;

  final void Function() onUploadComment;

  @override
  State<StatefulWidget> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<_CommentInputField> {
  String comment = "";

  String initialText = "";

  @override
  Widget build(BuildContext context) => CommentInput(
      onSubmit: (text) => comment = text,
      onTextChange: (text) => comment = text,
      initialText: initialText,
      inputSuffix: Align(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: IconButton(
            onPressed: () =>
                Api.uploadComment(widget.bookId, comment).then((succeed) => {
                      if (succeed)
                        {
                          BrnToast.show("评论成功！", context),
                          widget.onUploadComment(),
                          setState(() {
                            comment = initialText = "";
                          })
                        }
                      else
                        {BrnToast.show("评论失败，请重试！", context)}
                    }),
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.grey,
            )),
      ),
      padding: const EdgeInsets.all(10),
      bgColor: const Color(0xFFF0F0F0),
      autoFocus: false,
      borderRadius: 15,
      maxLength: 200,
      minHeight: 10,
      hint: "试着发一条友善的评论~");
}
