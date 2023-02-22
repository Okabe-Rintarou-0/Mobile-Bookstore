import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mobile_bookstore/api/api.dart';
import 'package:mobile_bookstore/constants.dart';

import '../model/comment.dart';

class CommentTile extends StatefulWidget {
  const CommentTile({super.key, required this.comment});

  final Comment comment;

  @override
  State<StatefulWidget> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  late final isLiked = Api.getIsLiked(widget.comment.id);

  String _parseCommentTime(int time) {
    DateTime now = DateTime.now();
    DateTime cmtTime = DateTime.fromMillisecondsSinceEpoch(time);
    Duration diff = now.difference(cmtTime);
    var diffDays = diff.inDays;
    var diffHours = diff.inHours;
    var diffMinutes = diff.inMinutes;
    if (diffDays >= 365) {
      return "${diffDays / 365}年前";
    }
    if (diffDays >= 30) {
      return "${diffDays / 30}个月前";
    }
    if (diffDays > 0) {
      return "$diffDays天前";
    }
    if (diffHours >= 1) {
      return "$diffHours小时前";
    }
    if (diffMinutes > 0) {
      return "$diffMinutes分钟前";
    }
    return "刚刚";
  }

  Widget _tile() => ListTile(
    contentPadding: const EdgeInsets.all(0.0),
    title:
    Text(widget.comment.nickname, style: const TextStyle(color: Colors.black)),
    subtitle: Text(_parseCommentTime(widget.comment.time),
        style: const TextStyle(color: Colors.grey)),
    leading: CircleAvatar(
      backgroundImage: NetworkImage("$apiPrefix${widget.comment.avatar}"),
      backgroundColor: Colors.transparent,
    ),
  );

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    isLiked = await Api.likeOrCancelLike(widget.comment.id, isLiked);
    return isLiked;
  }

  Widget _likeBtn() => FutureBuilder(
      future: isLiked,
      builder: (context, snapshot) => LikeButton(
    size: 20,

    isLiked: snapshot.data ?? false,
    likeCount: widget.comment.like,
    onTap: onLikeButtonTapped,
  ));

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _tile(),
      Row(children: [
        Text(widget.comment.content, style: const TextStyle(color: Colors.black))
      ]),
      const SizedBox(height: 20),
      Row(
        children: [_likeBtn()],
      )
    ],
  );
}
