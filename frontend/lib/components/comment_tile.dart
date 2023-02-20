import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});

  final Comment comment;

  String _parseCommentTime(DateTime time) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(time);
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
            Text(comment.username, style: const TextStyle(color: Colors.black)),
        subtitle: Text(_parseCommentTime(comment.time),
            style: const TextStyle(color: Colors.grey)),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(comment.avatar),
          backgroundColor: Colors.transparent,
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _tile(),
          Row(children: [
            Text(comment.content, style: const TextStyle(color: Colors.black))
          ])
        ],
      );
}
