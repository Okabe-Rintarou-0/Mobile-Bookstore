// To parse this JSON data, do
//
//     final bookCommentsSnapshot = bookCommentsSnapshotFromJson(jsonString);

import 'dart:convert';

BookCommentsSnapshot bookCommentsSnapshotFromJson(String str) =>
    BookCommentsSnapshot.fromJson(json.decode(str));

String bookCommentsSnapshotToJson(BookCommentsSnapshot data) =>
    json.encode(data.toJson());

class BookCommentsSnapshot {
  BookCommentsSnapshot({
    this.numComments = 0,
    this.hotComments = const [],
  });

  int numComments;
  List<Comment> hotComments;

  factory BookCommentsSnapshot.fromJson(Map<String, dynamic> json) {
    var s = BookCommentsSnapshot(
      numComments: json["numComments"],
      hotComments: json["hotComments"] == null
          ? []
          : List<Comment>.from(
              json["hotComments"].map((x) => Comment.fromJson(x))),
    );
    return s;
  }

  Map<String, dynamic> toJson() => {
        "numComments": numComments,
        "hotComments": List<dynamic>.from(hotComments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.reply,
    required this.content,
    required this.avatar,
    required this.nickname,
    required this.username,
    required this.time,
    required this.like,
    required this.dislike,
    required this.subComments,
  });

  String id;
  String reply;
  String content;
  String avatar;
  String nickname;
  String username;
  int time;
  int like;
  int dislike;
  List<Comment> subComments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        reply: json["reply"],
        content: json["content"],
        avatar: json["avatar"],
        nickname: json["nickname"],
        username: json["username"],
        time: json["time"],
        like: json["like"],
        dislike: json["dislike"],
        subComments: json["subComments"] == null
            ? []
            : List<Comment>.from(
                json["subComments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reply": reply,
        "content": content,
        "avatar": avatar,
        "username": username,
        "time": time,
        "like": like,
        "nickname": nickname,
        "dislike": dislike,
        "subComments": List<dynamic>.from(subComments.map((x) => x.toJson())),
      };
}
